import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
            title: 'Terms & conditions',
            centerTitle: true,
            actions: [
              Bounce_widget(
                  widget: Image.asset(
                Assets.imagesClose,
                width: 20,
                height: 20,
              )),
              SizedBox(
                width: 12,
              )
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kgrey2,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  MyText(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet laoreet lacus, et condimentum diam. Duis bibendum purus ac dolor viverra lacinia. Nam pretium nisl vel dapibus pulvinar. Duis est lectus, imperdiet quis tempor vel, aliquet a lorem. Nullam maximus mauris sagittis orci dictum accumsan. Cras posuere vehicula lacus id consectetur. Vestibulum lobortis risus eu magna dignissim sollicitudin. Integer malesuada justo ac malesuada rutrum. Quisque euismod tincidunt tortor, semper suscipit nisl. Vestibulum scelerisque consequat commodo.\n\nMauris non nibh vitae ipsum laoreet cursus at id diam. Sed ac magna accumsan, consequat urna et, fringilla enim. Vestibulum vel dignissim mi. Nulla consectetur viverra varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum, turpis vel molestie porttitor, urna justo ultricies mi, a ullamcorper diam est eu elit. Nulla sed sodales ex. Mauris porttitor hendrerit nisl non egestas. Quisque nunc ligula, semper non tellus vel, convallis ultricies odio. Suspendisse at vehicula turpis. Pellentesque nec ullamcorper purus. Integer mattis metus vel ex vulputate lacinia. Nunc vehicula nisi ac tincidunt pulvinar. Cras vitae quam quis risus commodo maximus sed id diam. Nullam non odio mauris. Duis diam purus, rutrum quis bibendum et, maximus ac libero.',
                    size: 14,
                    color: kblack2,
                  ),
                  SizedBox(height: 40,)
                ],
              ),
            ),
          ],
        ));
  }
}
