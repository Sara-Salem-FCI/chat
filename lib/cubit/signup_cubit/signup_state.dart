
abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignupSuccess extends SignupState{}
class SignupLoading extends SignupState{}
class SignupFailed extends SignupState{
  final String errorMessage;
  SignupFailed({required this.errorMessage});
}
