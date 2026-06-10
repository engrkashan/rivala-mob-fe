import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/categories_provider.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:shimmer/shimmer.dart';

/// Category Management screen — mirrors the web's
/// sell-on-rivala/category-management section.
/// Uses CategoriesProvider.loadCategories() to list all store categories.
class CategoryManagement extends StatefulWidget {
  const CategoryManagement({super.key});

  @override
  State<CategoryManagement> createState() => _CategoryManagementState();
}

class _CategoryManagementState extends State<CategoryManagement> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CategoriesProvider>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context,
          title: 'Category Management',
          centerTitle: true),
      body: Consumer<CategoriesProvider>(
        builder: (context, cats, _) {
          if (cats.isLoading && (cats.categories == null || cats.categories!.isEmpty)) {
            return _buildSkeleton();
          }

          final categories = cats.categories ?? [];

          if (categories.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.category_outlined, size: 60, color: kgrey2),
                    const SizedBox(height: 16),
                    MyText(
                      text: 'No categories found.',
                      size: 15,
                      color: ktertiary,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const Divider(color: kgrey2),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: kmenuGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.category_outlined,
                      color: kblue2, size: 22),
                ),
                title: MyText(
                  text: cat.name ?? 'Category',
                  size: 15,
                  weight: FontWeight.w600,
                  color: kblack,
                ),
                subtitle: (cat.description != null && cat.description!.isNotEmpty)
                    ? MyText(
                        text: cat.description!,
                        size: 12,
                        color: ktertiary,
                      )
                    : null,
                trailing: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: kdarkgrey,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
