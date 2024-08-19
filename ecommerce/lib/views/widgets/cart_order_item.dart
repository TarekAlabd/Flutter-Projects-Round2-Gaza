import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/cart_orders_model.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/views/widgets/counter_widget_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartOrderItem extends StatelessWidget {
  final CartOrdersModel cartItem;
  const CartOrderItem({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grey2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CachedNetworkImage(
              imageUrl: cartItem.product.imgUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.product.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Size: ',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                  ),
                  Text(
                    cartItem.size.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<CartCubit, CartState>(
                    bloc: cartCubit,
                    buildWhen: (previous, current) =>
                        (current is QuantityChanged &&
                            current.cartItemId == cartItem.id) ||
                        (current is QuantityChanging &&
                            current.cartItemId == cartItem.id),
                    builder: (context, state) {
                      if (state is QuantityChanging) {
                        return CounterWidgetCart(
                          cubit: cartCubit,
                          isLoading: true,
                          cartItemId: cartItem.id,
                        );
                      } else if (state is QuantityChanged) {
                        return CounterWidgetCart(
                          cubit: cartCubit,
                          counter: state.counter,
                          cartItemId: cartItem.id,
                        );
                      }
                      return CounterWidgetCart(
                        cubit: cartCubit,
                        counter: cartItem.quantity,
                        cartItemId: cartItem.id,
                      );
                    },
                  ),
                  Text(
                    '\$${cartItem.product.price * cartItem.quantity}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
