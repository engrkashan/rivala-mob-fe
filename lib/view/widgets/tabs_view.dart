import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';


class TabsWidget extends StatefulWidget {
  const TabsWidget({
    super.key,
    required this.currentindex,
    this.ontap,
    required this.items,
    this.isexpanded,
    this.height,
  });

  final int currentindex;
  final void Function(int)? ontap; // Allow ontap to receive the index
  final List<String> items;
  final bool? isexpanded;
  final double? height;

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

int current = 0;

class _TabsWidgetState extends State<TabsWidget> {
  void _onTap(int index) {
    if (widget.ontap != null) {
      widget.ontap!(index); // Pass index to ontap callback
    } else {
      setState(() {
        current = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isexpanded == false
        ? Container(
            height: widget.height ?? 40,
            margin: EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
             color: ktransparent,
             border: Border.all(color: ktransparent) 
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.items.length,
                      (index) {
                        return GestureDetector(
                          onTap: () => _onTap(index),
                          child: AnimatedContainer(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            duration: const Duration(milliseconds: 300),
                            height: Get.height,
                            decoration: BoxDecoration(
                             color: widget.currentindex == index?ksecondary:ktransparent,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: widget.currentindex == index
                                        ? ktransparent
                                        : ktransparent)
                                // color: ktransparent,
                                ),
                            child: Center(
                              child: MyText(
                                text: widget.items[index],
                                paddingLeft: 7,
                                paddingRight: 7,
                                size: 13,
                                weight: FontWeight.w500,
                                color: widget.currentindex == index
                                    ? kwhite
                                    : kblack,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
            child: Container(
              height: widget.height ?? 50,
              margin: EdgeInsets.only(bottom: 4),
              decoration:   BoxDecoration(
             color:ktransparent,
             border: Border.all(color: ktransparent) 
            ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: List.generate(
                        widget.items.length,
                        (index) {
                          return Expanded(
                            child: GestureDetector(
                          onTap: () => _onTap(index),
                          child: AnimatedContainer(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            duration: const Duration(milliseconds: 300),
                            height: Get.height,
                            decoration: BoxDecoration(
                             color: widget.currentindex == index?ksecondary:ktransparent,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: widget.currentindex == index
                                        ? ktransparent
                                        : ktransparent)
                                // color: ktransparent,
                                ),
                            child: Center(
                              child: MyText(
                                text: widget.items[index],
                                paddingLeft: 7,
                                paddingRight: 7,
                                size: 13,
                                weight: FontWeight.w500,
                                color: widget.currentindex == index
                                    ? kwhite
                                    : kblack,
                              ),
                            ),
                          ),
                        )
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
/////


class MyTabbar extends StatelessWidget {
  final TabController? controller;
  final bool? hasborder;
  final double? indicatorpadd;
  const MyTabbar({super.key, required this.items, this.controller, this.hasborder=false, this.indicatorpadd});
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(vertical:7),
      decoration:
               BoxDecoration(
             color:ktransparent,
             border: Border.all(color: ktransparent) 
            ),
      child: TabBar(
        
        isScrollable: hasborder==true?true: false,
        tabAlignment:hasborder==true? TabAlignment.start:null,
        automaticIndicatorColorAdjustment: false,
        labelColor:hasborder==true?ksecondary: kwhite,
        unselectedLabelColor:hasborder==true?ktertiary:kblack,
        labelStyle: TextStyle(
            fontSize: 14,
            fontWeight:hasborder==true?FontWeight.w400: FontWeight.w500,
            fontFamily: AppFonts.poppins,
            color:hasborder==true?ksecondary: kwhite),
        unselectedLabelStyle: TextStyle(
            fontSize: 14,
     fontWeight:    hasborder==true?FontWeight.w400: FontWeight.w500,
            fontFamily: AppFonts.poppins,
            color: hasborder==true?ktertiary:kblack),
        //isScrollable: true,
        // tabAlignment: TabAlignment.start,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(0),
        indicatorPadding: EdgeInsets.symmetric(horizontal: hasborder==true?20:indicatorpadd??0),
        labelPadding: EdgeInsets.symmetric(horizontal: hasborder==true?10:0),
        controller: controller,
        indicatorSize:hasborder==F?TabBarIndicatorSize.tab: TabBarIndicatorSize.label,
        indicator:     hasborder==false?    BoxDecoration(
             color:ksecondary,
             borderRadius: BorderRadius.circular(8),
             border: Border.all(color: ktransparent) 
            ):null,
        dividerColor: ktransparent,
        indicatorColor:hasborder==true?ksecondary: ktransparent,
        //      labelPadding: EdgeInsets.symmetric(horizontal: 3),
        tabs: List.generate(
          items.length,
          (index) => Tab(
            iconMargin: EdgeInsets.all(0),
            text: items[index],
          ),
        ),
      ),
    );
  }
}