import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:rivala/controllers/repos/products_repo.dart';
import 'package:rivala/models/product_model.dart';

class ImportProductProvider extends ChangeNotifier {
  String shopifyUrl = '';
  String etsyUrl = '';
  String? selectedFileName;
  PlatformFile? selectedFile;

  List<Map<String, dynamic>> importedProducts = [];

  void setShopifyUrl(String url) {
    shopifyUrl = url;
    notifyListeners();
  }

  void setEtsyUrl(String url) {
    etsyUrl = url;
    notifyListeners();
  }

  Future<void> pickCsvFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      selectedFile = result.files.first;
      selectedFileName = selectedFile!.name;
      notifyListeners();
    }
  }

  void toggleProductSelection(int index) {
    if (index >= 0 && index < importedProducts.length) {
      importedProducts[index]['checked'] =
          !(importedProducts[index]['checked'] ?? false);
      notifyListeners();
    }
  }

  void updateProductField(int index, String field, String value) {
    if (index >= 0 && index < importedProducts.length) {
      importedProducts[index][field] = value;
      // Note: We don't notifyListeners here to avoid rebuilds on every keystroke if called from onChanged.
      // The UI will handle its own state for the text field.
    }
  }

  void toggleAvailability(int index) {
    if (index >= 0 && index < importedProducts.length) {
      String current = importedProducts[index]['available'] ?? 'No';
      if (current == 'Yes') {
        importedProducts[index]['available'] = 'No';
      } else if (current == 'No') {
        importedProducts[index]['available'] = 'Edit';
      } else {
        importedProducts[index]['available'] = 'Yes';
      }
      notifyListeners();
    }
  }

  bool isSaving = false;
  final _productsRepo = ProductsRepo();

  Future<bool> saveImportedProducts() async {
    final selectedProducts =
        importedProducts.where((p) => p['checked'] == true).toList();

    if (selectedProducts.isEmpty) return false;

    isSaving = true;
    notifyListeners();

    try {
      for (var p in selectedProducts) {
        final model = ProductModel(
          title: p['attribute']?.toString() ?? 'Imported Product',
          price: double.tryParse(p['price']?.toString() ?? '0'),
          SKU: p['sku']?.toString(),
          stockQuantity: int.tryParse(p['onHand']?.toString() ?? '0'),
          isActive: p['available'] == 'Yes',
          description: 'Imported from ${selectedFileName ?? 'URL'}',
        );
        await _productsRepo.postProduct(model);
      }
      isSaving = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Error saving imported products: $e");
      isSaving = false;
      notifyListeners();
      return false;
    }
  }

  void importProducts() {
    shopifyUrl = '';
    etsyUrl = '';
    selectedFileName = null;
    selectedFile = null;

    // mock data
    importedProducts = [];
    notifyListeners();
  }
}
