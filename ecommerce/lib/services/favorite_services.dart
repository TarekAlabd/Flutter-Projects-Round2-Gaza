import 'package:ecommerce/models/product_item_model.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

class FavoriteServices {
  final firestoreServices = FirestoreServices.instance;

  Future<void> addFavorite(String userId, ProductItemModel product) async =>
      await firestoreServices.setData(
        path: ApiPath.favoriteItem(userId, product.id),
        data: product.toMap(),
      );

  Future<void> removeFavorite(String userId, String productId) async =>
      await firestoreServices.deleteData(
        path: ApiPath.favoriteItem(userId, productId),
      );

  Future<List<ProductItemModel>> getFavoriteItems(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPath.favorites(userId),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );
}
