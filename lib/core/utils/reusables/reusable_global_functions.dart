class ReusableGlobalFunctions {

  /// Removes duplicate elements from a list based on a custom test function.
  ///
  /// This function iterates through the provided list and removes elements that
  /// are considered duplicates according to the `test` function. The `test`
  /// function should take two elements and return `true` if they are considered
  /// duplicates, and `false` otherwise.
  ///
  /// The function works by using a nested loop to compare each element with every
  /// other element that comes after it in the list. If two elements are found to
  /// be duplicates, the earlier element is removed from the list.
  ///
  /// Note: The order of elements in the list is preserved, but the first occurrence
  /// of each duplicate element is retained.
  ///
  /// Example usage:
  /// ```dart
  /// List<int> numbers = [1, 2, 3, 2, 4, 1];
  /// numbers = await removeDuplicatesFromList(
  ///   list: numbers,
  ///   test: (a, b) => a == b,
  /// );
  /// print(numbers); // Output: [3, 2, 4, 1]
  /// ```
  ///
  /// Type parameters:
  /// - `T`: The type of elements in the list.
  ///
  /// Parameters:
  /// - `list`: The list from which duplicates should be removed.
  /// - `test`: A function that takes two elements of type `T` and returns `true`
  ///   if they are considered duplicates, `false` otherwise.
  ///
  /// Returns:
  /// A new list with duplicates removed.
  ///
  /// Throws:
  /// This function does not throw exceptions but it modifies the input list.
  Future<List<T>> removeDuplicatesFromList<T>({
    required List<T> list,
    required bool Function(T element1, T element2) test,
  }) async {
    for (int i = 0; i < list.length; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if (test(list[i], list[j])) {
          list.removeAt(j);
          j--;
        }
      }
    }
    return list;
  }
}
