import 'package:ecommerce/models/cart_orders_model.dart';
import 'package:ecommerce/models/product_item_model.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

class ProductDetailsServices {
  final firestoreServices = FirestoreServices.instance;

  Future<ProductItemModel> getProductDetails(String productId) async =>
      await firestoreServices.getDocument(
        path: ApiPath.product(productId),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );

  Future<void> addToCart(String userId, CartOrdersModel cartItem) async =>
      await firestoreServices.setData(
        path: ApiPath.cartItem(userId, cartItem.id),
        data: cartItem.toMap(),
      );
}
