//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/core/widgets/app_dropdown_button.dart';
import 'package:epsilon_api/core/widgets/app_small_button.dart';
import 'package:epsilon_api/core/widgets/circle_button.dart';
import 'package:epsilon_api/core/widgets/flipping_button.dart';
import 'package:intl/intl.dart' as intl;
import 'package:epsilon_api/dependancy_injection.dart' as di;
import 'package:epsilon_api/core/domian/models/product_unit.dart';
import 'package:epsilon_api/core/widgets/dotted_text_field.dart';
import 'package:flutter/services.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/core/domian/models/invoice_type.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_date_picker.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/dashed_line.dart';
import 'package:epsilon_api/core/widgets/dotted_dropdown_text_field.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'invoice_widgets.dart';
import 'presentation/invoice_bloc/invoice_bloc.dart';

class AddInvoiceScreen extends StatelessWidget {
  const AddInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => InvoiceBloc(
        repository: di.locator(),
        service: di.locator(),
      )..add(InvoiceFetchDataEvent()),
      child: const AddInvoicesContentScreen(),
    );
  }
}

class AddInvoicesContentScreen extends StatefulWidget {
  const AddInvoicesContentScreen({super.key});

  @override
  State<AddInvoicesContentScreen> createState() =>
      _AddInvoicesContentScreenState();
}

class _AddInvoicesContentScreenState extends State<AddInvoicesContentScreen> {
  final TextEditingController _customer = TextEditingController();
  final TextEditingController _product = TextEditingController();
  final TextEditingController _quantity = TextEditingController();

  @override
  void dispose() {
    _customer.dispose();
    _product.dispose();
    _quantity.dispose();
    super.dispose();
  }

  void _itemHasAdded() {
    _quantity.clear();
    _product.clear();
  }

