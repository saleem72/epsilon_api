// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:epsilon_api/features/query_product/product_details_screen/data/dtos/new_product_dto.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/data/dtos/product_dto.dart';
import 'package:epsilon_api/features/query_product/product_details_screen/domain/models/product_datails.dart';

class ProductDTOWithStores {
  final ProductDto product;
  final List<Site> stores;

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
      stores: stores.map((e) => e.toStoreQuntity()).toList(),
    );
  }
}
