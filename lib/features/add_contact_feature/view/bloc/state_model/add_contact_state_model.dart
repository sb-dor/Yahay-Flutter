import 'dart:async';

import 'package:yahay/core/global_data/entities/user.dart';
import 'package:yahay/core/utils/list_pagination_checker/list_pagination_checker.dart';
import 'package:yahay/injections/injections.dart';

class AddContactStateModel {
  Timer? timerForSearch;

  List<User> _users = [];

  List<User> get users => _users;

  int _page = 1;

  bool _hasMore = false;

  int get page => _page;

  bool get hasMore => _hasMore;

  void setChangedModel(User? user) {
    final foundIndex = _users.indexWhere((el) => el.id == user?.id);
    if (foundIndex != -1) {
      _users[foundIndex] = user!;
    }
  }

  void addAndPag(List<User> users, {bool paginate = false}) {
    if (paginate) {
      _users.addAll(users);
    } else {
      _users = users;
    }

    _page = snoopy<ListPaginationChecker>().checkIsListHasMorePageInt(list: users, page: page);
    _hasMore = snoopy<ListPaginationChecker>().checkIsListHasMorePageBool(list: users);
  }

  void clearData() {
    _users.clear();
    _page = 1;
    _hasMore = false;
  }
}
