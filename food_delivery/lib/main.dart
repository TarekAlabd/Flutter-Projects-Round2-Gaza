import 'package:flutter/material.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/app_theme.dart';
import 'package:food_delivery/views/pages/custom_bottom_navbar.dart';
import 'package:food_delivery/views/pages/product_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      theme: AppTheme.lightTheme(),
      home: const CustomBottomNavbar(),
      routes: {
        ProductDetailsPage.routeName: (context) => const ProductDetailsPage(),
      },
    );
  }
}
