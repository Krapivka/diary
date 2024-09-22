import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class SetSecretCodeEvent extends PasswordEvent {
  @override
  List<Object> get props => [];
}

class SetPasswordEvent extends PasswordEvent {
  final String password;

  const SetPasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}

class RemovePasswordEvent extends PasswordEvent {
  const RemovePasswordEvent();

  @override
  List<Object> get props => [];
}

class ValidatePasswordEvent extends PasswordEvent {
  final String password;

  const ValidatePasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}

class CheckExistingPasswordEvent extends PasswordEvent {}
