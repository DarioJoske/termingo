import 'package:termingo/src/core/common/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({required super.id, required super.email, required super.name});

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(id: json['id'] as String, email: json['email'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }
}
