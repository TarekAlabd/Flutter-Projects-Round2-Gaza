part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final PaymentMethod? paymentMethod;
  final ShippingAddress? shippingAddress;
  final List<CartOrdersModel> cartOrders;
  final double totalAmount;

  CheckoutLoaded({
    this.paymentMethod,
    this.shippingAddress,
    required this.cartOrders,
    required this.totalAmount,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError(this.message);
}
