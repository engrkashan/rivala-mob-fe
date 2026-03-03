import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/import_product_provider.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/products_added_success.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/switch_button.dart';

class ImportCsv extends StatefulWidget {
  const ImportCsv({super.key});

  @override
  State<ImportCsv> createState() => _ImportCsvState();
}

class _ImportCsvState extends State<ImportCsv> {
  bool applyCommission = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context, title: 'Import Products', centerTitle: true),
      body: Consumer<ImportProductProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ProductTable(tableData: provider.importedProducts),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyText(
                            text: 'Apply 15% commission to all products',
                            size: 15,
                            color: kblack,
                            weight: FontWeight.w500,
                          ),
                        ),
                        SwitchButton(
                          scale: 0.6,
                          isActive: applyCommission,
                          onChanged: (val) {
                            setState(() {
                              applyCommission = val;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<ImportProductProvider>(
        builder: (context, provider, child) {
          return MyButton(
            buttonText: 'Add products',
            mhoriz: 22,
            mBottom: 50,
            onTap: () async {
              bool success = await provider.saveImportedProducts();
              if (success) {
                Get.to(() => const ProductsAddedSuccess());
              } else {
                Get.snackbar(
                  'Error',
                  'Failed to add products. Please try again.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: kred.withOpacity(0.7),
                  colorText: kwhite,
                );
              }
            },
          );
        },
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  final List<Map<String, dynamic>> tableData;

  const ProductTable({super.key, required this.tableData});

  Color getAvailabilityColor(String status) {
    switch (status) {
      case 'Yes':
        return kgreen;
      case 'No':
        return kred;
      default:
        return ktertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImportProductProvider>(context, listen: false);

    if (tableData.isEmpty) {
      return Center(child: MyText(text: 'No products imported.'));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          // ✅ Header Row
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                SizedBox(width: 90), // Skip header for icon+attribute
                HeaderCell(text: 'Price', width: 80),
                SizedBox(width: 10),
                HeaderCell(text: 'Available', width: 60),
                SizedBox(width: 10),
                HeaderCell(text: 'On Hand', width: 80),
                SizedBox(width: 10),
                HeaderCell(text: 'SKU', width: 120),
              ],
            ),
          ),

          // ✅ Data Rows
          ...List.generate(tableData.length, (index) {
            final row = tableData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  // Attribute Cell (Radio/Selection)
                  SizedBox(
                    width: 90,
                    child: GestureDetector(
                      onTap: () => provider.toggleProductSelection(index),
                      child: Row(
                        children: [
                          Icon(
                            row['checked'] == true
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color:
                                row['checked'] == true ? Colors.green : kgrey2,
                            size: 22,
                          ),
                          const SizedBox(width: 6),
                          MyText(
                            text: row['attribute'] ?? '',
                            size: 11,
                            weight: FontWeight.bold,
                            color: kblack,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Price (Editable)
                  EditableCell(
                    width: 80,
                    initialValue: row['price']?.toString() ?? '',
                    onChanged: (val) =>
                        provider.updateProductField(index, 'price', val),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    prefix: '',
                  ),
                  const SizedBox(width: 10),
                  // Available (Toggleable)
                  GestureDetector(
                    onTap: () => provider.toggleAvailability(index),
                    child: Container(
                      width: 60,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: getAvailabilityColor(row['available'] ?? ''),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: MyText(
                        text: row['available'] ?? '',
                        color: Colors.white,
                        size: 10,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // On Hand (Editable)
                  EditableCell(
                    width: 80,
                    initialValue: row['onHand']?.toString() ?? '',
                    onChanged: (val) =>
                        provider.updateProductField(index, 'onHand', val),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(width: 10),
                  // SKU (Editable)
                  EditableCell(
                    width: 120,
                    initialValue: row['sku']?.toString() ?? '',
                    onChanged: (val) =>
                        provider.updateProductField(index, 'sku', val),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class EditableCell extends StatefulWidget {
  final double width;
  final String initialValue;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String? prefix;

  const EditableCell({
    super.key,
    required this.width,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.prefix,
  });

  @override
  State<EditableCell> createState() => _EditableCellState();
}

class _EditableCellState extends State<EditableCell> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(EditableCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        _controller.text != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: kgrey2.withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kgrey2, width: 0.5),
      ),
      child: Row(
        children: [
          if (widget.prefix != null)
            Text(widget.prefix!, style: const TextStyle(fontSize: 10)),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 10),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Custom Header Cell Widget
class HeaderCell extends StatelessWidget {
  final String text;
  final double width;
  const HeaderCell({super.key, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MyText(
        text: text,
        size: 11,
        textAlign: TextAlign.center,
        weight: FontWeight.bold,
        color: kblack,
      ),
    );
  }
}
