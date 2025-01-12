import 'package:yahay/core/global_usages/constants/constants.dart';

class ListPaginationChecker {
  static ListPaginationChecker? _instance;

  static ListPaginationChecker get instance => _instance ??= ListPaginationChecker._();

  ListPaginationChecker._();

  // this func will check whether there are more values in list of pag (returns integer)
  int checkIsListHasMorePageInt(
      {required List<dynamic> list, required int page, int? limitInPage}) {
    if (list.length < (limitInPage ?? Constants.perPage)) {
      page = 1;
    } else {
      page++;
    }
    return page;
  }

  // this func will check whether there are more values in list of pag (returns boolean)
  bool checkIsListHasMorePageBool({required List<dynamic> list, int? limitInPage}) {
    if (list.length < (limitInPage ?? Constants.perPage)) {
      return false;
    } else {
      return true;
    }
  }

  List<T> paginateList<T>(
      {required List<T> wholeList,
      required List<T> currentList,
      int perPage = 30,
      bool showingCircularProgress = true}) {
    //if do not want to show any progress indicators in your screen -> set "showingCircularProgress" to "false"
    //you should not use any check variable, this function parameter "showingCircularProgress" will know automatically
    //and it checks whether list still has items or not
    if (!showingCircularProgress) {
      bool hasMore = currentList.length >= wholeList.length ? false : true;
      if (!hasMore) return [];
    }
    //check in which list index we are at
    int check = (currentList.length + perPage) > wholeList.length
        ? wholeList.length
        : (currentList.length + perPage);
    List<T> pagList = [];
    for (int i = currentList.length; i < check; i++) {
      pagList.add(wholeList[i]);
    }
    return pagList;
  }
}
