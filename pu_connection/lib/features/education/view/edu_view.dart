import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pu_connnection/constants/appwrite_constant.dart';
import 'package:pu_connnection/features/home/view/home_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/env.dart';
import '../../../models/user_models.dart';
import '../../auth/controller/auth_controller.dart';
import '../../setting_profile/view/setting_profile_view.dart';
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
      // Lấy giá trị của sessionStorage với key 'objUser'
      String objUserData = await controller.runJavaScriptReturningResult(
          "sessionStorage.getItem('objUser');") as String;

      // print("Session Storage objUser Data: $objUserData");

      String response = await controller.runJavaScriptReturningResult(
          'document.documentElement.innerHTML') as String;
      var authData = getDataHtml(response + objUserData);

      ref.read(authDataProvider.notifier).setAuth(authData);

      UserModel? currentUser = ref.watch(currentUserDetailsProvider).value;
      Client client = Client()
          .setEndpoint(AppwriteConstants.endPoint) // Your API Endpoint
          .setProject(AppwriteConstants.projectId); // Your project ID

      Databases databases = Databases(client);
      // Document result = await databases.updateDocument(
      //   databaseId: AppwriteConstants.databaseId,
      //   collectionId: AppwriteConstants.usersCollection,
      //   documentId: currentUser!.uid,
      //   data: currentUser.toMap(), // optional
      // );

      // print(result);

      var authDataModel = ref.read(authDataProvider);
      // Bạn có thể tiếp tục xử lý objUserData ở đây

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
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
