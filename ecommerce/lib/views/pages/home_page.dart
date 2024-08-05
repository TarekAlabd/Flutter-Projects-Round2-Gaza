import 'package:ecommerce/view_models/home_tab_cubit/home_tab_cubit.dart';
import 'package:ecommerce/views/widgets/category_tab_inner_page.dart';
import 'package:ecommerce/views/widgets/home_tab_inner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            dividerHeight: 0,
            tabs: [
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Category',
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: TabBarView(
              children: [
                BlocProvider(
                  create: (context) {
                    final cubit = HomeTabCubit();
                    cubit.getHomeData();
                    return cubit;
                  },
                  child: const HomeTabInnerPage(),
                ),
                const CategoryTabInnerPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
