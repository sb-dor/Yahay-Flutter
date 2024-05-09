extension MapExtension on Map {
  T? getValueByKey<T>(String key) {
    if (containsKey(key)) return this[key];
    return null;
  }
}
