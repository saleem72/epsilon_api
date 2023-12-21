//

import 'dart:developer' as developer;
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:epsilon_api/core/domian/models/pdf_invoice.dart';
import 'package:epsilon_api/core/errors/exceptions/app_exceptions.dart';
import 'package:epsilon_api/core/errors/exceptions/object_exception_extension.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/features/invoices/new_invoice/data/service/invoice_builder.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveFileService {
  static const arFont = 'assets/fonts/HacenTunisia.ttf';
  static const regularFontAsset = 'assets/fonts/Amiri-Regular.ttf';
  static const boldFontAsset = 'assets/fonts/Amiri-Bold.ttf';

  Future<Either<Failure, bool>> invoiceToPDF(PDFInvoice invoice) async {
    try {
      final regularFont = Font.ttf((await rootBundle.load(regularFontAsset)));
      final boldFont = Font.ttf((await rootBundle.load(boldFontAsset)));
      Uint8List? image;

      // if (invoice.company?.logo != null) {
      //   image = await _loadCompanyImage(invoice.company!.logo!);
      // }

      Document pdf = Document();
      pdf.addPage(
          InvoiceBuilder.createPage(invoice, regularFont, boldFont, image));

      Uint8List bytes = await pdf.save();
      final fileName =
          '${invoice.customer.customerName}_${invoice.invoice.number}';
      await saveFileToDownloads(fileName, bytes);
      return right(true);
    } catch (e) {
      return left(e.toFailure());
    }
  }

  // static Future<Uint8List> _loadCompanyImage(String path) async {
  //   final file = await rootBundle.load('assets/images/logo.jpg');
  //   return file.buffer.asUint8List();
  //   // final file = File(path);
  //   // return file.readAsBytes();
  // }

  Future<void> saveFileToDownloads(String fileName, Uint8List data) async {
    final downloads = await _getDoanloadsDirectory();
    if (downloads == null) {
      throw DownloadsDirectoryNotFoundException();
    } else {
      final hasPermission = await _checkPermission();
      if (hasPermission) {
        File target = File("${downloads.path}$fileName.pdf");
        await target.writeAsBytes(data, flush: true);
      } else {
        throw DownloadsDirectoryNotFoundException();
      }
    }
  }

  Future<Directory?> _getDoanloadsDirectory() async {
    if (Platform.isAndroid) {
      final downloads = Directory('/storage/emulated/0/Download/');
      final isExists = await downloads.exists();

      if (isExists) {
        return downloads;
      } else {
        return null;
      }
    } else if (Platform.isIOS) {
      final Directory? downloadsDir = await getDownloadsDirectory();
      return downloadsDir;
    }

    return null;
  }

  Future<PermissionStatus> _getAndroisPermission() async {
    developer.log("🎲 Requestion Android Permission", name: "save_image");
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    final sdkInt = deviceInfo.sdkInt;

    final status = sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    return status;
  }

  Future<PermissionStatus> _getIOSPermission() async {
    developer.log("🎲 Requestion IOS Permission", name: "save_image");
    return Permission.storage.request();
  }

  Future<bool> _checkPermission() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      status = await _getAndroisPermission();
    } else if (Platform.isIOS) {
      status = await _getIOSPermission();
    } else {
      status = PermissionStatus.restricted;
    }

    developer.log("🎲 Permission $status", name: "save_image");
    if (status.isDenied) {
      final temp = await Permission.storage.request();
      if (temp.isGranted) {
        return true;
      } else {
        throw DownloadsDirectoryNotFoundException();
      }
    }
    if (status.isRestricted) {
      throw DownloadsDirectoryNotFoundException();
    }
    if (status.isGranted) {
      return true;
    }
    return false;
  }

  Future<void> saveInvoiceImage(
      {required String fileName, required String imageStr}) async {
    final downloads = await _getDoanloadsDirectory();
    if (downloads == null) {
      throw DownloadsDirectoryNotFoundException();
    } else {
      final hasPermission = await _checkPermission();
      if (hasPermission) {
        File target = File("${downloads.path}$fileName.jpg");
        final data = base64Decode(imageStr);
        await target.writeAsBytes(data, flush: true);
      } else {
        throw DownloadsDirectoryNotFoundException();
      }
    }
  }
}

extension BaseDeviceInfoDetails on BaseDeviceInfo {
  int get sdkInt {
    final data = this.data;
    final version = data['version'] as Map<Object?, Object?>;
    final val = version['sdkInt'] as int;
    return val;
  }
}
