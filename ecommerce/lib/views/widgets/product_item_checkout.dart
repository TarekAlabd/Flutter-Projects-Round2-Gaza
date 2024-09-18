import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/cart_orders_model.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductItemCheckout extends StatelessWidget {
  final CartOrdersModel cartOrder;

  const ProductItemCheckout({
    super.key,
    required this.cartOrder,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartOrder.product.name),
      leading: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageUrl: cartOrder.product.imgUrl,
            width: 60.0,
          ),
        ),
      ),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Size: ',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.grey,
                  ),
            ),
            TextSpan(
              text: cartOrder.size.name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
      trailing: Text(
        '\$${cartOrder.quantity * cartOrder.product.price}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
