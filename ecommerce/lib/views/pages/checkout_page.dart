import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/utils/app_routes.dart';
import 'package:ecommerce/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce/views/widgets/address_component_checkout.dart';
import 'package:ecommerce/views/widgets/checkout_title_widget.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/payment_component_checkout.dart';
import 'package:ecommerce/views/widgets/product_item_checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: checkoutCubit,
        buildWhen: (previous, current) =>
            current is CheckoutLoaded ||
            current is CheckoutError ||
            current is CheckoutLoading,
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CheckoutError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CheckoutLoaded) {
            final totalAmount = state.totalAmount;
            final shippingAddress = state.shippingAddress;
            final cartOrders = state.cartOrders;
            final paymentMethod = state.paymentMethod;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    CheckoutTitleWidget(
                      title: 'Address',
                      onTap: shippingAddress == null
                          ? null
                          : () => Navigator.of(context)
                              .pushNamed(AppRoutes.address),
                    ),
                    if (shippingAddress == null) const SizedBox(height: 16),
                    AddressComponentCheckout(
                      address: shippingAddress,
                    ),
                    const SizedBox(height: 24),
                    CheckoutTitleWidget(
                      title: 'Products',
                      number: cartOrders.length.toString(),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartOrders.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartOrder = cartOrders[index];
                        return ProductItemCheckout(cartOrder: cartOrder);
                      },
                    ),
                    const CheckoutTitleWidget(title: 'Payment Method'),
                    const SizedBox(height: 16),
                    PaymentComponentCheckout(payment: paymentMethod),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.grey,
                                  ),
                        ),
                        Text(
                          '\$$totalAmount',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    MainButton(
                      label: 'Pay',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
