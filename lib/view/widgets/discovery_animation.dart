import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';

class DiscoveryAnimation extends StatefulWidget {
  const DiscoveryAnimation({super.key});

  @override
  State<DiscoveryAnimation> createState() => _DiscoveryAnimationState();
}

class _DiscoveryAnimationState extends State<DiscoveryAnimation>with SingleTickerProviderStateMixin {
    List<String> imagePaths1 = [
    Assets.imagesA6,
    Assets.imagesA7,
    Assets.imagesA8,
    Assets.imagesA9,
    Assets.imagesA10,
    Assets.imagesA1,
    Assets.imagesA2,
    Assets.imagesA3,
    Assets.imagesA4,
    Assets.imagesA5,
  ];

  List<String> imagePaths2 = [
    Assets.imagesA1,
    Assets.imagesA2,
    Assets.imagesA3,
    Assets.imagesA4,
    Assets.imagesA5,
    Assets.imagesA6,
    Assets.imagesA7,
    Assets.imagesA8,
    Assets.imagesA9,
    Assets.imagesA10,
  ];
  late ScrollController _scrollController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startScrolling();
  }

  void _startScrolling() {
    const double scrollSpeed = 2.5;
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentScroll + scrollSpeed,
            duration: Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Row(
                      children: List.generate(10, (index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: index.isEven ? 38 : 0,
                            bottom: index.isOdd ? 38 : 0,
                          ),
                          child: Column(
                            children: [
                              CommonImageView(
                                imagePath: imagePaths1[index],
                                width: 116,
                                height: 146,
                                radius: 15,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 11),
                              CommonImageView(
                                imagePath: imagePaths2[index],
                                width: 116,
                                height: 146,
                                radius: 15,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
  }
}