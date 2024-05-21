import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/common/common.dart';
import 'package:phenikaa_campus/constants/constants.dart';
import 'package:phenikaa_campus/features/auth/controller/auth_controller.dart';
import 'package:phenikaa_campus/features/auth/view/login_view.dart';
import 'package:phenikaa_campus/features/auth/widgets/auth_field.dart';
import 'package:phenikaa_campus/theme/theme.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                //TextField username
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 25,
                ),
                //TextField password
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 40,
                ),
                //Button done
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    label: 'Done',
                    onTap: onSignUp,
                    textColor: Pallete.backgroundColor,
                    backgroundColor: Pallete.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(fontSize: 16),
                      children: [
                        TextSpan(
                            text: ' Log in',
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
                              })
                      ]),
                )
              ]),
            ),
          ),
        ));
  }
}
