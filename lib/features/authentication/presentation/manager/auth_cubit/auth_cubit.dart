import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginEmailPassword({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        emit(LoginFailure(errMassage: 'Invalid email or password'));
      } else {
        emit(LoginFailure(errMassage: e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(LoginFailure(errMassage: 'Something went wrong'));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(LoginFailure(errMassage: "Sign-in was cancelled"));
        return; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(errMassage: e.message ?? 'An error occurred during Google sign-in'));
    } catch (e) {
      emit(LoginFailure(errMassage: 'An unexpected error occurred'));
    }
  }

  Future<void> registerEmailPassword({required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMassage: 'Weak Password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errMassage: 'Email already Exists'));
      } else {
        emit(RegisterFailure(errMassage: e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(RegisterFailure(errMassage: 'Something went wrong'));
    }
  }

  Future<void> getUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        emit(GetUserEmailSuccess(user: user));
      } else {
        emit(GetUserEmailFailure(errMassage: 'User not logged in'));
      }
    } catch (e) {
      emit(GetUserEmailFailure(errMassage: e.toString()));
    }
  }

  void changePasswordState({required bool isSeen}) {
    if (isSeen) {
      emit(passwordIsHidden());
    } else {
      emit(passwordIsSeen());
    }
  }

  Future<void> resetPasswordWithEmail({required String email}) async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetEmailSuccess());
    } on FirebaseException catch (e) {
      emit(ResetEmailFailure(errMassage: e.message!));
    }catch (e){
      emit(ResetEmailFailure(errMassage: e.toString()));
    }
  }
}
