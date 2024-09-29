import 'package:bloc/bloc.dart';
import 'package:diary/features/secret_entry_code/data/repositories/secret_code_repository.dart';
import 'password_event.dart';
import 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final AbstractSecretCodeRepository _secretCodeRepository;

  PasswordBloc(this._secretCodeRepository) : super(PasswordState()) {
    on<SetPasswordEvent>(_onSetPassword);
    on<SetSecretCodeEvent>(_onSetSecretCode);
    on<RemovePasswordEvent>(_onRemovePassword);
    on<ValidatePasswordEvent>(_onValidatePassword);
    on<CheckExistingPasswordEvent>(_onCheckExistingPassword);
  }

  Future<void> _onSetSecretCode(
      SetSecretCodeEvent event, Emitter<PasswordState> emit) async {
    emit(state.copyWith(
      status: PasswordStatus.settingPassword,
    ));
  }

  Future<void> _onSetPassword(
      SetPasswordEvent event, Emitter<PasswordState> emit) async {
    final secretCode =
        await _secretCodeRepository.setSecretCode(event.password);
    secretCode
        .fold((failure) => emit(state.copyWith(status: PasswordStatus.error)),
            (value) {
      emit(state.copyWith(
        status: PasswordStatus.success,
        isPasswordSet: true,
      ));
    });
  }

  Future<void> _onRemovePassword(
      RemovePasswordEvent event, Emitter<PasswordState> emit) async {
    final removeCode = await _secretCodeRepository.removeSecretCode();
    removeCode.fold(
      (failure) => emit(state.copyWith(status: PasswordStatus.error)),
      (value) => emit(state.copyWith(
        status: PasswordStatus.success,
        isPasswordSet: false,
      )),
    );
  }

  Future<void> _onValidatePassword(
      ValidatePasswordEvent event, Emitter<PasswordState> emit) async {
    final validatePassword =
        await _secretCodeRepository.validateSecretCode(event.password);
    validatePassword
        .fold((failure) => emit(state.copyWith(status: PasswordStatus.error)),
            (value) {
      if (value) {
        emit(state.copyWith(status: PasswordStatus.success));
      } else {
        emit(state.copyWith(status: PasswordStatus.validationFailure));
        emit(state.copyWith(status: PasswordStatus.validation));
      }
    });
  }

  Future<void> _onCheckExistingPassword(
      CheckExistingPasswordEvent event, Emitter<PasswordState> emit) async {
    final existingPassword = await _secretCodeRepository.getSecretCode();
    existingPassword.fold(
      (failure) => emit(state.copyWith(status: PasswordStatus.error)),
      (value) {
        if (value != null && value.isNotEmpty) {
          emit(state.copyWith(
            isPasswordSet: true,
            status: PasswordStatus.validation,
          ));
        } else {
          emit(state.copyWith(
            isPasswordSet: false,
            status: PasswordStatus.success,
          ));
        }
      },
    );
  }
}
