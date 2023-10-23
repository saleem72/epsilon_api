//

class ProductDetails {
  final int id;
  final String code;
  final String name;
  final double enduser;
  final double enduser2;
  final String unity;
  final String barcode;
  final String matunit;
  final List<StoreQuntity> stores;

  ProductDetails({
    required this.id,
    required this.code,
    required this.name,
    required this.enduser,
    required this.unity,
    required this.enduser2,
    required this.barcode,
    required this.matunit,
    required this.stores,
  });
}

class StoreQuntity {
  final String store;
  final String quantity;

  StoreQuntity({
    required this.store,
    required this.quantity,
  });
}
