import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/common/common.dart';
import 'package:phenikaa_campus/constants/assets_constants.dart';
import 'package:phenikaa_campus/constants/ui_constant.dart';
import 'package:phenikaa_campus/features/auth/view/signup_view.dart';
import 'package:phenikaa_campus/features/auth/widgets/auth_field.dart';
import 'package:phenikaa_campus/theme/theme.dart';

import '../controller/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Map<int, Widget> _children = {
    0: const Text('Login'),
    1: const Text('Sign Up'),
  };
  final int _currentSelection = 0;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() async {
    await ref.read(authControllerProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
        // appBar: appbar,
        body: isLoading
            ? const Loader()
            : SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(AssetsConstants.darkBlur),
                      ),
                      Positioned.fill(
                        top: size.height * 0.068,
                        child: const Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Text(
                                'Hello,',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800, // Để in đậm
                                  fontSize: 40, // Điều chỉnh kích thước chữ
                                ),
                              ),
                              Text(
                                'Welcome Back!\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800, // Để in đậm
                                  fontSize: 32, // Điều chỉnh kích thước chữ
                                ),
                              ),
                              Text(
                                'Please enter your email and password ',
                                style: TextStyle(
                                  // Để in đậm
                                  fontSize: 12, // Điều chỉnh kích thước chữ
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.3,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              // horizontal: 10.0,
                              ),
                          width: size.width,
                          height: size.height * 0.8,
                          decoration: BoxDecoration(
                            color: Pallete.rhinoDark800,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.1,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              // horizontal: 10.0,
                              ),
                          width: size.width,
                          height: size.height * 0.8,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    AuthField(
                                      prefixIcon: Icons.email_outlined,
                                      prefixIconColor: Pallete.whiteColor,
                                      controller: emailController,
                                      hintText: 'Email Adress',
                                    ),
                                    const SizedBox(height: 25),
                                    AuthField(
                                      obscureText: true,
                                      prefixIcon: Icons.lock_outlined,
                                      controller: passwordController,
                                      hintText: 'Password',
                                    ),
                                    const SizedBox(height: 40),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: RoundedSmallButton(
                                        backgroundColor: Pallete.rhinoDark600,
                                        onTap: onLogin,
                                        text: 'Sign In',
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    const SizedBox(height: 40),
                                    RichText(
                                      text: TextSpan(
                                        text: "Don't have an account?",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' Sign up',
                                            style: const TextStyle(
                                              color: Pallete.blueColor,
                                              fontSize: 16,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  SignUpView.route(),
                                                );
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
