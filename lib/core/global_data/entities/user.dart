import 'package:flutter/foundation.dart';

@immutable
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? userName;
  final String? birthDay;
  final String? imageUrl;
  final String? createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.birthDay,
    required this.imageUrl,
    required this.createdAt,
  });
}
