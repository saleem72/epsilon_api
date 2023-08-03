//

double? converttoDouble(dynamic value) {
  return value is int ? (value).toDouble() : (value as double?);
}

extension DynamicToDouble on dynamic {
  double? converttoDouble() {
    return this is int ? (this).toDouble() : (this as double?);
  }
}
