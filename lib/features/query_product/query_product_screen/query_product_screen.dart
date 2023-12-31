//

import 'dart:math';

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/core/domian/models/barcode_or_serial.dart';
import 'package:epsilon_api/core/domian/models/price.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/features/query_product/products_list_screen/products_list_screen.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/presentation/widgets/prices_selector/presentation/prices_selector_bloc/prices_selector_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_nav_bar.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../product_details_screen/product_details_screen.dart';
import 'presentation/widgets/prices_selector/prices_selector.dart';
import 'presentation/widgets/scanner_view.dart';

class QueryProductScreen extends StatefulWidget {
  const QueryProductScreen({super.key});

  @override
  State<QueryProductScreen> createState() => _QueryProductScreenState();
}

class _QueryProductScreenState extends State<QueryProductScreen> {
  final TextEditingController _serial = TextEditingController();
  List<Price> prices = [];
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bloc = context.read<PricesSelectorBloc>();
      initCam(bloc);
    });
  }

  initCam(PricesSelectorBloc bloc) async {
    bloc.add(PricesSelectorFetchDataEvent());
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        isReady = true;
      });
    }
  }

  @override
  void dispose() {
    _serial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavBar(title: context.translate.query_subject_screen),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    _scnnerArea(context),
                    const SizedBox(height: 32),
                    isReady
                        ? PricesSelector(
                            onChange: (selectedPrices) {
                              setState(() {
                                prices = selectedPrices.map((e) => e).toList();
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 16),
                    _orRow(context),
                    const SizedBox(height: 16),
                    _serialTextFIeld(context),
                  ],
                ),
              ),
            ),
          ),
          _executeButton(context)
        ],
      ),
    );
  }

  double getScanAreaHeight(BuildContext context) {
    // const double contentHeight = 88 // appBar
    //     +
    //     (30 * 2) // scan area vertical padding
    //     +
    //     56 // prices section
    //     +
    //     64 +
    //     16 // gap
    //     +
    //     24 // or
    //     +
    //     16 // gap
    //     +
    //     82 // text field
    //     +
    //     60; // button
    // final totalHeight = MediaQuery.of(context).size.height;
    // return totalHeight - contentHeight;

    final width = context.mediaQuery.size.width - 32;
    return width / 2;
  }

  Widget _scnnerArea(BuildContext context) {
    final height = getScanAreaHeight(context);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: isReady ? _scannerView(context, height) : const SizedBox.shrink(),
    );
  }

  // ignore: unused_element
  Widget _faceCam() {
    final height = getScanAreaHeight(context);
    final shortSide = min(MediaQuery.of(context).size.width, height);
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: shortSide - 80,
        width: shortSide - 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _scannerView(BuildContext context, double height) {
    final height = getScanAreaHeight(context);
    final width = MediaQuery.of(context).size.width - 32;

    return ScannerView(
      onGettingBarcode: (barcode) => _handleBarcode(context, barcode),
      borderRadius: 30,
      height: height,
      width: width,
    );
  }

  Widget _executeButton(BuildContext context) {
    return GradientButton(
      label: context.translate.ok_button,
      isEnabled: true, // _serial.text.isNotEmpty,
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_serial.text.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ProductsListScreen(
                input: BarcodeOrSerial.serial(
                    serial: _serial.text, prices: prices),
                prices: prices,
              ),
            ),
          );

          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => ProductDetailsScreen(
          //       // input: BarcodeOrSerial.serial(serial: _serial.text),
          //       // 800199  CHR-ADBZ-EG-02270315

          //       input: BarcodeOrSerial.barcode(barcode: _serial.text),
          //     ),
          //   ),
          // );
        }
      },
    );
  }

  Widget _serialTextFIeld(BuildContext context) {
    return LabledValidateTextFIeld(
        controller: _serial,
        label: context.translate.product_search,
        hint: context.translate.product_search_hint,
        icon: AppIcons.serialNumber,
        onChange: (_) {},
        labelStyle: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: context.colorScheme.primary,
        ));
  }

  Widget _orRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.primaryLight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            context.translate.or_label,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.primary,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.primaryLight,
          ),
        ),
      ],
    );
  }

  void _handleBarcode(BuildContext context, String barcode) {
    setState(() {
      isReady = false;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          input: ProductDetailsInput(
            barcode: BarcodeOrSerial.barcode(barcode: barcode, prices: prices),
            product: null,
          ),
        ),
      ),
    );
  }
}
