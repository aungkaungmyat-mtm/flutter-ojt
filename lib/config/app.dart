import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ojt_project/providers/providers.dart';
import 'package:ojt_project/screens/auth/login_screen.dart';
import 'package:ojt_project/screens/home_screen.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserStream = ref.watch(authUserStreamProvider);
    final authStateNotifier = ref.watch(authNotifierProvider.notifier);

    return MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: authUserStream.when(
          data: (user) {
            if (user != null) {
              useEffect(() {
                authStateNotifier.getUserFuture(authUserId: user.uid);
                return null;
              }, [user]);

              return HomeScreen(
                authUser: user,
              );
            } else {
              return const LoginScreen();
            }
          },
          error: (error, stack) => const Center(
            child: Text('Something is wrong, Retry again '),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ),
        ));
  }
}
