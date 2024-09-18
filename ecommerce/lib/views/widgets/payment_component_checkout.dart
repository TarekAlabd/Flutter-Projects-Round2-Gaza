import 'package:ecommerce/models/payment_method_model.dart';
import 'package:ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';

class PaymentComponentCheckout extends StatelessWidget {
  final PaymentMethod? payment;

  const PaymentComponentCheckout({super.key, this.payment});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: payment == null
              ? Column(
                  children: [
                    const Text('No payment available!'),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(AppRoutes.addPayment),
                      child: const Text('Add New Payment'),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
