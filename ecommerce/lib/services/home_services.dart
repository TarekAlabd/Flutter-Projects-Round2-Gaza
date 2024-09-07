import 'package:ecommerce/models/product_item_model.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

class HomeServices {
  final firestoreServices = FirestoreServices.instance;

  Future<List<ProductItemModel>> getProducts() async {
    return await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPath.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
  }

  Future<void> setProduct(ProductItemModel productItem) async {
    await firestoreServices.setData(
      path: ApiPath.product(productItem.id),
      data: productItem.toMap(),
    );
  }
}
