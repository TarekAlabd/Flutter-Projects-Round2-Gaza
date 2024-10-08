import 'package:ecommerce/utils/app_routes.dart';
import 'package:ecommerce/view_models/address_cubit/address_cubit.dart';
import 'package:ecommerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce/views/pages/add_new_payment_page.dart';
import 'package:ecommerce/views/pages/address_page.dart';
import 'package:ecommerce/views/pages/checkout_page.dart';
import 'package:ecommerce/views/pages/product_details_page.dart';
import 'package:ecommerce/views/pages/sign_in_page.dart';
import 'package:ecommerce/views/widgets/custom_bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.productDetails:
        final productId = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(productId);
              return cubit;
            },
            child: const ProductDetailsPage(),
          ),
        );
      case AppRoutes.home:
        return CupertinoPageRoute(
          builder: (_) => const CustomBottomNavbar(),
        );
      case AppRoutes.addPayment:
        return CupertinoPageRoute(
          builder: (_) => const AddNewPaymentPage(),
        );
      case AppRoutes.address:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = AddressCubit();
              cubit.fetchAddresses();
              return cubit;
            },
            child: const AddressPage(),
          ),
        );
      case AppRoutes.checkout:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = CheckoutCubit();
              cubit.getCheckoutData();
              return cubit;
            },
            child: const CheckoutPage(),
          ),
        );
      case AppRoutes.signIn:
      default:
        return CupertinoPageRoute(
          builder: (_) => const SignInPage(),
        );
    }
  }
}
