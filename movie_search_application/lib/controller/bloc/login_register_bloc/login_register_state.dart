abstract class LoginRegisterState {}

class LoginRegisterInitialState extends LoginRegisterState {}

class LoginRegisterActionState extends LoginRegisterState {}

class LoginNavigateState extends LoginRegisterActionState {}

class RegisterNavigateState extends LoginRegisterActionState {}

class LoginWithDataState extends LoginRegisterActionState {}

class LoginRegisterWithDataErrorState extends LoginRegisterActionState {
  final String error;
  LoginRegisterWithDataErrorState({required this.error});
}

class LoginRegisterWithDataSuccessState extends LoginRegisterActionState {
  final String successMessage;
  LoginRegisterWithDataSuccessState({required this.successMessage});
}

class ShowPasswordState extends LoginRegisterState {
  final bool isVisible;
  ShowPasswordState({required this.isVisible});
}

class DropdownSelectionState extends LoginRegisterState {
  final String selectedValue;
  DropdownSelectionState({required this.selectedValue});
}

class CheckboxSelectionState extends LoginRegisterState {
  final bool isChecked;
  CheckboxSelectionState({required this.isChecked});
}
