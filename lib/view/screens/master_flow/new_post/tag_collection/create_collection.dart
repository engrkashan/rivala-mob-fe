import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class CreateCollection extends StatefulWidget {
  const CreateCollection({super.key});

  @override
  State<CreateCollection> createState() => _CreateCollectionState();
}

class _CreateCollectionState extends State<CreateCollection> {
  final List suggestions = ['Fall Fashion', 'Hidden Gems', 'Jackets'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
            title: 'Create collection',
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
                  MyTextField(
                    hint: 'Add....',
                    label: 'Collection title',
                    radius: 50,
                  ),
                    

                  MyText(
                    paddingTop: 20,
                    text: 'Or select a suggestion',
                    size: 14,
                    fontStyle: FontStyle.italic,
                    paddingBottom: 10,
                  ),
              
                  Wrap(
                    spacing: 8, // Horizontal space between items
                    runSpacing: 8, // Vertical space between rows
                    children: List.generate(suggestions.length, (index) {
                      return CustomeContainer(
                        radius: 50,
                        borderColor: ktertiary,
                        vpad: 3,
                        hpad: 10,
                        widget: row_widget(
                          textColor: ktertiary,
                          title: suggestions[index],
                          iconColor: ktertiary,
                          icon: Assets.imagesCollection2,
                          iconSize: 11,
                          texSize: 13,
                          weight: FontWeight.normal,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    hint: 'Share a description . . . ',
                    label: 'Description',
                    radius: 25,
                    maxLines: 4,
                  ),
                  
                  MyText(
                    paddingTop: 15,
                    text: 'Squad Members',
                    size: 14,
                    weight: FontWeight.w500,
                    paddingBottom: 10,
                  ),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Bounce_widget(widget: Image.asset(Assets.imagesDottedadd,width: 36,height: 36,)),
                 MyText(
                  color: kblue,
                  weight: FontWeight.w500,
                    text: '+ Invite friends',
                    size: 14,
               
                  ),
               ],)
                ],
              ),
            ),
            Mybutton2(
              buttonText2: 'Cancel',
              buttonText: 'Save Collection',
              mbot: 30,
              hpad: 22,
            )
          ],
        ));
  }
}
