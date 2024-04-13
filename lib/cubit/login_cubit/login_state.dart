abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginSuccess extends LoginState{}
class LoginLoading extends LoginState{}
class LoginFailed extends LoginState{
  final String errorMessage;
  LoginFailed({required this.errorMessage});
}