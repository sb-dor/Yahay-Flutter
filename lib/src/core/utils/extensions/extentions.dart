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

extension ListExtensions<T> on List<T> {
  (T, int index)? getValueAndIndexOrNull(bool Function(T element) test) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) return (this[i], i);
    }
    return null;
  }
}
