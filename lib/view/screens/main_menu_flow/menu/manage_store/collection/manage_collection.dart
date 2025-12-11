import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/squad_widget.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import '../../../../../../models/collection_model.dart';

class ManageCollection extends StatefulWidget {
  final CollectionModel collection;
  const ManageCollection({super.key, required this.collection});

  @override
  State<ManageCollection> createState() => _ManageCollectionState();
}

class _ManageCollectionState extends State<ManageCollection> {
  @override
  Widget build(BuildContext context) {
    final coll = widget.collection;
    return Scaffold(
        backgroundColor: kwhite,
        appBar:
            simpleAppBar(context: context, title: coll.name, centerTitle: true),
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
                      hint: coll.name,
                      label: "Collection Name",
                      bordercolor: ktransparent,
                      filledColor: kgrey2,
                      delay: 150),
                  MyTextField(
                    hint: coll.description,
                    label: 'Collection Description',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                    maxLines: 4,
                    delay: 250,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  squad_seller(
                    isProduct: true,
                    products: coll.products,
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
