import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ojt_project/entities/user_data.dart';
import 'package:ojt_project/utils/converters/converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ojt_project/utils/converters/userdata_converter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    String? id,
    @UserdataConverter() List<UserData>? userData,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
