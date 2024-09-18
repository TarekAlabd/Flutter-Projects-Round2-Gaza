import 'package:ecommerce/models/cart_orders_model.dart';
import 'package:ecommerce/models/payment_method_model.dart';
import 'package:ecommerce/models/shipping_address_model.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final authServices = AuthServices();
  final checkoutServices = CheckoutServices();

  Future<void> getCheckoutData() async {
    emit(CheckoutLoading());
    try {
      final currentUser = authServices.currentUser;
      final shippingAddresses =
          await checkoutServices.getShippingAddresses(currentUser!.uid, true);
      final chosenShippingAddress =
          shippingAddresses.isNotEmpty ? shippingAddresses.first : null;

      final cartOrders = await checkoutServices.getCartItems(currentUser.uid);
      final totalAmount = cartOrders.fold<double>(
              0,
              (previousValue, element) =>
                  previousValue + (element.product.price * element.quantity)) +
          10;

      final paymentMethods =
          await checkoutServices.getPaymentMethods(currentUser.uid, true);
      final chosenPaymentMethod =
          paymentMethods.isNotEmpty ? paymentMethods.first : null;
      emit(
        CheckoutLoaded(
          paymentMethod: chosenPaymentMethod,
          shippingAddress: chosenShippingAddress,
          cartOrders: cartOrders,
          totalAmount: totalAmount,
        ),
      );
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }
}
