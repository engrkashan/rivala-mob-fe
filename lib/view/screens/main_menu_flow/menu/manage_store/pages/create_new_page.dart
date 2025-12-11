import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/pages_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:get/get.dart';

class CreateNewPage extends StatefulWidget {
  const CreateNewPage({super.key});

  @override
  State<CreateNewPage> createState() => _CreateNewPageState();
}

class _CreateNewPageState extends State<CreateNewPage> {
  final TextEditingController _titleController = TextEditingController();
  bool _isLoading = false;

  String _slugify(String str) {
    return str
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[\s_]+'), '-')
        .replaceAll(RegExp(r'[^\w-]+'), '')
        .replaceAll(RegExp(r'--+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  Future<void> _createPage() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final slug = _slugify(title);
      await context
          .read<PagesProvider>()
          .createPage(title: title, slug: slug, isVisible: true);

      if (mounted) {
        Get.back(); // Close bottom sheet
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create page: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: kwhite),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ContainerAppbar(
              title: 'Create a New Page',
              icon: Assets.imagesClose2,
              textColor: kblack,
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _titleController,
              hint: 'Type page name here',
              label: 'Page Name',
            ),
            SizedBox(
              height: 20,
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : MyButton(
                    buttonText: 'Create page',
                    mBottom: 40,
                    onTap: _createPage,
                  )
          ],
        )));
  }
}
