//

import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/app_text_field.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

import 'presentation/widgets/invoice_search_client_picker.dart';
import 'presentation/widgets/invoice_search_date_picker.dart';

class InvoicesSearchScreen extends StatelessWidget {
  const InvoicesSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InvoicesSearchContentScreen();
  }
}

class InvoicesSearchContentScreen extends StatelessWidget {
  const InvoicesSearchContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavBar(title: context.translate.invoice),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    LabledValidateTextFIeld(
                      // controller: _serial,
                      label: context.translate.invoice_num,
                      hint: context.translate.invoice_num,
                      icon: AppIcons.invoiceNum,
                      onChange: (_) {},
                    ),
                    const SizedBox(height: 32),
                    InvoiceSearchDatePicker(
                      onChange: (date) {
                        print(date);
                      },
                    ),
                    const SizedBox(height: 32),
                    InvoiceSearchClientPicker(
                      onChange: (name) {
                        print(name);
                      },
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientButton(
                          label: context.translate.search,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
