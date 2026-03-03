import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/controllers/providers/squads_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_tags.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import '../../../../../controllers/providers/product_provider.dart';

class SearchCriteriaProducts extends StatefulWidget {
  final bool? hasCheckbox, isMainMenu, isSquad;
  final String? title, hintText;
  final Function(dynamic)? onItemSelected;

  const SearchCriteriaProducts({
    super.key,
    this.hasCheckbox = true,
    this.title,
    this.hintText,
    this.isMainMenu = false,
    this.isSquad = false,
    this.onItemSelected,
  });

  @override
  State<SearchCriteriaProducts> createState() => _SearchCriteriaProductsState();
}

class _SearchCriteriaProductsState extends State<SearchCriteriaProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isSquad == true) {
        context.read<SquadProvider>().getSquads();
      } else if (widget.title?.contains('Collections') == true ||
          widget.hintText?.contains('collections') == true) {
        context.read<CollectionProvider>().loadAllCollections();
      } else {
        context.read<ProductProvider>().loadCurrentProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: kwhite),
        padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ContainerAppbar(
            textColor: kblack,
            title: widget.title ?? 'Filter By',
            icon: Assets.imagesClose2,
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
            hint: widget.hintText ?? 'Search Products',
            prefixIcon: Image.asset(
              Assets.imagesSearch,
              width: 15,
              height: 15,
            ),
            ontapp: () {
              // Search logic could be added here if needed
            },
            contentvPad: 6,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: _buildList(),
          ),
          SizedBox(
            height: 30,
          ),
        ]));
  }

  Widget _buildList() {
    if (widget.isSquad == true) {
      return Consumer<SquadProvider>(
        builder: (context, ref, _) {
          if (ref.isLoading)
            return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: ref.squads.length,
            itemBuilder: (context, index) {
              final squad = ref.squads[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: tags_search_row(
                  size: 54,
                  hpad: 0,
                  bgColor: ktransparent,
                  isSquad: true,
                  squad: squad,
                  hasCheckbox: widget.hasCheckbox,
                  isMainMenu: widget.isMainMenu,
                  onItemSelected: widget.onItemSelected,
                ),
              );
            },
          );
        },
      );
    } else if (widget.title?.contains('Collections') == true ||
        widget.hintText?.contains('collections') == true) {
      return Consumer<CollectionProvider>(
        builder: (context, ref, _) {
          if (ref.isLoading)
            return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: ref.allCollections.length,
            itemBuilder: (context, index) {
              final collection = ref.allCollections[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: tags_search_row(
                  size: 54,
                  hpad: 0,
                  bgColor: ktransparent,
                  isCollection: true,
                  collection: collection,
                  hasCheckbox: widget.hasCheckbox,
                  isMainMenu: widget.isMainMenu,
                  onItemSelected: widget.onItemSelected,
                ),
              );
            },
          );
        },
      );
    } else {
      return Consumer<ProductProvider>(
        builder: (context, ref, _) {
          if (ref.isLoading)
            return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: ref.prds?.length ?? 0,
            itemBuilder: (context, index) {
              final product = ref.prds?[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: tags_search_row(
                  size: 54,
                  hpad: 0,
                  bgColor: ktransparent,
                  isProduct: true,
                  product: product,
                  hasCheckbox: widget.hasCheckbox,
                  isMainMenu: widget.isMainMenu,
                  isSquad: widget.isSquad,
                  onItemSelected: widget.onItemSelected,
                ),
              );
            },
          );
        },
      );
    }
  }
}
