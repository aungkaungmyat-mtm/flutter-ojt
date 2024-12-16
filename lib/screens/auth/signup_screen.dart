import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ojt_project/assets/assets.gen.dart';
import 'package:ojt_project/providers/providers.dart';
import 'package:ojt_project/repositories/user_repo.dart';
import 'package:ojt_project/screens/auth/login_screen.dart';
import 'package:ojt_project/screens/home_screen.dart';
import 'package:ojt_project/widgets/loading_overlay.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscureText = useState(true);
    final userRepository = ref.watch(userRepositoryProvider);

    return LoadingOverlay(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter your name',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'example@gmail.com',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            // Regular expression for basic email validation
                            const String emailPattern =
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                            final RegExp regex = RegExp(emailPattern);

                            if (!regex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscureText.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '********',
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  obscureText.value = !obscureText.value,
                              icon: Icon(
                                obscureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              try {
                                await userRepository.registerUser(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                                scaffoldMessengerKey.currentState!.showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("User Successfully Registered"),
                                  ),
                                );
                                if (!context.mounted) return;
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              } on FirebaseAuthException catch (e) {
                                String errorMessage =
                                    'An error occurred, please try again';
                                if (e.code == 'weak-password') {
                                  errorMessage = 'The password is too weak';
                                } else if (e.code == 'email-already-in-use') {
                                  errorMessage =
                                      'The email is already registered';
                                }

                                scaffoldMessengerKey.currentState!.showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage),
                                  ),
                                );
                              }
                            },
                            child: const Text('Sign Up')),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(color: Colors.blue),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: const TextStyle(color: Colors.redAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Or'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  try {
                                    await userRepository.googleSignIn();

                                    scaffoldMessengerKey.currentState!
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "User Successfully Registered"),
                                      ),
                                    );
                                    if (!context.mounted) return;

                                    final user =
                                        FirebaseAuth.instance.currentUser;

                                    if (user != null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                            authUser: user,
                                          ),
                                        ),
                                      );
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    String errorMessage =
                                        'Sign up failed, please try again';
                                    if (e.code == 'weak-password') {
                                      errorMessage = 'The password is too weak';
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      errorMessage =
                                          'The email is already registered';
                                    }

                                    scaffoldMessengerKey.currentState!
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(errorMessage),
                                      ),
                                    );
                                  }
                                },
                                label: const Text('Sign up with Google'),
                                icon: SvgPicture.asset(
                                  Assets.icons.googleLogoIcon,
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(5),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
