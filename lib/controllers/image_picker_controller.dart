import 'dart:io';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rivala/view/screens/master_flow/new_post/select_post_filters.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as path;

// class ImagePickerController extends GetxController {
//   var selectedImages = <File>[].obs;

//   Future<void> pickMultipleImages() async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.image,
//     );

//     if (result != null && result.files.isNotEmpty) {
//       selectedImages.value =
//           result.files.map((file) => File(file.path!)).toList();

//       // Navigate to preview screen
//       Get.to(() =>SelectPostFilters());
//     }
//   }

// }

class ImagePickerController extends GetxController {
  var selectedMedia = <File>[].obs;
  var selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic> selectedVideoData = {};
  String selectedVideoFilter = 'normal';
  RxBool isLoading = false.obs;
String? get selectedVideoThumbnail => selectedVideoData['thumbnail'] as String?;

  Future<Uint8List?> generateVideoThumbnail(String videoPath) async {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxWidth: 200, // for preview
      quality: 75,
    );
  }

  Future<String?> applyVideoFilter({
    required String inputPath,
    required String filterName,
  }) async {
    final directory = await getTemporaryDirectory();
    final outputPath =
        '${directory.path}/filtered_video_${DateTime.now().millisecondsSinceEpoch}.mp4';

    // Enhanced filter commands for more visible effects (without LUTs)
    final Map<String, String> filters = {
      'clarendon':
          'colorchannelmixer=rr=0.9:gg=0.947:bb=0.978,eq=contrast=1.2:saturation=1.35',
      'aden':
          'colorchannelmixer=rr=0.852:gg=0.808:bb=0.811,eq=contrast=0.9:saturation=0.85:brightness=0.2,hue=h=-20',
      'amaro':
          'colorchannelmixer=rr=0.898:gg=0.882:bb=0.819,eq=contrast=1.1:saturation=1.3:brightness=0.2,colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131',
      'ashby':
          'colorchannelmixer=rr=0.822:gg=0.794:bb=0.683,eq=contrast=1.2:saturation=1.8,colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131',
      'brannan':
          'colorchannelmixer=rr=0.886:gg=0.743:bb=0.932,eq=contrast=1.4,colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131',
      'brooklyn':
          'colorchannelmixer=rr=0.864:gg=0.95:bb=0.903,eq=contrast=0.9:brightness=0.1',
      'gingham':
          'colorchannelmixer=rr=0.902:gg=0.902:bb=0.98,eq=brightness=0.05,hue=h=-10',
      'hudson':
          'colorchannelmixer=rr=0.825:gg=0.847:bb=1.0,eq=contrast=0.9:saturation=1.1:brightness=0.2',
      'willow':
          'colorchannelmixer=rr=1.0:gg=1.0:bb=1.0,eq=contrast=0.85:saturation=0.05:brightness=0.2,colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131',
      'xpro2':
          'colorchannelmixer=rr=0.501:gg=0.499:bb=0.779,eq=contrast=1.2:saturation=1.2,colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131',
    };
    // Get filter string
    final String? filterCommand = filters[filterName.toLowerCase()];

    if (filterCommand == null) {
      print('❌ Invalid filter name: $filterName');
      return null;
    }

    // Build FFmpeg command with safe quoting
    final String command =
        '-i "$inputPath" -vf "$filterCommand" -c:v libx264 -pix_fmt yuv420p -c:a copy "$outputPath"';

    print('▶️ Running FFmpeg Command:\n$command');

    // Execute FFmpeg
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      print('✅ Filter applied successfully: $outputPath');
      return outputPath;
    } else {
      print('❌ FFmpeg Failed: $returnCode');
      return null;
    }
  }

  Future<Map<String, dynamic>?> pickVideoAndGenerateThumbnail({
    bool fromCamera = false,
  }) async {
    // Pick video
    final XFile? videoFile = await _picker.pickVideo(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (videoFile == null) {
      print('No video selected.');
      selectedVideoData.clear();
      return null;
    }

    // Generate thumbnail
    // Generate thumbnail file path
    final Directory tempDir = await getTemporaryDirectory();
    final String thumbFilePath = path.join(
      tempDir.path,
      'video_thumbnail_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    // Generate thumbnail and save as file
    final String? thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: thumbFilePath,
      imageFormat: ImageFormat.PNG,
      maxWidth: 400, // Adjust as needed
      quality: 80,
    );

    if (thumbnailPath == null) {
      print('Failed to generate thumbnail file.');
      return null;
    }

    final File thumbnailFile = File(thumbnailPath);
    selectedVideoData = {
      'videoFile': videoFile,
      'thumbnail': thumbnailFile.path,
    };
    Get.to(() => SelectPostFilters(
          isVideo: true,
          count: '1 Video',
        ));
    return {
      'videoFile': videoFile,
      'thumbnail': thumbnailFile.path,
    };
  }

  Future<void> pickImageFromCamera() async {
    final result = await _picker.pickImage(source: ImageSource.camera);
    if (result != null && result.path.isNotEmpty) {
      final files = File(result.path);
      selectedMedia.value = [files];

      // Filter only images for the filter screen
      selectedImages.value = [files];

      // Navigate to filter screen
      Get.to(() => SelectPostFilters(
            isVideo: false,
          ));
    }
  }

  Future<void> pickMultipleMedia() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov', 'avi'],
    );

    if (result != null && result.files.isNotEmpty) {
      final files = result.files.map((f) => File(f.path!)).toList();
      selectedMedia.value = files;

      // Filter only images for the filter screen
      selectedImages.value = files.where((file) {
        final ext = file.path.split('.').last.toLowerCase();
        return ['jpg', 'jpeg', 'png'].contains(ext);
      }).toList();

      // Navigate to filter screen
      Get.to(() => SelectPostFilters(
            isVideo: false,
          ));
    }
  }
}

//  var selectedFile = Rx<File?>(null);
//   var mediaType = ''.obs;

//   Future<void> pickFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowMultiple: false,
//       allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4', 'mov'],
//     );

//     if (result != null && result.files.isNotEmpty) {
//       final file = File(result.files.single.path!);
//       selectedFile.value = file;

//       // Detect media type
//       final extension = result.files.single.extension?.toLowerCase();
//       if (['jpg', 'png', 'jpeg'].contains(extension)) {
//         mediaType.value = "image";
//       } else if (['mp4', 'mov'].contains(extension)) {
//         mediaType.value = "video";
//       }

//       // Navigate to preview screen

//     }
//   }
