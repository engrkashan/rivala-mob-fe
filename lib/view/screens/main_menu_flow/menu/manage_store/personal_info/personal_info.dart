import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/store_model.dart';
import 'package:rivala/models/user_model.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/set_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import '../../../../../../controllers/providers/brands_provider.dart';
import '../../../../../../controllers/providers/media_provider.dart';
import '../../../../../widgets/my_button.dart';

class ManagePersonalInfo extends StatefulWidget {
  const ManagePersonalInfo({super.key});

  @override
  State<ManagePersonalInfo> createState() => _ManagePersonalInfoState();
}

class _ManagePersonalInfoState extends State<ManagePersonalInfo> {
  final username = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final bio = TextEditingController();
  final birthday = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Personal Info',
            centerTitle: true,
            actions: [
              Bounce_widget(
                  widget: Image.asset(
                Assets.imagesClose,
                width: 18,
                height: 18,
              )),
              SizedBox(
                width: 12,
              )
            ]),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Consumer<BrandsProvider>(
                    builder: (context, store, _) {
                      final current = store.currentStore;
                      return ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 22),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          EditImgStack(
                            imageUrl: current?.logoUrl,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          MyTextField(
                            controller: name,
                            hint: current?.name,
                            label: 'Name',
                            suffixIcon: Image.asset(
                              Assets.imagesEdit,
                              width: 20,
                              height: 20,
                            ),
                            delay: 200,
                            filledColor: kblack.withOpacity(0.05),
                            bordercolor: ktransparent,
                          ),
                          MyTextField(
                            controller: username,
                            hint: current?.owner?.username,
                            label: 'Handle',
                            suffixIcon: Image.asset(
                              Assets.imagesEdit,
                              width: 20,
                              height: 20,
                            ),
                            delay: 400,
                            filledColor: kblack.withOpacity(0.05),
                            bordercolor: ktransparent,
                          ),
                          MyTextField(
                            controller: email,
                            hint: current?.owner?.email,
                            label: 'Email Address',
                            suffixIcon: Image.asset(
                              Assets.imagesEdit,
                              width: 20,
                              height: 20,
                            ),
                            delay: 600,
                            filledColor: kblack.withOpacity(0.05),
                            bordercolor: ktransparent,
                          ),
                          CustomDropDown(
                              label: 'Gender',
                              delay: 1000,
                              hint: '(Optional)',
                              items: ['(Optional)', 'Male', 'Female'],
                              selectedValue:
                                  current?.owner?.gender ?? '(Optional)',
                              onChanged: (w) {}),
                          MyTextField(
                            hint:
                                "${current?.owner?.birthday?.year}/${current?.owner?.birthday?.month}/${current?.owner?.birthday?.day}",
                            label: 'Birthday',
                            filledColor: kblack.withOpacity(0.05),
                            suffixIcon: Image.asset(
                              Assets.imagesCalender,
                              width: 20,
                              height: 20,
                            ),
                            delay: 1200,
                            bordercolor: ktransparent,
                            controller: birthday,
                          ),
                          MyTextField(
                            hint: current?.owner?.bio,
                            label: 'Store Bio',
                            controller: bio,
                            suffixIcon: Image.asset(
                              Assets.imagesEdit,
                              width: 20,
                              height: 20,
                            ),
                            delay: 1400,
                            maxLines: 4,
                            filledColor: kblack.withOpacity(0.05),
                            bordercolor: ktransparent,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MyButton(
                            buttonText: 'Update info',
                            mBottom: 40,
                            mhoriz: 22,
                            onTap: () async {
                              await store.updateStore(StoreModel(
                                  name: name.text.trim(),
                                  logoUrl: context
                                          .read<MediaProvider>()
                                          .uploadedUrl ??
                                      current?.logoUrl,
                                  owner: UserModel(
                                    username: username.text.trim(),
                                    email: email.text.trim(),
                                    bio: bio.text.trim(),
                                  )));
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            if (context.watch<BrandsProvider>().isLoading)
              Container(
                color: kblack.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: kblue,
                  ),
                ),
              )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BrandsProvider>().loadCurrentStore();
    });
  }
}
