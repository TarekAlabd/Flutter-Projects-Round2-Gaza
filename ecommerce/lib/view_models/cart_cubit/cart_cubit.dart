import 'package:ecommerce/models/cart_orders_model.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:ecommerce/services/cart_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final authServices = AuthServices();
  final cartServices = CartServices();

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final currentUser = authServices.currentUser;
      final cartOrders = await cartServices.getCartItems(currentUser!.uid);
      final subtotal = cartOrders.fold<double>(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity * element.product.price),
      );
      const shipping = 10.0;
      final totalPrice = subtotal + shipping;
      emit(CartLoaded(
        cartOrders: cartOrders,
        subtotal: subtotal,
        shipping: shipping,
        totalPrice: totalPrice,
      ));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void incrementCounter(int previousValue, String cartItemId) {
    emit(QuantityChanging(cartItemId));
    Future.delayed(const Duration(seconds: 1), () {
      var newValue = ++previousValue;
      emit(QuantityChanged(newValue, cartItemId));
    });
  }

  void decrementCounter(int previousValue, String cartItemId) {
    emit(QuantityChanging(cartItemId));
    Future.delayed(const Duration(seconds: 1), () {
      var newValue = previousValue;
      if (previousValue > 1) {
        newValue = --newValue;
      }
      emit(QuantityChanged(newValue, cartItemId));
    });
  }
}
