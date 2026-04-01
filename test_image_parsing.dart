import 'dart:convert';
import 'package:rivala/models/product_model.dart';

void main() {
  String jsonStr = '''
  {
    "id": "b0f5e91b-d1f4-40a6-9f40-ddfa390f03ad",
    "title": "with image",
    "description": "hello",
    "price": 40,
    "SKU": "hshsnsnsn",
    "stockQuantity": 0,
    "createdAt": "2026-03-03T10:52:53.990Z",
    "purchaseCount": 0,
    "revenue": 0,
    "ProductCategory": null,
    "images": [
      {
        "id": "c9887ae4-2d7a-44ef-92dd-7fa23370918e",
        "url": "https://011528287175-rivala-data.s3.us-east-1.amazonaws.com/ad41c0ab-b9d9-47db-9b75-2dc3aa1e1fa6.jpg",
        "isPrimary": true
      }
    ]
  }
  ''';

  Map<String, dynamic> jsonMap = json.decode(jsonStr);
  ProductModel model = ProductModel.fromJson(jsonMap);

  print("Parsed Images List:");
  print(model.image);
  print("Is images null?");
  print(model.image == null);
  if (model.image != null) {
    print("First image:");
    print(model.image!.isNotEmpty ? model.image!.first : 'empty');
  }
}
