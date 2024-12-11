import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ojt_project/entities/user_data.dart';

class UserdataConverter implements JsonConverter<UserData, dynamic> {
  const UserdataConverter();

  @override
  UserData fromJson(dynamic data) {
    if (data == null) {
      return UserData();
    }
    final json = data as Map<String, dynamic>;
    return UserData.fromJson(json);
  }

  @override
  toJson(UserData userData) {
    return userData.toJson();
  }
}
