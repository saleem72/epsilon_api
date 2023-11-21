//

double? converttoDouble(dynamic value) {
  return value is int ? (value).toDouble() : (value as double?);
}

extension DynamicToDouble on dynamic {
  double? toDouble() {
    return (this is num) ? (this as num).toDouble() : null;
  }
}
