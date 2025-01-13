import 'dart:async';
import 'package:yahay/src/core/global_data/entities/user.dart';
import 'package:yahay/src/core/utils/list_pagination_checker/list_pagination_checker.dart';

final class AddContactStateModel {
  final List<User> users;
  final int page;
  final bool hasMore;
  final Timer? timerForSearch;

  const AddContactStateModel({
    this.users = const [],
    this.page = 1,
    this.hasMore = true,
    this.timerForSearch,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddContactStateModel &&
          runtimeType == other.runtimeType &&
          users == other.users &&
          page == other.page &&
          hasMore == other.hasMore &&
          timerForSearch == other.timerForSearch);

  @override
  int get hashCode => users.hashCode ^ page.hashCode ^ hasMore.hashCode ^ timerForSearch.hashCode;

  @override
  String toString() {
    return 'AddContactStateModel{ users: $users, page: $page,'
        ' hasMore: $hasMore, timerForSearch: $timerForSearch }';
  }

  /// Factory constructor for the initial state
  factory AddContactStateModel.idle() => const AddContactStateModel(
        users: <User>[],
        page: 1,
        hasMore: true,
      );

  /// Copy constructor with optional overrides
  AddContactStateModel copyWith({
    List<User>? users,
    int? page,
    bool? hasMore,
    Timer? timerForSearch,
  }) {
    return AddContactStateModel(
      users: users ?? this.users,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      timerForSearch: timerForSearch ?? this.timerForSearch,
    );
  }

  /// Update a user in the list
  AddContactStateModel updateUser(User? user) {
    if (user == null) return this;

    final updatedUsers = List<User>.from(users);
    final foundIndex = updatedUsers.indexWhere((el) => el.id == user.id);

    if (foundIndex != -1) {
      updatedUsers[foundIndex] = user;
    }

    return copyWith(users: updatedUsers);
  }

  /// Clear all data
  AddContactStateModel clearData() {
    return copyWith(users: [], page: 1, hasMore: false);
  }


}
