import 'package:ecommerce/models/cart_orders_model.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

class CartServices {
  final firestoreServices = FirestoreServices.instance;

  Future<List<CartOrdersModel>> getCartItems(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPath.cart(userId),
        builder: (data, documentId) => CartOrdersModel.fromMap(data),
      );
}
