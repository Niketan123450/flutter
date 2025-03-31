import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/core/services/firebase_data.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  LoginRegisterBloc() : super(LoginRegisterInitialState()) {
    on<LoginNavigateEvent>(loginNavigateEvent);
    on<RegisterNavigateEvent>(registerNavigateEvent);
    on<LoginWithDataEvent>(loginWithDataEvent);
    on<RegisterWithDataEvent>(registerWithDataEvent);

    on<ShowPasswordEvent>(showPasswordEvent);
    on<DropdownSelectionEvent>(dropdownSelectionEvent);

    on<CheckboxSelectionEvent>(checkboxSelectionEvent);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isPasswordVisible = true;
  String selectedDropdownValue = "";

  bool isChecked = false;

  FutureOr<void> loginNavigateEvent(
    LoginNavigateEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    emit(LoginNavigateState());
  }

  FutureOr<void> registerNavigateEvent(
    RegisterNavigateEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    emit(RegisterNavigateState());
  }

  FutureOr<void> loginWithDataEvent(
    LoginWithDataEvent event,
    Emitter<LoginRegisterState> emit,
  ) async {
    if (event.userCredential["email"].trim()! != "" &&
        event.userCredential["password"].trim() != "") {
      String res = await FirebaseData.loginUser(event.userCredential);
      if (res == "true") {
        emit(
          LoginRegisterWithDataSuccessState(successMessage: "Login Successful"),
        );
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

  FutureOr<void> registerWithDataEvent(
    RegisterWithDataEvent event,
    Emitter<LoginRegisterState> emit,
  ) async {
    if (event.userCredential["email"].trim()! != "" &&
        event.userCredential["password"].trim() != "" &&
        event.userCredential["username"].trim() != "") {
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

  FutureOr<void> showPasswordEvent(
    ShowPasswordEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    isPasswordVisible = !isPasswordVisible;
    emit(ShowPasswordState(isVisible: isPasswordVisible));
  }

  FutureOr<void> dropdownSelectionEvent(
    DropdownSelectionEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    selectedDropdownValue = event.selectedValue;
    emit(DropdownSelectionState(selectedValue: selectedDropdownValue));
  }

  FutureOr<void> checkboxSelectionEvent(
    CheckboxSelectionEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    isChecked = event.isChecked;
    emit(CheckboxSelectionState(isChecked: isChecked));
  }
}
