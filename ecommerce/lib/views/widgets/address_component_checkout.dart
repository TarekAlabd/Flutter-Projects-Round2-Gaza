import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/shipping_address_model.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AddressComponentCheckout extends StatelessWidget {
  final ShippingAddress? address;
  const AddressComponentCheckout({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: address == null
              ? Column(
                  children: [
                    const Text('No address available!'),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AppRoutes.address),
                      child: const Text('Add New Address'),
                    ),
                  ],
                )
              : Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: address!.imgUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address!.city,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${address!.city}, ${address!.country}',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
