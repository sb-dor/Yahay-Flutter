extension MapExtension on Map {
  T? getValueByKey<T>(String key) {
    if (containsKey(key)) return this[key];
    return null;
  }
}

extension NumEx on num {
  num? roundIt({int length = 2}) {
    return num.parse(toStringAsFixed(2));
  }
}
