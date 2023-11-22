//

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/configuration/routing/routing_error.dart';
import 'package:epsilon_api/core/domian/models/customer.dart';
import 'package:epsilon_api/core/domian/models/voucher_type.dart';
import 'package:epsilon_api/features/customer_account/customer_acctount_screen/customer_account_screen.dart';
import 'package:epsilon_api/features/customer_account/customer_search/customer_search.dart';
import 'package:epsilon_api/features/invoices/Invoices_movement/Invoices_movement_screen.dart';
import 'package:epsilon_api/features/login_screen/login_screen.dart';
import 'package:epsilon_api/features/operations_screen/operations_screen.dart';
import 'package:epsilon_api/features/pre_launch/landing_screen.dart';
import 'package:epsilon_api/features/query_product/query_product_screen/query_product_screen.dart';
import 'package:epsilon_api/features/vouchers/finance_voucher_screen/finance_voucher_screen.dart';
import 'package:epsilon_api/features/vouchers/vouchers_selection_screen/vouchers_selection_screen.dart';
import 'package:flutter/material.dart';

import '../../features/invoices/new_invoice/add_invoice_screen.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generate(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case AppScreens.initial:
        return MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        );
      case AppScreens.home:
        return MaterialPageRoute(
          builder: (context) => const OperationsScreen(),
        );
      case AppScreens.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case AppScreens.querySubjectScreen:
        return MaterialPageRoute(
          builder: (context) => const QueryProductScreen(),
        );
      case AppScreens.customerSearch:
        return MaterialPageRoute(
          builder: (context) => const CustomerSearch(),
        );

      case AppScreens.customerAccount:
        final customer = settings.arguments as Customer?;
        if (customer == null) {
          return MaterialPageRoute(
            builder: (context) =>
                const RoutingError(errorMessage: "Customer is Missing"),
          );
        }
        return MaterialPageRoute(
            builder: (_) => CustomerAccountScreen(
                  customer: customer,
                ));
      case AppScreens.vouchersSelection:
        return MaterialPageRoute(
          builder: (context) => const VouchersSelectionScreen(),
        );
      case AppScreens.recipientVoucher:
        return MaterialPageRoute(
          builder: (context) => const FinanceVoucherScreen(
              voucherType: VoucherCategory.recipient),
        );
      case AppScreens.paymentVoucher:
        return MaterialPageRoute(
          builder: (context) =>
              const FinanceVoucherScreen(voucherType: VoucherCategory.payment),
        );
      case AppScreens.newInvoice:
        return MaterialPageRoute(
          builder: (context) => const AddInvoiceScreen(),
        );
      case AppScreens.invoicesMovement:
        return MaterialPageRoute(
          builder: (context) => const InvoicesMovementScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              RoutingError(errorMessage: "Unknow route ${settings.name}"),
        );
    }
  }
}
