import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/env.dart';
import '../../../models/auth_model.dart';

class AuthDataProvider extends StateNotifier<AuthModel?> {
  AuthDataProvider() : super(null);

  void setAuth(AuthModel auth) {
    state = AuthModel(userId: auth.userId, accessToken: auth.accessToken);
  }

  AuthModel? getAuth() {
    return state;
  }
}

final authDataProvider =
    StateNotifierProvider<AuthDataProvider, AuthModel?>((ref) {
  return AuthDataProvider();
});

AuthModel getDataHtml(String html) {
  // Xử lý thông tin / KHÔNG ĐỘNG ĐẾN
  final regexUserId = RegExp(Config.USERID_REGEX);
  final regexTokenJWT = RegExp(Config.TOKENJWT_REGEX);
  final userId = regexUserId.firstMatch(html)?.group(1);
  final tokenJWT = regexTokenJWT.firstMatch(html)?.group(1);
  return AuthModel(userId: userId, accessToken: tokenJWT);
}
