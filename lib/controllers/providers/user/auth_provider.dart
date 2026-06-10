import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rivala/main.dart';
import 'package:rivala/models/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../config/network/endpoints.dart';
import '../../../view/screens/master_flow/auth/signIn/signin.dart';
import '../../repos/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepo = locator<AuthRepo>();
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  bool _isLoading = false;
  bool _isLoggedIn = false;
  UserModel? _user;
  UserModel? get user => _user;
  String _phone = '';
  String? _error;

  String get phone => _phone;
  String? get error => _error;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String _currentUserId = '';
  String get currentUserId => _currentUserId;
// ==================== Email Check ====================
  String? _emailError;
  String? get emailError => _emailError;

  Timer? _emailDebounce;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void setUserId(String val) {
    _currentUserId = val;
    notifyListeners();
  }

  Future<void> checkEmailAvailability(String email) async {
    if (email.isEmpty || email.length < 5) {
      _emailError = null;
      notifyListeners();
      return;
    }

    _emailDebounce?.cancel();

    _emailDebounce = Timer(const Duration(milliseconds: 600), () async {
      try {
        print("Checking email: $email");
        final exists = await _authRepo.checkEmailExists(email);
        print("API Response - Exists: $exists"); // API response log

        _emailError = exists ? "This email is already taken" : null;
      } catch (e) {
        print("Email check error: $e");
        _emailError = null;
      }
      notifyListeners();
    });
  }

//   ========register==============
  Future<void> registerUser(
      {required String name,
      required String username,
      required String email,
      required String password,
      String? birthday,
      String? bio,
      String? avatarUrl}) async {
    setLoading(true);
    notifyListeners();

    final body = {
      "name": name,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
      "birthday": birthday,
      "bio": bio,
      "avatarUrl": avatarUrl
    };

    try {
      _user = await _authRepo.register(data: body);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _user = null;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

//   =========login===========
  Future<void> login(
      {required String identifier, required String password}) async {
    setLoading(true);
    notifyListeners();
    try {
      _user = await _authRepo.login(identifier: identifier, password: password);
      _error = null;
      setUserId(_user!.id!);
    } catch (e) {
      _error = e.toString();
      _user = null;
    } finally {
      setLoading(false);
      setLoggedIn(true);
      notifyListeners();
    }
  }

//   =========logout============
  Future<void> logout() async {
    setLoading(true);
    notifyListeners();
    try {
      await _authRepo.logout(); // Agar API 400 ya 404 degi, toh ye catch mein jayega


      _user = null;
      setLoggedIn(false);
      notifyListeners();
      Get.offAll(() => const MasterSignIn());

    } catch (e) {
      _error = e.toString();

      Get.snackbar("Logout Failed", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> verifyEmail({required String otp}) async {
    setLoading(true);

    try {
      await _authRepo.verifySellerEmail(otp: otp);

      _error = null;
    } catch (e) {
      _error = e.toString();

      print("VERIFY ERROR: $_error");
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> sentOtp({required String identifier}) async {
    setLoading(true);
    _error = null;
    try {
      await _authRepo.resendSellerOtp(identifier: identifier);

      print("😇OTP sent successfully to: $identifier");
    } catch (e) {
      print("OTP Error Exception: $e");
      _error = e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> handleSocialLogin(String provider, String token) async {
    setLoading(true);
    try {
      String endpoint;
      if (provider == 'google') {
        endpoint = Endpoints.socialLoginGoogle;
      } else if (provider == 'apple')
        endpoint = Endpoints.socialLoginApple;
      else
        endpoint = Endpoints.socialLoginMicrosoft;

      _user = await _authRepo.socialLogin(endpoint, token);
      _error = null;
      setLoggedIn(true);
      setUserId(_user!.id!);
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    setLoading(true);

    try {
      print("STEP 1: Google Sign In Start");

      await GoogleSignIn.instance.initialize();

      print("STEP 2: Initialize Complete");

      final GoogleSignInAccount user =
          await GoogleSignIn.instance.authenticate();

      print("STEP 3: User Selected");
      print("Email: ${user.email}");

      final auth = user.authentication;

      print("STEP 4: Authentication Complete");
      print("ID Token: ${auth.idToken}");

      if (auth.idToken != null) {
        await handleSocialLogin(
          'google',
          auth.idToken!,
        );

        print("STEP 5: Backend Login Success");
      }
    } catch (e, stackTrace) {
      print("GOOGLE LOGIN ERROR:");
      print(e);
      print(stackTrace);

      _error = e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> signInWithApple() async {
    setLoading(true);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken != null) {
        await handleSocialLogin(
          'apple',
          credential.identityToken!,
        );
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> signInWithMicrosoft() async {
    setLoading(true);

    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          'MICROSOFT_CLIENT_ID',
          'com.rivala://oauth',
          discoveryUrl:
              'https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration',
          scopes: [
            'openid',
            'profile',
            'email',
          ],
        ),
      );

      if (result.accessToken != null) {
        await handleSocialLogin(
          'microsoft',
          result.accessToken!,
        );
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
