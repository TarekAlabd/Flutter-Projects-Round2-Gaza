import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/views/widgets/cart_order_item.dart';
import 'package:ecommerce/views/widgets/label_with_value_row.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return BlocBuilder(
      bloc: cartCubit,
      buildWhen: (previous, current) =>
          current is CartLoaded ||
          current is CartError ||
          current is CartLoading,
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is CartLoaded) {
          final cartItems = state.cartOrders;
          final subtotal = state.subtotal;
          final shipping = state.shipping;
          final totalPrice = state.totalPrice;

          return RefreshIndicator(
            onRefresh: () async {
              cartCubit.getCartItems();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ListView.separated(
                    itemCount: cartItems.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(
                        color: AppColors.grey2,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      return CartOrderItem(cartItem: cartItems[index]);
                    },
                  ),
                  const SizedBox(height: 36),
                  LabelWithValueRow(
                    label: 'Subtotal',
                    value: '\$$subtotal',
                  ),
                  const SizedBox(height: 8),
                  LabelWithValueRow(
                    label: 'Shipping',
                    value: '\$$shipping',
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: AppColors.grey2,
                  ),
                  const SizedBox(height: 8),
                  LabelWithValueRow(
                    label: 'Total',
                    value: '\$$totalPrice',
                  ),
                  const SizedBox(height: 36),
                  MainButton(
                    label: 'Checkout',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        } else if (state is CartError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
