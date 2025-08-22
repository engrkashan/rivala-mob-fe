import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:video_player/video_player.dart';

class CommonVideoView extends StatefulWidget {
  const CommonVideoView(
      {super.key,
      this.url,
      this.file,
      this.isReel,
      required this.startPlaying});
  final String? url;
  final String? file;
  final bool? isReel;
  final bool startPlaying;
  @override
  State<CommonVideoView> createState() => _CommonVideoViewState();
}
class _CommonVideoViewState extends State<CommonVideoView> {
  RxBool _isVideoPlaying = false.obs;
  late VideoPlayerController controller;
  @override
  void initState() {
    if (widget.url != null) {
      controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!));
    } else if (widget.file != null) {
      controller = VideoPlayerController.file(File(widget.file!));
    }
    if (widget.startPlaying == true) {
      controller.initialize().then((value) {
        setState(() {
          controller.play();
          _isVideoPlaying.value = true;
        });
      });
    } else {
      controller.initialize();
    }
    controller.setLooping(false);
    super.initState();
  }
  void _pausePlayVideo() {
    _isVideoPlaying.value ? controller.pause() : controller.play();
    _isVideoPlaying.value = !_isVideoPlaying.value;
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
        //GestureDetector(
        // onTap: () => {_pausePlayVideo()},
        //  child:
        Stack(alignment: Alignment.center, children: [
      Center(child: buildVideo()),
      widget.isReel == true
          ? IconButton(
              onPressed: () => {
                    _pausePlayVideo(),
                  },
              icon: Obx(
                () => Icon(
                  CupertinoIcons.play_circle_fill,
                  color: ksecondary
                      .withOpacity(_isVideoPlaying.value ? 0 : 0.5),
                  size: 60,
                ),
              ))
          : SizedBox()
    ]);
    //);
  }
  Widget buildVideo() => buildVideoPlayer();
  Widget buildVideoPlayer() => controller.value.isInitialized
      ? AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller))
      : const CircularProgressIndicator(
          color: ksecondary,
          backgroundColor: kwhite,
        );
}









