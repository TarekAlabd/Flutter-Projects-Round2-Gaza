part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class AddressesLoading extends AddressState {}

final class AddressesLoaded extends AddressState {
  final List<ShippingAddress> addresses;

  AddressesLoaded(this.addresses);
}

final class AddressesError extends AddressState {
  final String message;

  AddressesError(this.message);
}

final class AddressAdded extends AddressState {}

final class AddressAdding extends AddressState {}

final class AddingAddressError extends AddressState {
  final String message;

  AddingAddressError(this.message);
}

final class AddressSelected extends AddressState {
  final ShippingAddress? address;

  AddressSelected(this.address);
}

final class ConfirmingAddress extends AddressState {}

final class AddressConfirmed extends AddressState {}

final class ConfirmingAddressError extends AddressState {
  final String message;

  ConfirmingAddressError(this.message);
}
