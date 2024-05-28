import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/common/common.dart';
import 'package:phenikaa_campus/features/auth/controller/auth_controller.dart';
import 'package:phenikaa_campus/features/auth/view/login_view.dart';
import 'package:phenikaa_campus/features/home/view/home_view.dart';
import 'package:phenikaa_campus/theme/theme.dart';
import 'package:phenikaa_campus/theme/theme_controller.dart';
import 'package:phenikaa_campus/theme/theme_provider.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final ThemeManager _themeManager = ThemeManager();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeProvider(
      manager: _themeManager,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Phenikaa Campus',
          theme: AppTheme.theme,
          home: ref.watch(currentUserAccountProvider).when(
              data: (user) {
                return user != null ? HomeView() : LoginView();
              },
              loading: () => const LoadingPage(
                    backgroundColor: Pallete.rhinoDark500,
                  ),
              error: (error, s) {
                return ErrorText(
                  error: error.toString(),
                );
              })),
    );
  }
}
