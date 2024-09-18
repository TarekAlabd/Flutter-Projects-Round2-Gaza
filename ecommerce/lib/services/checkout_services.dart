import 'package:ecommerce/models/cart_orders_model.dart';
import 'package:ecommerce/models/payment_method_model.dart';
import 'package:ecommerce/models/shipping_address_model.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

class CheckoutServices {
  final firestoreServices = FirestoreServices.instance;

  Future<List<ShippingAddress>> getShippingAddresses(String userId, [bool chosenAddress = false]) async =>
      await firestoreServices.getCollection(
        path: ApiPath.shippingAddresses(userId),
        builder: (data, documentId) => ShippingAddress.fromMap(data),
        queryBuilder: chosenAddress == true ? (query) => query.where('isChosen', isEqualTo: true) : null,
      );

  Future<List<CartOrdersModel>> getCartItems(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPath.cart(userId),
        builder: (data, documentId) => CartOrdersModel.fromMap(data),
      );

  Future<List<PaymentMethod>> getPaymentMethods(String userId, [bool chosenPayment = false]) async =>
      await firestoreServices.getCollection(
        path: ApiPath.paymentMethods(userId),
        builder: (data, documentId) => PaymentMethod.fromMap(data),
        queryBuilder: chosenPayment == true ? (query) => query.where('isChosen', isEqualTo: true) : null,
      );
}
