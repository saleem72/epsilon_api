//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/core/widgets/loading_view.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/price.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/product_datails.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/presentation/bloc/product_details_bloc.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependancy_injection.dart' as di;
import '../product_details_screen/domain/models/barcode_or_serial.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({
    super.key,
    required this.input,
    required this.prices,
  });
  final BarcodeOrSerial input;
  final List<Price> prices;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<ProductDetailsBloc>()
        ..add(ProductDetailsEvent.getProduct(product: input)),
      child: ProductsListContentScreen(prices: prices),
    );
  }
}

class ProductsListContentScreen extends StatelessWidget {
  const ProductsListContentScreen({
    super.key,
    required this.prices,
  });
  final List<Price> prices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavBar(title: context.translate.search_by_name_result),
          // const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                builder: (context, state) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      state is ProductDetailsLoading
                          ? const LoadingView(
                              isLoading: true,
                              color: AppColors.primaryDark,
                            )
                          : const SizedBox.shrink(),
                      state is ProductDetailsWithFailure
                          ? GeneralErrorView(
                              onAction: () => context
                                  .read<ProductDetailsBloc>()
                                  .add(ProductDetailsEvent.clearError()),
                              failure: context.translate.unexpected_failure,
                            )
                          : const SizedBox.shrink(),
                      state is ProductDetailsSearchName
                          ? state.products.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    context.translate.no_search_results,
                                    style: Topology.largeTitle
                                        .copyWith(color: AppColors.primaryDark),
                                  ),
                                )
                              : _buildProductList(context, state.products)
                          : const SizedBox.shrink(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(
      BuildContext context, List<ProductDetails> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return ProductTile(
          product: product,
          onTap: () => _handleNavigate(context, product),
        );
      },
    );
  }

  _handleNavigate(BuildContext context, ProductDetails product) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          input: ProductDetailsInput(
            barcode:
                BarcodeOrSerial.barcode(barcode: product.code, prices: prices),
            product: null,
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });
  final ProductDetails product;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(),
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            Image.asset(
              AppIcons.userImage,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                product.name,
                style: Topology.body.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
