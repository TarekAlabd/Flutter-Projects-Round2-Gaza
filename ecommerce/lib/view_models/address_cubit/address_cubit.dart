import 'package:ecommerce/models/shipping_address_model.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/services/checkout_services.dart';
import 'package:ecommerce/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final locationServices = LocationServices();
  final authServices = AuthServices();

  ShippingAddress? selectedAddress;

  Future<void> fetchAddresses() async {
    emit(AddressesLoading());
    try {
      final currentUser = authServices.currentUser;
      final addresses = await locationServices.fetchLocations(currentUser!.uid);
      selectedAddress =
          (await locationServices.fetchLocations(currentUser.uid, true)).first;
      emit(AddressesLoaded(addresses));
      emit(AddressSelected(selectedAddress ?? addresses.first));
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> addAddress(String addressKey) async {
    emit(AddressAdding());
    try {
      if (addressKey.isEmpty) {
        emit(AddingAddressError('You must write an address!'));
        return;
      }
      final result = addressKey.split('-'); // Cairo-Egypt
      final address = ShippingAddress(
        id: DateTime.now().toIso8601String(),
        city: result[0],
        country: result[1],
        imgUrl:
            'https://previews.123rf.com/images/emojoez/emojoez1903/emojoez190300018/119684277-illustrations-design-concept-location-maps-with-road-follow-route-for-destination-drive-by-gps.jpg',
      );
      final currentUser = authServices.currentUser;
      await locationServices.setLocation(currentUser!.uid, address);
      emit(AddressAdded());
      fetchAddresses();
    } catch (e) {
      emit(AddingAddressError(e.toString()));
    }
  }

  void selectItem(ShippingAddress address) {
    selectedAddress = address;
    emit(AddressSelected(address));
  }

  Future<void> confirmAddress() async {
    emit(ConfirmingAddress());
    try {
      final currentUser = authServices.currentUser;
      var previousSelectedLocation =
          (await locationServices.fetchLocations(currentUser!.uid, true)).first;
      previousSelectedLocation =
          previousSelectedLocation.copyWith(isChosen: false);
      await locationServices.setLocation(currentUser.uid, previousSelectedLocation);
      selectedAddress = selectedAddress!.copyWith(isChosen: true);
      await locationServices.setLocation(currentUser.uid, selectedAddress!);
      emit(AddressConfirmed());
    } catch (e) {
      emit(ConfirmingAddressError(e.toString()));
    }
  }
}
