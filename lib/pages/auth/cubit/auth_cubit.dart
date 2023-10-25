import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../models/auth/user_models.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitial());

  // check current Authentikasi status
  void checkStatusAuth() {
    if (_auth.currentUser != null) {
      emit(AuthAuthenticated(UserModels(_auth.currentUser!.uid)));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // User user = credential.user!;
      emit(AuthAuthenticated(UserModels(credential.user!.uid)));
      return true;
    } catch (e) {
      emit(AuthError(e.toString()));
      return false;
    }
  }

  // LoginwithEmailandPassword
  Future<bool> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      emit(AuthAuthenticated(UserModels(credential.user!.uid)));

      return true;
    } catch (e) {
      emit(AuthError(e.toString()));
      return false;
    }
  }
}
