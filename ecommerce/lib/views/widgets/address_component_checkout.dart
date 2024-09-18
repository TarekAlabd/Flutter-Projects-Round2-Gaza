import 'package:ecommerce/models/shipping_address_model.dart';
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
                      onPressed: () => Navigator.of(context).pushNamed(AppRoutes.address),
                      child: const Text('Add New Address'),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
