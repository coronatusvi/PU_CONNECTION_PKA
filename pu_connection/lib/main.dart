import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'apis/firebase_messaging_service.dart';
import 'common/error_page.dart';
import 'common/loading_page.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/auth/view/login_view.dart';
import 'features/home/view/home_view.dart';
import 'theme/app_theme.dart';
import 'theme/pallete.dart';
import 'theme/theme_controller.dart';
import 'theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingService().initialize();
  runApp(MyApp());
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
              },
            ),
      ),
    );
  }
}
