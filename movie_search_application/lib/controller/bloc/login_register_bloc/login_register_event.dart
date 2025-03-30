abstract class LoginRegisterEvent {}

class OnLoginNavigateEvent extends LoginRegisterEvent {}

class OnRegisterNavigateEvent extends LoginRegisterEvent {}

class OnLoginWithDataEvent extends LoginRegisterEvent {
  final Map<String, dynamic> userCredential;
  OnLoginWithDataEvent({required this.userCredential});
}

class OnRegisterWithDataEvent extends LoginRegisterEvent {
  final Map<String, dynamic> userCredential;
  OnRegisterWithDataEvent({required this.userCredential});
}

class OnShowPasswordEvent extends LoginRegisterEvent {}

class OnDropdownSelectionEvent extends LoginRegisterEvent {
  final String selectedValue;
  OnDropdownSelectionEvent({required this.selectedValue});
}

class OnRadioSelectionEvent extends LoginRegisterEvent {
  final String selectedValue;
  OnRadioSelectionEvent({required this.selectedValue});
}

class OnCheckboxSelectionEvent extends LoginRegisterEvent {
  final bool isChecked;
  OnCheckboxSelectionEvent({required this.isChecked});
}
