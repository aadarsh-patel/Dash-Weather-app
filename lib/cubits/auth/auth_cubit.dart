import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> checkAuthentication() async {
    if (_auth.currentUser != null) {
      emit(AuthCompleted(_auth.currentUser!));
      return true;
    }
    return false;
  }

  Future<void> signUpUser(String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthCompleted(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthError('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthError('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logInUser(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthCompleted(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError('Wrong password provided for that user.'));
      } else {
        emit(AuthError(e.code));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logOutUser() async {
    await _auth.signOut();
    emit(AuthInitial());
  }
}
