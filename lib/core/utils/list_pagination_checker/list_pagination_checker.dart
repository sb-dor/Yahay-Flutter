import 'package:yahay/core/global_usages/constants/constants.dart';

class ListPaginationChecker {
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
}
