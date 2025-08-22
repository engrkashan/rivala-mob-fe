import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/set_account.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/squad_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class SquadDetail extends StatefulWidget {
  const SquadDetail({super.key});

  @override
  State<SquadDetail> createState() => _SquadDetailState();
}

class _SquadDetailState extends State<SquadDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Weekend Warriors', centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
               
                   EditImgStack(),
                      SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    label: 'Squad Name',
                    hint: 'American Fork Football 2025',
                    filledColor: kblack.withOpacity(0.04),
                    bordercolor: ktransparent,
                    suffixIcon: MyText(
                      text: '20/100',
                      color: ktertiary,
                    ),
                  ),
                  MyTextField(
                    label: 'Summary',
                    hint:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                    filledColor: kblack.withOpacity(0.04),
                    bordercolor: ktransparent,
                    maxLines: 5,
                    delay: 250,
                    suffixIcon: SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MyText(
                                text: '20/100',
                                color: ktertiary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  squad_members_container(),
                  SizedBox(height: 15,),
                  squad_seller(),
                  SizedBox(height: 15,),
                  squad_seller(
                    isProduct: true,
                  ),
                  SizedBox(height: 40,),

                  MyButton(
                    buttonText: 'Delete Squad',
                    backgroundColor: kred,
                    fontColor: kwhite,
                    mBottom: 50,
                  )

                ],
              ),
            ),
          ],
        ));
  }
}
