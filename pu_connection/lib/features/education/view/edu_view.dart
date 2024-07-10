import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/env.dart';
import '../../widgets/dialogCustom.dart';
import '../controller/auth_provider.dart';
import 'calender_view.dart';

class LoginWithMicrosoft_View extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginWithMicrosoft_View(),
      );

  const LoginWithMicrosoft_View({super.key});

  @override
  ConsumerState<LoginWithMicrosoft_View> createState() =>
      _LoginWithMicrosoft_ViewState();
}

class _LoginWithMicrosoft_ViewState
    extends ConsumerState<LoginWithMicrosoft_View> {
  late final WebViewController controller;

  String urlStarted = Config.API_URL + Config.LOGIN_EDUCAION;
  String urlFinished = Config.API_URL + Config.HOME_EDUCAION;

  void _handlePageFinished(String url) async {
    if (url == urlFinished) {
      String response = await controller.runJavaScriptReturningResult(
          'document.documentElement.innerHTML') as String;
      var authData = getDataHtml(response);

      ref.read(authDataProvider.notifier).setAuth(authData);
      var authDataModel = ref.read(authDataProvider);

      try {
        if (authDataModel?.accessToken != "") {
          if (authDataModel?.accessToken?[0] != "e") {
            // handle other cases if needed
          } else {
            if (authData.accessToken != "") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalenderView()),
              );
            } else {
              ShowCustomDialog("Error", "Đã xảy ra lỗi đăng nhập", context);
            }
          }
        }
      } catch (e) {
        ShowCustomDialog('Error', 'Error loading web page: $e', context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (url) {},
          onPageFinished: _handlePageFinished,
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(urlStarted)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(urlStarted));

    controller.clearCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Education"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue, Colors.red],
            ),
          ),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
