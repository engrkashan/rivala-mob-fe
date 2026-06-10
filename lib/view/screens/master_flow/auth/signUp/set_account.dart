import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/media_provider.dart';
import 'package:rivala/controllers/providers/user/auth_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/main.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/verify_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import '../../../../../config/network/session.dart';

class MasterAccountSet extends StatefulWidget {
  const MasterAccountSet({super.key});

  @override
  State<MasterAccountSet> createState() => _MasterAccountSetState();
}

class _MasterAccountSetState extends State<MasterAccountSet> {
  @override
  void initState() {
    super.initState();
    _emailCon.addListener(_checkEmail);
    _loadSavedData(); // Data load karna
  }

  Future<void> _loadSavedData() async {
    final session = Session();
    final data = await session.getPersonalInfo();

    setState(() {
      _nameCon.text = data["name"] ?? '';
      _usernameCon.text = data["username"] ?? '';
      _emailCon.text = data["email"] ?? '';
      _bioCon.text = data["bio"] ?? '';
    });
  }
  final _birthdayCon = TextEditingController();
  final _nameCon = TextEditingController();
  final _usernameCon = TextEditingController();
  final _emailCon = TextEditingController();
  final _bioCon = TextEditingController();
  final _passwordCon = TextEditingController();
  final _confirmPasswordCon = TextEditingController();
  bool _isObSecure = true;
  String? _passwordError;
  void _checkEmail() {
    final authProvider = context.read<AuthProvider>();
    authProvider.checkEmailAvailability(_emailCon.text.trim());
  }
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least 1 uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least 1 number";
    }
    // Optional: Special character
    // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    //   return "Password must contain at least 1 special character";
    // }
    return null;
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ksecondary,
              onPrimary: kwhite,
              onSurface: kblack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ksecondary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthdayCon.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }
  @override
  void dispose() {
    _emailCon.dispose();
    _passwordCon.dispose();
    _confirmPasswordCon.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Stack(
      children: [
        Scaffold(
            backgroundColor: kwhite,
            appBar: simpleAppBar(
                context: context,
                title: 'Personal Info',
                centerTitle: true,
                actions: [
                  Bounce_widget(
                      ontap: () {
                        Get.back();
                      },
                      widget: Image.asset(
                    Assets.imagesClose,
                    width: 18,
                    height: 18,
                  )),
                  SizedBox(
                    width: 12,
                  )
                ]),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 22),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      EditImgStack(
                        imageUrl: auth.user?.avatarUrl,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      MyTextField(
                        controller: _nameCon,
                        hint: 'Enter your name',
                        label: 'Name',
                        suffixIcon: Image.asset(
                          Assets.imagesEdit,
                          width: 20,
                          height: 20,
                        ),
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return "Name cannot be empty";
                          }
                          return null;
                        },
                        delay: 200,
                        filledColor: kblack.withOpacity(0.05),
                        bordercolor: ktransparent,
                      ),
                      MyTextField(
                        controller: _usernameCon,
                        hint: 'Enter username',
                        label: 'Handle',
                        suffixIcon: Image.asset(
                          Assets.imagesEdit,
                          width: 20,
                          height: 20,
                        ),
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        delay: 400,
                        filledColor: kblack.withOpacity(0.05),
                        bordercolor: ktransparent,
                      ),
                      MyTextField(
                        controller: _emailCon,
                        hint: 'Enter your email address',
                        label: 'Email Address',
                        errorText: auth.emailError,
                        suffixIcon: Image.asset(Assets.imagesEdit, width: 20, height: 20),
                        delay: 600,
                        filledColor: kblack.withOpacity(0.05),
                        bordercolor: ktransparent,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _checkEmail(),
                        onEditingComplete: _checkEmail,
                      ),
                      MyTextField(
                        controller: _passwordCon,
                        hint: 'Enter password',
                        label: 'Password',
                        isObSecure: _isObSecure,
                        suffixIcon: Icon(
                          _isObSecure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        suffixTap: () {
                          setState(() => _isObSecure = !_isObSecure);
                        },
                        errorText: _passwordError,                    // ← Error show hoga
                        onChanged: (value) {
                          setState(() {
                            _passwordError = _validatePassword(value);
                          });
                        },
                        delay: 700,
                        filledColor: kblack.withOpacity(0.05),
                        bordercolor: ktransparent,
                      ),
                      MyTextField(
                        controller: _birthdayCon,
                        hint: 'Select your birthday',
                        label: 'Birthday',
                        readOnly: true,
                        ontapp: () => _selectDate(context),
                        filledColor: kblack.withOpacity(0.05),
                        suffixIcon: Image.asset(
                          Assets.imagesCalender,
                          width: 20,
                          height: 20,
                        ),
                        delay: 800,
                        bordercolor: ktransparent,
                      ),
                      MyTextField(
                        controller: _bioCon,
                        hint: 'Enter a short bio for your store',
                        label: 'Store Bio',
                        suffixIcon: Image.asset(
                          Assets.imagesEdit,
                          width: 20,
                          height: 20,
                        ),
                        delay: 1000,
                        maxLines: 4,
                        filledColor: kblack.withOpacity(0.05),
                        bordercolor: ktransparent,
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
                MyButton(
                  buttonText: 'Save info',
                  mBottom: 40,
                  mhoriz: 22,
                  onTap: () async {
                    if (auth.emailError != null) {
                      AlertInfo.show(context: context, text: auth.emailError!);
                      return;
                    }
                    String? uploadedAvatarUrl;
                    if (Provider.of<MediaProvider>(context, listen: false)
                            .selectedImage !=
                        null) {
                      await Provider.of<MediaProvider>(context, listen: false)
                          .upload();
                      uploadedAvatarUrl =
                          Provider.of<MediaProvider>(context, listen: false)
                              .uploadedUrl;
                    }
                    await auth.registerUser(
                        name: _nameCon.text.trim(),
                        username: _usernameCon.text.trim(),
                        email: _emailCon.text.trim(),
                        password: _passwordCon.text.trim(),
                        birthday: _birthdayCon.text.trim(),
                        bio: _bioCon.text.trim(),
                        avatarUrl: uploadedAvatarUrl);
                    print("Auth error in set Account: ${auth.error}");
                    if (auth.error != null && auth.error!.isNotEmpty) {
                      AlertInfo.show(context: context, text: auth.error ?? "");
                      return;
                    }
                    await auth.sentOtp(identifier: _emailCon.text.trim());

                    Get.to(() => MasterVerifyAccount());
                    await Session().savePersonalInfo(
                      name: _nameCon.text.trim(),
                      username: _usernameCon.text.trim(),
                      email: _emailCon.text.trim(),
                      bio: _bioCon.text.trim(),
                    );
                    // Get.to(() => GradientSuccessScreen(
                    //       title: 'Well done',
                    //       desc: 'Now let’s select your theme.',
                    //       buttontext: 'Choose your theme',
                    //       ontap: () {
                    //         Get.to(() => SelectTheme());
                    //       },
                    //       skipTap: () {
                    //         Get.back();
                    //         Get.to(() => GradientSuccessScreen(
                    //               title: 'Well done!',
                    //               desc: 'Now, let’s import your links.',
                    //               buttontext: 'Import your links',
                    //               ontap: () {
                    //                 Get.to(() => MasterCreateLink());
                    //               },
                    //               skipTap: () {
                    //                 Get.to(() => MAsterLinkSuccess());
                    //               },
                    //             ));
                    //       },
                    //     ));
                  },
                )
              ],
            )),
        if (auth.isLoading ||
            Provider.of<MediaProvider>(context, listen: false).isLoading)
          Container(
            color: Colors.grey.withOpacity(0.2),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}

class EditImgStack extends StatefulWidget {
  final String? imageUrl;
  EditImgStack({
    super.key,
    this.imageUrl,
  });

  @override
  State<EditImgStack> createState() => _EditImgStackState();
}

class _EditImgStackState extends State<EditImgStack> {
  @override
  Widget build(BuildContext context) {
    final media = context.watch<MediaProvider>();
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          media.selectedImage == null && widget.imageUrl == null
              ? Container(
                  width: 109,
                  height: 109,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                )
              : CommonImageView(
                  url: media.selectedImage == null
                      ? (widget.imageUrl ?? dummyImage)
                      : null,
                  file: media.selectedImage,
                  width: 109,
                  height: 109,
                  radius: 100,
                ),
          Positioned(
              bottom: -15,
              left: -6,
              child: Bounce_widget(
                  ontap: () {
                    media.pickImage();
                  },
                  widget: Image.asset(
                    Assets.imagesReplace,
                    width: 54,
                    height: 54,
                  )))
        ],
      ),
    );
  }
}
