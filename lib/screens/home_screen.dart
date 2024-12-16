import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ojt_project/assets/assets.gen.dart';
import 'package:ojt_project/config/config.dart';
import 'package:ojt_project/providers/common_provider/common_provider.dart';
import 'package:ojt_project/screens/auth/login_screen.dart';
import 'package:ojt_project/screens/profile/profile_screen.dart';
import 'package:ojt_project/screens/todo/todo_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key, required this.authUser});
  final auth.User authUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    Future<void> logout() async {
      await auth.FirebaseAuth.instance.signOut();
      logger.i("User Successfully Logged Out");
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Logout Successful"),
        ),
      );
      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          GestureDetector(
            onTap: logout,
            child: Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                Assets.icons.logoutIcon,
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          currentIndex.value = index;

          switch (index) {
            case 0:
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const TodoScreen(),
                ),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userId: authUser.uid,
                  ),
                ),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_add,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.note_add,
              color: Colors.yellow,
            ),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
