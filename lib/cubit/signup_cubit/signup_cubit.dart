import 'package:chat/cubit/signup_cubit/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  Future<void> registerUser({required email, required password}) async {
    emit(SignupLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailed(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailed(errorMessage: 'The account already exists for that email.'));
      } else {
        emit(SignupFailed(errorMessage: 'Enter valid data.'));
      }
    }
    on Exception catch (e) {
      emit(SignupFailed(errorMessage: 'something went wrong'));
    }
  }
}
