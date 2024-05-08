import 'package:talker/talker.dart';

class TalkerService {
  final talker = Talker();

  static TalkerService? _instance;

  static TalkerService get instance => _instance ??= TalkerService._();

  TalkerService._();
}
