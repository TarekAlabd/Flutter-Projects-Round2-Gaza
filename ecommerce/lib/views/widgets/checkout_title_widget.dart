import 'package:flutter/material.dart';

class CheckoutTitleWidget extends StatelessWidget {
  final String title;
  final String? number;
  final VoidCallback? onTap;

  const CheckoutTitleWidget({
    super.key,
    required this.title,
    this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          number != null ? '$title($number)' : title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: const Text('Edit'),
          ),
      ],
    );
  }
}
