// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/core/domian/models/product_datails.dart';

import 'product_by_barcode_response.dart';
import 'product_dto.dart';

class ProductDTOWithStores {
  final ProductDto product;
  final List<SiteDTO> stores;

  ProductDTOWithStores({
    required this.product,
    required this.stores,
  });

  ProductDetails toProduct() {
    return ProductDetails(
      id: product.id ?? 0,
      code: product.code ?? '',
      name: product.name ?? '',
      enduser: product.price ?? 0,
      unity: product.unitName ?? '',
      enduser2: product.price2 ?? 0,
      barcode: '',
      matunit: '',
      imageBase64: product.document,
      stores: stores.map((e) => e.toStoreQuntity()).toList(),
    );
  }
}
