import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phenikaa_campus/common/rounded_small_button.dart';

import 'package:phenikaa_campus/constants/ui_constant.dart';
import 'package:phenikaa_campus/features/auth/view/signup_view.dart';
import 'package:phenikaa_campus/features/auth/widgets/auth_field.dart';
import 'package:phenikaa_campus/theme/theme.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    onTap: () {},
                    textColor: Pallete.backgroundColor,
                    backgroundColor: Pallete.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(fontSize: 16),
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
                              })
                      ]),
                )
              ]),
            ),
          ),
        ));
  }
}
