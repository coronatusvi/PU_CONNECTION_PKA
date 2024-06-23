import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';

// to signup, to get user account -> Account
// to access user related data -> User

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  FutureEither<User> signUp({
    required String email,
    required String password,
  });
  FutureEither<Session> login({
    required String email,
    required String password,
  });
  Future<User?> currentUserAccount();
  FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  Future<User?> currentUserAccount() async {
    try {
      final user = await _account.get();
      print("User Account Success ==> ${user.toMap()}");
      return user;
    } on AppwriteException catch (e, st) {
      print("User Account Error ==> ${e.message}, StackTrace: $st");
      return null;
    } catch (e) {
      print("User Account Unknown Error ==> $e");
      return null;
    }
  }

  @override
  FutureEither<User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      print("Sign Up Success ==> ${account.toMap()}");
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      print("Sign Up Error ==> ${e.message}, StackTrace: $stackTrace");
      return left(
          Failure(e.message ?? 'Some unexpected error occurred', stackTrace));
    } catch (e, stackTrace) {
      print("Sign Up Unknown Error ==> $e, StackTrace: $stackTrace");
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<Session> login({
    required String email,
    required String password,
  }) async {
    try {
      var session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      try {
        final user = await _account.get();
        print("Login Success - User ==> ${user.toMap()}");
      } catch (err) {
        print("Login Error - Not logged in ==> $err");
      }
      print("Login Session Success ==> ${session.toMap()}");
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      print("Login Error ==> ${e.message}, StackTrace: $stackTrace");
      return left(
          Failure(e.message ?? 'Some unexpected error occurred', stackTrace));
    } catch (e, stackTrace) {
      print("Login Unknown Error ==> $e, StackTrace: $stackTrace");
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      print("Logout ...");
      final sessions = await _account.listSessions();

      for (final session in sessions.sessions) {
        if (session.current) {
          await _account.deleteSession(sessionId: session.$id);
          print("Logged out Session ==> ${session.$id}");
          return right(null);
        }
      }

      print("Logout Error ==> Current session not found");
      return left(Failure('Current session not found', StackTrace.current));
    } on AppwriteException catch (e, stackTrace) {
      print("Logout Error ==> ${e.message}, StackTrace: $stackTrace");
      return left(
          Failure(e.message ?? 'Some unexpected error occurred', stackTrace));
    } catch (e, stackTrace) {
      print("Logout Unknown Error ==> $e, StackTrace: $stackTrace");
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
