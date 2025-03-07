import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class ReusableGlobalFunctions {
  static ReusableGlobalFunctions? _instance;

  static ReusableGlobalFunctions get instance => _instance ??= ReusableGlobalFunctions._();

  ReusableGlobalFunctions._();

  final _videoExtensions = [
    '.mp4',
    '.avi',
    '.mov',
    '.mkv',
    '.flv',
    '.wmv',
    '.webm',
    '.mpeg',
    '.mpg',
  ];

  final _imageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.bmp',
    '.tiff',
    '.tif',
    '.webp',
    '.ico',
    '.heic',
  ];

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

  //
  bool isVideoFile(String filePath) {
    // List of common video file extensions

    // Get the file extension
    final String extension = path.extension(filePath).toLowerCase();

    // Check if the file extension is in the list of video extensions
    return _videoExtensions.contains(extension);
  }

  bool isImageFile(String image) {
    //
    final String extension = path.extension(image).toLowerCase();

    return _imageExtensions.contains(extension);
  }

  //
  String getNormalDuration(Duration? duration) {
    String res = '';
    final int days = duration?.inDays ?? 0;
    if (days != 0) {
      res += '$days:';
    }
    final int hours = (duration?.inHours ?? 0) - (24 * (duration?.inDays ?? 0));
    if (days != 0) {
      if (hours >= 0 && hours <= 9) {
        res += '0$hours:';
      } else {
        res += '$hours:';
      }
    } else {
      if (hours != 0) {
        res += '$hours:';
      }
    }
    final int minutes = (duration?.inMinutes ?? 0) - (60 * (duration?.inHours ?? 0));
    if (minutes >= 0 && minutes <= 9) {
      res += "0$minutes:";
    } else {
      res += '$minutes:';
    }
    //to get totalSeconds in 60 type second
    final int seconds = (duration?.inSeconds ?? 0) - (60 * (duration?.inMinutes ?? 0));
    if (seconds >= 0 && seconds <= 9) {
      res += "0$seconds";
    } else {
      res += '$seconds';
    }

    return res;
  }

  bool get isMacOsOriOS {
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }
}
