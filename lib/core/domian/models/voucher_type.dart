//

enum VoucherType {
  recipient,
  payment;

  int get typeId => this == VoucherType.recipient ? 2 : 3;
}
