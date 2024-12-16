import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default('') String userId,
    @Default('') String name,
    @Default('') String email,
    @Default('') String photoUrl,
    Uint8List? imageData,
  }) = _UserState;
}
