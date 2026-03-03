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
  String? selectedGender;

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
              primary: kblue,
              onPrimary: kwhite,
              onSurface: kblack,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        birthday.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

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
                              onChanged: (val) {
                                if (val != null && val != '(Optional)') {
                                  current?.owner?.gender = val;
                                }
                                current?.owner?.gender = val;
                              }),
                          MyTextField(
                            hint: "MM/DD/YYYY",
                            label: 'Birthday',
                            filledColor: kblack.withOpacity(0.05),
                            suffixIcon: Image.asset(
                              Assets.imagesCalender,
                              width: 20,
                              height: 20,
                            ),
                            delay: 1200,
                            readOnly: true,
                            ontapp: () => _selectDate(context),
                            bordercolor: ktransparent,
                            controller: birthday,
                          ),
                          MyTextField(
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
                              final mediaProvider =
                                  context.read<MediaProvider>();
                              if (mediaProvider.selectedImage != null) {
                                await mediaProvider.upload();
                              }

                              DateTime? parsedBirthday;
                              if (birthday.text.isNotEmpty) {
                                try {
                                  // Expecting MM/DD/YYYY format from the picker if used
                                  final parts = birthday.text.split('/');
                                  if (parts.length == 3) {
                                    parsedBirthday = DateTime(
                                        int.parse(parts[2]),
                                        int.parse(parts[0]),
                                        int.parse(parts[1]));
                                  }
                                } catch (e) {
                                  print("Error parsing birthday: $e");
                                }
                              }

                              await store.updateStore(StoreModel(
                                  id: current?.id,
                                  name: name.text.trim().isEmpty
                                      ? current?.name
                                      : name.text.trim(),
                                  logoUrl: mediaProvider.uploadedUrl ??
                                      current?.logoUrl,
                                  owner: UserModel(
                                    username: username.text.trim().isEmpty
                                        ? current?.owner?.username
                                        : username.text.trim(),
                                    email: email.text.trim().isEmpty
                                        ? current?.owner?.email
                                        : email.text.trim(),
                                    bio: bio.text.trim().isEmpty
                                        ? current?.owner?.bio
                                        : bio.text.trim(),
                                    birthday: parsedBirthday ??
                                        current?.owner?.birthday,
                                    gender: current?.owner?.gender,
                                    
                                  )));
                              if (mounted) Navigator.pop(context);
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final storeProvider = context.read<BrandsProvider>();
      _populateFields(storeProvider.currentStore);
      await storeProvider.loadCurrentStore();
      _populateFields(storeProvider.currentStore);
    });
  }

  void _populateFields(StoreModel? current) {
    if (current == null) return;
    if (name.text.isEmpty) name.text = current.name ?? '';
    if (username.text.isEmpty) username.text = current.owner?.username ?? '';
    if (email.text.isEmpty) email.text = current.owner?.email ?? '';
    if (bio.text.isEmpty) bio.text = current.owner?.bio ?? '';
    if (birthday.text.isEmpty && current.owner?.birthday != null) {
      birthday.text =
          "${current.owner!.birthday!.month.toString().padLeft(2, '0')}/${current.owner!.birthday!.day.toString().padLeft(2, '0')}/${current.owner!.birthday!.year}";
    }
  }
}
