import 'package:flutter/foundation.dart';

@immutable
class ProfileEvents {}

@immutable
class ProfileLogoutEvent extends ProfileEvents {
  final void Function() logoutEvent;

  ProfileLogoutEvent(this.logoutEvent);
}
