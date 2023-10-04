// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/dependancy_injection.dart' as di;

import '../../../../core/widgets/app_nav_bar.dart';
import '../../../../core/widgets/loading_view.dart';
import 'domain/models/barcode_or_serial.dart';
import 'domain/models/product_datails.dart';
import 'presentation/bloc/product_details_bloc.dart';
import 'presentation/widgets/product_card.dart';

class ProductDetailsInput {
  final BarcodeOrSerial barcode;
  final ProductDetails? product;

  ProductDetailsInput({
    required this.barcode,
    required this.product,
  });
}

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.input,
  });
  final ProductDetailsInput input;

  @override
  Widget build(BuildContext context) {
    return input.product == null
        ? BlocProvider(
            create: (context) => di.locator<ProductDetailsBloc>()
              ..add(ProductDetailsEvent.getProduct(product: input.barcode)),
            child: const ProductDetailsScreenContent(),
          )
        : ProductDetailsBaseWidget(
            child: ProductCard(
              product: input.product,
            ),
          );
  }
}

class ProductDetailsScreenContent extends StatelessWidget {
  const ProductDetailsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return _content(
      context: context,
    );
  }

  Widget _content({required BuildContext context}) {
    return ProductDetailsBaseWidget(
      child: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    state is ProductDetailsWithSuccess
                        ? const SizedBox.shrink()
                        : const SingleChildScrollView(
                            child: ProductCard(),
                          ),
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
                            failure: state.failure,
                          )
                        : const SizedBox.shrink(),
                    state is ProductDetailsWithSuccess
                        ? _buildProductCard(context, state.product)
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductDetails product) {
    return ProductCard(product: product);
  }
}

class ProductDetailsBaseWidget extends StatelessWidget {
  const ProductDetailsBaseWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavBar(title: context.translate.query_subject_screen),
          const SizedBox(height: 16),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.image,
              size: 80,
              color: Colors.white,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
