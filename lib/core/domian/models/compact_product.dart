// ignore_for_file: public_member_api_docs, sort_constructors_first
//

class CompactProduct {
  final int id;
  final String name;

  CompactProduct({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'CompactProduct(id: $id, name: $name)';
}
