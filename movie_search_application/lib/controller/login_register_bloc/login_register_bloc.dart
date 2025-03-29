import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/firebase/firebase_data.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  LoginRegisterBloc() : super(LoginRegisterInitialState()) {
    on<OnLoginNavigateEvent>(onLoginNavigateEvent);
    on<OnRegisterNavigateEvent>(onRegisterNavigateEvent);
    on<OnLoginWithDataEvent>(onLoginWithDataEvent);
    on<OnRegisterWithDataEvent>(onRegisterWithDataEvent);

    on<OnShowPasswordEvent>(onShowPasswordEvent);
    on<OnDropdownSelectionEvent>(onDropdownSelectionEvent);
    on<OnRadioSelectionEvent>(onRadioSelectionEvent);
    on<OnCheckboxSelectionEvent>(onCheckboxSelectionEvent);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isPasswordVisible = true;
  String selectedDropdownValue = "";
  String selectedGender = "";
  bool isChecked = false;

  FutureOr<void> onLoginNavigateEvent(
    OnLoginNavigateEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    emit(LoginNavigateState());
  }

  FutureOr<void> onRegisterNavigateEvent(
    OnRegisterNavigateEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    emit(RegisterNavigateState());
  }

  FutureOr<void> onLoginWithDataEvent(
    OnLoginWithDataEvent event,
    Emitter<LoginRegisterState> emit,
  ) async {
    if (event.userCredential["email"].trim()! != "" &&
        event.userCredential["password"].trim() != "") {
      String res = await FirebaseData.loginUser(event.userCredential);
      if (res == "true") {
        emit(LoginWithDataState());
      } else {
        emit(LoginRegisterWithDataErrorState(error: res));
      }
    } else {
      emit(
        LoginRegisterWithDataErrorState(
          error: "Please Enter Valid Data : Email And Password",
        ),
      );
    }
  }

  FutureOr<void> onRegisterWithDataEvent(
    OnRegisterWithDataEvent event,
    Emitter<LoginRegisterState> emit,
  ) async {
    if (event.userCredential["email"].trim()! != "" &&
        event.userCredential["password"].trim() != "" &&
        event.userCredential["username"].trim() != "" &&
        event.userCredential["gender"].trim() != "") {
      String res = await FirebaseData.registerUser(event.userCredential);
      if (res == "true") {
        emit(LoginNavigateState());
      } else {
        emit(LoginRegisterWithDataErrorState(error: res));
      }
    } else {
      emit(LoginRegisterWithDataErrorState(error: "Please Fill all details"));
    }
  }

  FutureOr<void> onShowPasswordEvent(
    OnShowPasswordEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    isPasswordVisible = !isPasswordVisible;
    emit(ShowPasswordState(isVisible: isPasswordVisible));
  }

  FutureOr<void> onDropdownSelectionEvent(
    OnDropdownSelectionEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    selectedDropdownValue = event.selectedValue;
    emit(DropdownSelectionState(selectedValue: selectedDropdownValue));
  }

  FutureOr<void> onRadioSelectionEvent(
    OnRadioSelectionEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    selectedGender = event.selectedValue;
    emit(RadioSelectionState(selectedValue: selectedGender));
  }

  FutureOr<void> onCheckboxSelectionEvent(
    OnCheckboxSelectionEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    isChecked = event.isChecked;
    emit(CheckboxSelectionState(isChecked: isChecked));
  }
}