  _clearView() {
    _customer.clear();
    _product.clear();
    _quantity.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _mainScaffold(context),
        const AddInvoiceLoadingView(),
        const AddInvoiceFailureView(),
        SuccessAddInvoiceView(
          onClose: () {
            _clearView();
            context.read<InvoiceBloc>().add(InvoiceClearSuccessEvent());
          },
        ),
        const IgnorePointer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Spacer(),
                InvoiceItemsTotalsView(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Scaffold _mainScaffold(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavBar(title: context.translate.invoice),
          BlocConsumer<InvoiceBloc, InvoiceState>(
            // listenWhen: (previous, current) =>
            //     previous.hasAddedItem != current.hasAddedItem,
            listener: (context, state) {
              if (state.hasAddedItem) {
                _itemHasAdded();
                context.read<InvoiceBloc>().add(InvoiceClearItemRelatedEvent());
              }
            },
            builder: (context, state) {
              return _viewLayers(state);
            },
          ),
        ],
      ),
    );
  }

  Widget _viewLayers(InvoiceState state) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 500),
            firstChild: Container(
              key: const ValueKey('main_view'),
              child: _mainView(state),
            ),
            secondChild: _extraButtons(),
            crossFadeState: state.showMain
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          Positioned(
            bottom: 21,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AddInvoiceFlipButton(
                  isEnabled: state.isInvoiceReady,
                  initialValue: state.showMain,
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 21,
          //   left: 16,
          //   right: 80,
          //   child: InvoiceItemsTotalsView(state: state),
          // ),
        ],
      ),
    );
  }

  Widget _mainView(InvoiceState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _mainContent(context, state),
      ),
    );
  }

  Widget _extraButtons() {
    return Container(
      key: const ValueKey('extra_buttons'),
      // color: Colors.green,
      height: double.maxFinite,
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleButton(
                  image: AppIcons.createPDF,
                  label: context.translate.create_pdf,
                  onPress: () {
                    context
                        .read<InvoiceBloc>()
                        .add(const InvoiceFlipViewsEvent(value: true));
                    context
                        .read<InvoiceBloc>()
                        .add(InvoiceCreateInvoiceWithPDFEvent());
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleButton(
                      image: AppIcons.plus,
                      label: context.translate.create_invoice,
                      onPress: () {
                        context
                            .read<InvoiceBloc>()
                            .add(const InvoiceFlipViewsEvent(value: true));
                        context
                            .read<InvoiceBloc>()
                            .add(InvoiceCreateInvoiceEvent());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _mainContent(BuildContext context, InvoiceState state) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: _invoiceType(context, state),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: _datePicker(context, state.selectedDate),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _customerSelector(context, state),
        const SizedBox(height: 24),
        _productSelector(context, state),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: _units(context, state),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: _quantityTextField(context, state),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: AppSmallButton(
                label: context.translate.add,
                isEnabled: state.isItemReady,
                onPressed: () =>
                    context.read<InvoiceBloc>().add(InvoiceAddItemEvent()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        InvoiceItemListUi(invoiceItems: state.invoiceItems),
        const SizedBox(height: 16),

        // _createInvoiceButton(context, state.isInvoiceReady, state.invoiceTotal),
        // const SizedBox(height: 32),
      ],
    );
  }

  // Widget _createInvoiceButton(
  //     BuildContext context, bool isInvoiceReady, double total) {
  //   final formatter = intl.NumberFormat('#,##0.##');
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       GradientButton(
  //         width: context.mediaQuery.size.width - 64,
  //         label: context.translate.create_invoice,
  //         secondLabel: total > 0 ? formatter.format(total) : '',
  //         isEnabled: isInvoiceReady,
  //         onPressed: () {
  //           context.read<InvoiceBloc>().add(InvoiceCreateInvoiceEvent());
  //         },
  //       ),
  //     ],
  //   );
  // }

  AppTextFieldWithLabel _quantityTextField(
      BuildContext context, InvoiceState state) {
    return AppTextFieldWithLabel(
      controller: _quantity,
      label: context.translate.subject_quntity,
      hint: context.translate.subject_quntity,
      isValid: state.quantity > 0,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      onChanged: (p0) => context
          .read<InvoiceBloc>()
          .add(InvoiceQuantityChangedEvent(quantity: p0)),
    );
  }

  AppDropdownButton _units(BuildContext context, InvoiceState state) {
    return AppDropdownButton(
      label: context.translate.units,
      fullFilled: state.selectedUnit != null,
      dropdownButton: _unitsDropdown(state, context),
    );
  }

  DottedDropdownTextField _productSelector(
      BuildContext context, InvoiceState state) {
    return DottedDropdownTextField(
      label: context.translate.products,
      hint: context.translate.products,
      controller: _product,
      options: state.products.map((e) => e.name).toList(),
      onSelection: (product) {
        context
            .read<InvoiceBloc>()
            .add(InvoiceSelectedProductChangedEvent(product: product));
      },
      fullFilled: state.selectedProduct != null,
    );
  }

  DottedDropdownTextField _customerSelector(
      BuildContext context, InvoiceState state) {
    return DottedDropdownTextField(
      label: context.translate.agent,
      hint: context.translate.agent,
      controller: _customer,
      options: state.customers.map((e) => e.customerName).toList(),
      onSelection: (customer) {
        context
            .read<InvoiceBloc>()
            .add(InvoiceSelectedCustomerChangedEvent(customer: customer));
      },
      fullFilled: state.selectedCustomer != null,
    );
  }

  AppDropdownButton _invoiceType(BuildContext context, InvoiceState state) {
    return AppDropdownButton(
      label: context.translate.invoice_type,
      fullFilled: state.selectedType != null,
      dropdownButton: _invoiceTypeDropdown(state, context),
    );
  }

  Widget _datePicker(BuildContext context, DateTime selectedDate) {
    final formatter = intl.DateFormat('dd/MM/yyyy');
    return AppDatePicker(
      restorationId: "RecipientVoucherScreen",
      onChange: (date) {
        context.read<InvoiceBloc>().add(InvoiceDateChangedEvent(date: date));
        // setState(() {
        //   _selectedDate = date;
        // });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                context.translate.date,
                style: Topology.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const DashedLine(
                  color: Colors.black,
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(formatter.format(selectedDate)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DropdownButton<InvoiceType> _invoiceTypeDropdown(
      InvoiceState state, BuildContext context) {
    return DropdownButton<InvoiceType>(
      value: state.selectedType,
      isExpanded: true,
      icon: const TriangleIcon(),
      elevation: 16,
      style: Topology.body.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      onChanged: (InvoiceType? value) {
        if (value != null) {
          context.read<InvoiceBloc>().add(InvoiceTypeChangedEvent(type: value));
        }
      },
      items: state.invoiceTypes.map<DropdownMenuItem<InvoiceType>>((value) {
        return DropdownMenuItem<InvoiceType>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

  DropdownButton<ProductUnit> _unitsDropdown(
      InvoiceState state, BuildContext context) {
    return DropdownButton<ProductUnit>(
      value: state.selectedUnit,
      isExpanded: true,
      icon: const TriangleIcon(),
      elevation: 16,
      style: Topology.body.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      onChanged: (ProductUnit? value) {
        if (value != null) {
          context
              .read<InvoiceBloc>()
              .add(InvoiceSelectedUnitChangedEvent(unit: value));
        }
      },
      items: state.units.map<DropdownMenuItem<ProductUnit>>((value) {
        return DropdownMenuItem<ProductUnit>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}

class InvoiceItemsTotalsView extends StatelessWidget {
  const InvoiceItemsTotalsView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        return _buildWidget(context, state);
      },
    );
  }

  AnimatedOpacity _buildWidget(BuildContext context, InvoiceState state) {
    final formatter = intl.NumberFormat('#,##0.##');
    return AnimatedOpacity(
      opacity: state.invoiceItems.isNotEmpty && state.showMain ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: 100,
        padding: const EdgeInsets.only(
          right: 80,
          left: 16,
          bottom: 21,
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.grey.shade300,
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          context.translate.tax,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          context.translate.sub_total,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          context.translate.final_totoal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(),
                  right: BorderSide(),
                  bottom: BorderSide(),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(),
                        ),
                      ),
                      child: Text(
                        formatter.format(state.invoiceTaxTotal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(),
                        ),
                      ),
                      child: Text(
                        formatter.format(state.invoiceSubTotal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      formatter.format(state.invoiceTotal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddInvoiceFlipButton extends StatelessWidget {
  const AddInvoiceFlipButton({
    super.key,
    required this.isEnabled,
    required this.initialValue,
  });

  final bool isEnabled;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    return FlippingButton(
      initialValue: initialValue,
      isEnabled: isEnabled,
      onPress: (forward) {
        context.read<InvoiceBloc>().add(InvoiceFlipViewsEvent(value: forward));
      },
    );
  }
}

class SuccessAddInvoiceView extends StatelessWidget {
  const SuccessAddInvoiceView({
    super.key,
    required this.onClose,
  });
  final Function onClose;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        return state.addedSuccessfully == null
            ? const SizedBox.shrink()
            : _content(context, state.addedSuccessfully!, state.invoiceNumber);
      },
    );
  }

  Container _content(BuildContext context, int number, String? invoiceNumber) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              margin: const EdgeInsets.only(
                  left: 16, right: 16, top: 54, bottom: 38),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${context.translate.add_invoice_success} ($invoiceNumber)',
                          style: Topology.largeTitle.copyWith(
                            color: AppColors.primaryDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  GradientButton(
                    label: context.translate.ok,
                    onPressed: () => onClose(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
