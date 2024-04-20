part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginFailure extends AuthState {
 final String errMassage;

  LoginFailure({required this.errMassage});
}
class LoginLoading extends AuthState {}
class passwordIsSeen extends AuthState {}
class passwordIsHidden extends AuthState {}


class RegisterLoading extends AuthState {}
class RegisterFailure extends AuthState {
 final String errMassage;

  RegisterFailure({required this.errMassage});
}
class RegisterSuccess extends AuthState {}
class GetUserEmailSuccess extends AuthState {
 final User user;

  GetUserEmailSuccess({required this.user});
}
class GetUserEmailFailure extends AuthState {
 final String errMassage;

  GetUserEmailFailure({required this.errMassage});
}




