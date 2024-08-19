import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';

class CounterWidgetCart extends StatelessWidget {
  final CartCubit cubit;
  final int? counter;
  final bool isLoading;
  final String cartItemId;

  const CounterWidgetCart({
    super.key,
    required this.cubit,
    this.counter,
    required this.cartItemId,
    this.isLoading = false,
  }) : assert(counter != null || isLoading == true);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: isLoading
                ? null
                : () async => cubit.decrementCounter(counter!, cartItemId),
            icon: const Icon(Icons.remove),
          ),
          const SizedBox(width: 8),
          if (!isLoading)
            Text(
              counter.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          if (isLoading) const CircularProgressIndicator.adaptive(),
          const SizedBox(width: 8),
          IconButton(
            onPressed: isLoading
                ? null
                : () async => cubit.incrementCounter(counter!, cartItemId),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
