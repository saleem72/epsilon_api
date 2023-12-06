//

import 'package:epsilon_api/core/domian/models/invoice_ui_item.dart';
import 'package:epsilon_api/core/domian/models/pdf_invoice.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'invoice_strings.dart';

class InvoiceBuilder {
  static Page createPage(
      PDFInvoice invoice, Font regularFont, Font boldFont, Uint8List? image) {
    final dateFormatter = intl.DateFormat('yy/MM/dd hh:mm');
    return Page(
      textDirection: TextDirection.rtl,
      theme: ThemeData.withFont(
        base: regularFont,
        bold: boldFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (context) {
        return Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: _content(invoice, image, dateFormatter),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    dateFormatter.format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _content(
      PDFInvoice invoice, Uint8List? image, intl.DateFormat dateFormat) {
    final numberFormatter = intl.NumberFormat('#,###.##');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (image != null) _buildLogo(image),
        _companyInfo(invoice, dateFormat),
        SizedBox(height: 4),
        _invoiceNum(invoice),
        _customer(invoice),
        SizedBox(height: 4),
        buildInvoice(invoice, numberFormatter),
        SizedBox(height: 4),
        Container(
          height: 1,
          decoration: BoxDecoration(
            color: PdfColor.fromHex("000000"),
          ),
        ),
        SizedBox(height: 4),
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    InvoiceStrings.invoiceSubTotal,
                    style: const TextStyle(fontSize: 10),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      numberFormatter.format(invoice.invoice.subTotal),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Text(
                        InvoiceStrings.tax,
                        style: const TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          numberFormatter.format(invoice.invoice.totalTax),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  )),
              Row(
                children: [
                  Text(
                    InvoiceStrings.invoiceTotal,
                    style: const TextStyle(fontSize: 10),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      numberFormatter.format(invoice.invoice.billFinal),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Row _invoiceNum(PDFInvoice invoice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(InvoiceStrings.invoiceNum),
        SizedBox(width: 8),
        Expanded(
          child: Text(invoice.invoice.number),
        ),
      ],
    );
  }

  static Row _companyInfo(PDFInvoice invoice, intl.DateFormat dateFormat) {
    return Row(
      children: [
        // _buildQR(invoice, dateFormat),
        Expanded(
          child: _companyDetails(invoice),
        ),
      ],
    );
  }

  static Container _buildQR(PDFInvoice invoice, intl.DateFormat dateFormat) {
    String qrString = """
Invoice num: ${invoice.invoice.id},
date: ${dateFormat.format(DateTime.now())},
total: ${invoice.invoice.billFinal}
""";
    return Container(
      height: 50,
      width: 50,
      child: BarcodeWidget(
        barcode: Barcode.qrCode(),
        data: qrString,
      ),
    );
  }

  static Column _companyDetails(PDFInvoice invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(invoice.companyInfo.name),
        if (invoice.companyInfo.phone != null)
          Text(
            invoice.companyInfo.phone!,
            style: const TextStyle(fontSize: 10),
          ),
        if (invoice.companyInfo.address != null)
          Text(invoice.companyInfo.address!),
      ],
    );
  }

  static Row _customer(PDFInvoice invoice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(InvoiceStrings.customerFreeze),
        Expanded(
          child: Text(invoice.customer.customerName),
        ),
      ],
    );
  }

  static Widget buildInvoice(PDFInvoice invoice, intl.NumberFormat formatter) {
    return Table(
      // border: const TableBorder(
      //   // left: BorderSide(),
      //   // right: BorderSide(),
      //   // top: BorderSide(),
      //   // bottom: BorderSide(),
      // ),
      children: [
        _tableHeader(),
        ...invoice.invoiceItems.map<TableRow>((e) => _tableItem(e, formatter)),
      ],
      columnWidths: {
        0: const FlexColumnWidth(2),
        1: const FlexColumnWidth(2),
        2: const FlexColumnWidth(1),
        3: const FlexColumnWidth(4),
      },
    );
  }

  static TableRow _tableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: PdfColor.fromHex('F3f3f3'),
      ),
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(),
              top: BorderSide(),
              bottom: BorderSide(),
            ),
          ),
          child: Text(
            InvoiceStrings.itemTotal,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            InvoiceStrings.retail,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(),
              top: BorderSide(),
              bottom: BorderSide(),
            ),
          ),
          child: Text(
            InvoiceStrings.quantity,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(),
              top: BorderSide(),
              bottom: BorderSide(),
            ),
          ),
          child: Text(
            InvoiceStrings.product,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  static TableRow _tableItem(InvoiceUiItem item, intl.NumberFormat formatter) {
    return TableRow(
      children: [
        Text(
          formatter.format(item.total),
          style: const TextStyle(fontSize: 8),
          textAlign: TextAlign.center,
        ),
        Text(
          formatter.format(item.price),
          style: const TextStyle(fontSize: 8),
          textAlign: TextAlign.center,
        ),
        Text(
          item.quantity.toString(),
          style: const TextStyle(fontSize: 8),
          textAlign: TextAlign.center,
        ),
        Text(
          item.product.name,
          style: const TextStyle(fontSize: 8),
        ),
      ],
    );
  }

  static Widget _buildLogo(Uint8List image) {
    return Center(
      child: Container(
        height: 50.0,
        width: 50,
        child: Image(
          MemoryImage(image),
        ),
      ),
    );
  }
}
