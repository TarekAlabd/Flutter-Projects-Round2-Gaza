import 'package:ecommerce/models/shipping_address_model.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

class LocationServices {
  final firestoreServices = FirestoreServices.instance;
  Future<void> setLocation(String userId, ShippingAddress address) async =>
      await firestoreServices.setData(
        path: ApiPath.shippingAddress(userId, address.id),
        data: address.toMap(),
      );

  Future<List<ShippingAddress>> fetchLocations(String userId, [bool chosenAddress = false]) async =>
      await firestoreServices.getCollection(
        path: ApiPath.shippingAddresses(userId),
        builder: (data, documentId) => ShippingAddress.fromMap(data),
        queryBuilder: chosenAddress == true ? (query) => query.where('isChosen', isEqualTo: true) : null,
      );
}
