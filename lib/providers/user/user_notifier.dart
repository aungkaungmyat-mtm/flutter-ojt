import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojt_project/providers/user/user_state.dart';
import 'package:ojt_project/repositories/user_repo.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this.userId, this.userRepository) : super(const UserState());

  final String userId;
  final BaseUserRepository userRepository;

  void setImageData(Uint8List imageData) {
    state = state.copyWith(imageData: imageData);
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageData = await pickedFile.readAsBytes();
      setImageData(imageData);
    }
  }
}

final userNotifierProvider = StateNotifierProvider.autoDispose
    .family<UserNotifier, UserState, String>((ref, String userId) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserNotifier(userId, userRepository);
});
