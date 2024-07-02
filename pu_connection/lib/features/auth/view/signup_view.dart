import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/loading_page.dart';
import '../../../common/rounded_small_button.dart';
import '../../../constants/assets_constants.dart';
import '../../../theme/pallete.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';
import 'login_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  String profilePicController = "";

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    profilePicController = "";
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          name: usernameController.text,
          profilePic: profilePicController,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? Loader()
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
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              'WELCOME TO',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 32,
                              ),
                            ),
                            Text(
                              'PKAUNI CONNECTION!\n',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              'Please enter your email and password ',
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.3,
                      child: Container(
                        margin: EdgeInsets.symmetric(
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
                        margin: EdgeInsets.symmetric(
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
                                    prefixIcon: Icons.person_outline,
                                    prefixIconColor: Pallete.whiteColor,
                                    controller: usernameController,
                                    hintText: 'User Name',
                                  ),
                                  const SizedBox(height: 25),
                                  AuthField(
                                    prefixIcon: Icons.email_outlined,
                                    prefixIconColor: Pallete.whiteColor,
                                    controller: emailController,
                                    hintText: 'Email Address',
                                  ),
                                  const SizedBox(height: 25),
                                  AuthField(
                                    obscureText: true,
                                    prefixIcon: Icons.lock_outlined,
                                    controller: passwordController,
                                    hintText: 'Password',
                                  ),
                                  const SizedBox(height: 25),
                                  AuthField(
                                    obscureText: true,
                                    prefixIcon: Icons.image_outlined,
                                    controller: usernameController,
                                    hintText: 'Profile Picture',
                                  ),
                                  const SizedBox(height: 40),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: RoundedSmallButton(
                                      backgroundColor:
                                          Color.fromARGB(255, 194, 165, 0),
                                      onTap: onSignUp,
                                      text: 'Sign Up',
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  RichText(
                                    text: TextSpan(
                                      text: "Already have an account?",
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' Log In',
                                          style: const TextStyle(
                                            color: Pallete.blueColor,
                                            fontSize: 16,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                LoginView.route(),
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
            ),
    );
  }
}
