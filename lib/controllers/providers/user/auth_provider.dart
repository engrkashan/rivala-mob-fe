import 'package:flutter/cupertino.dart';
import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/main.dart';
import 'package:rivala/models/user_model.dart';

import '../../repos/auth_repo.dart';
import '../media_provider.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepo = locator<AuthRepo>();
  final _mediaProvider = locator<MediaProvider>();

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

//   ========register==============
  Future<void> registerUser(
      {required String name,
      required String username,
      required String email,
      required String password,
      String? birthday,
      String? bio}) async {
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
      "avatarUrl": _mediaProvider.uploadedUrl
    };

    try {
      _user = await _authRepo.register(data: body);
      _error = null;
    } catch (e) {
      if (e is ApiException) {
        _error = e.message;
      } else {
        _error = "Something went wrong";
      }
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
      await _authRepo.logout();
      _user = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
      setLoggedIn(false);
      notifyListeners();
    }
  }

  Future<void> verifyEmail({required String otp}) async {
    try {
      _authRepo.verifySellerEmail(otp: otp);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
  }
}
