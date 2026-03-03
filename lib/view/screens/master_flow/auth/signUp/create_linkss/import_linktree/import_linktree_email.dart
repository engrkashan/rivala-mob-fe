import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/link_model.dart';
import 'package:rivala/services/linktree_service.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/import_linktree/import_linktree.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class ImportLinktreeEmail extends StatefulWidget {
  const ImportLinktreeEmail({super.key});

  @override
  State<ImportLinktreeEmail> createState() => _IndiviualLinkState();
}

class _IndiviualLinkState extends State<ImportLinktreeEmail> {
  final TextEditingController _urlController = TextEditingController();
  final LinktreeService _linktreeService = LinktreeService();
  bool _isLoading = false;

  void _importLinks() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      AlertInfo.show(context: context, text: 'Please enter a URL');
      return;
    }

    // Basic Linktree URL validation
    final linktreeRegex = RegExp(r'(linktr\.ee/|linktree/)');
    if (!linktreeRegex.hasMatch(url.toLowerCase())) {
      AlertInfo.show(
          context: context,
          text:
              'Please enter a valid Linktree profile URL (e.g. linktr.ee/username)');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      List<LinkModel> links = await _linktreeService.getLinks(url);
      if (links.isEmpty) {
        AlertInfo.show(
            context: context,
            text: 'No links found or unable to parse content');
      } else {
        Get.to(() => ImportLinktree(importedLinks: links));
      }
    } catch (e) {
      AlertInfo.show(
          context: context, text: 'Failed to import links: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Import from LinkTree',
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
                  Image.asset(
                    Assets.imagesLinktree,
                    width: 95,
                    height: 95,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    controller: _urlController,
                    hint: 'Enter URL',
                    label: 'What’s Your LinkTree URL?',
                    delay: 400,
                    hintColor: ktertiary,
                    bordercolor: ktertiary,
                  ),
                ],
              ),
            ),
            MyButton(
              buttonText: _isLoading ? 'Importing...' : 'Import links',
              mBottom: 50,
              mhoriz: 35,
              onTap: _isLoading ? () {} : _importLinks,
            ),
          ],
        ));
  }
}
