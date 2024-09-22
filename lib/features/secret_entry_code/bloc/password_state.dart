enum PasswordStatus {
  initial, // Начальное состояние
  success, // Успешное выполнение
  error, // Ошибка выполнения
  validation, // Пароль успешно подтвержден
  settingPassword,
  setPasswordSuccess,
  validationFailure, // Ошибка валидации пароля
}

class PasswordState {
  final PasswordStatus status;
  final String password;
  final bool isPasswordSet;

  PasswordState({
    this.status = PasswordStatus.initial,
    this.password = '',
    this.isPasswordSet = false,
  });

  List<Object> get props => [status, password, isPasswordSet];

  PasswordState copyWith({
    PasswordStatus? status,
    String? password,
    bool? isPasswordSet,
  }) {
    return PasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
      isPasswordSet: isPasswordSet ?? this.isPasswordSet,
    );
  }
}
