import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/followers_manual_add.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/new_messages.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import 'chats.dart';

class ConnectionMesg extends StatefulWidget {
  final bool? hasBack;
  const ConnectionMesg({super.key, this.hasBack=true});

  @override
  State<ConnectionMesg> createState() => _ConnectionMesgState();
}

class _ConnectionMesgState extends State<ConnectionMesg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Messages', centerTitle: true,haveBackButton:widget.hasBack?? false,actions: widget.hasBack==false?[]:null),
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
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          contentvPad: 5,
                          hint: 'Search Conversations',
                          prefixIcon: Image.asset(
                            Assets.imagesSearch,
                            width: 12,
                          ),
                          marginBottom: 0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      circular_icon_container(
                        ontap: () {
                          Get.to(()=>NewMessages());
                        },
                        icon: Assets.imagesMesg2,
                        size: 45,
                        iconSize: 22,
                      )
                    ],
                  ),
                  ////////
                  ///
               SizedBox(height: 23,),
                    ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child:    manual_add_row(
                       ontap: (){
                           Get.to(()=>Chats(
                            isGroup: index==3?true:false,
                            title: index==3?'Cy & Erik':'Cy Tidwell',
                           ));
                       }, 
                    img: Assets.imagesDummyimage2,
                    text1:index==3?'Cy & Erik' :'Cy Tidwell',
                    color2: kblack,
                    color1: kblack,
                    size1:15,
                    size2: 11,
                    text2: 'Sub broseph',
                    isButton: false,
                    mbot: 4,
                    weight2: FontWeight.normal,
                  ),
                    );
                  },
                ),

                ],
              ),
            ),
          ],
        ));
  }
}
