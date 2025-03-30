abstract class LoginRegisterEvent {}

class LoginNavigateEvent extends LoginRegisterEvent {}

class RegisterNavigateEvent extends LoginRegisterEvent {}

class LoginWithDataEvent extends LoginRegisterEvent {
  final Map<String, dynamic> userCredential;
  LoginWithDataEvent({required this.userCredential});
}

class RegisterWithDataEvent extends LoginRegisterEvent {
  final Map<String, dynamic> userCredential;
  RegisterWithDataEvent({required this.userCredential});
}

class ShowPasswordEvent extends LoginRegisterEvent {}

class DropdownSelectionEvent extends LoginRegisterEvent {
  final String selectedValue;
  DropdownSelectionEvent({required this.selectedValue});
}

class CheckboxSelectionEvent extends LoginRegisterEvent {
  final bool isChecked;
  CheckboxSelectionEvent({required this.isChecked});
}
