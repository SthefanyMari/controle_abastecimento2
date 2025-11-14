import 'package:flutter_riverpod/flutter_riverpod.dart';   
import 'package:firebase_auth/firebase_auth.dart';       
import '../../data/repositories/auth_repository.dart';  

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.read(authRepositoryProvider).authStateChanges,
);

class AuthController {
  final AuthRepository repo;
  AuthController(this.repo);

  Future<String?> login(String email, String password) async {
    try {
      await repo.signIn(email, password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      await repo.register(email, password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() => repo.signOut();
}

final authControllerProvider = Provider((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthController(repo);
});
