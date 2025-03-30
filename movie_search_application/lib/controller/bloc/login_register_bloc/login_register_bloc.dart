import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_state.dart';
import 'package:movie_search_application/controller/firebase/firebase_data.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  LoginRegisterBloc() : super(LoginRegisterInitialState()) {
    on<LoginNavigateEvent>(onLoginNavigateEvent);
    on<RegisterNavigateEvent>(onRegisterNavigateEvent);
    on<LoginWithDataEvent>(onLoginWithDataEvent);
    on<RegisterWithDataEvent>(onRegisterWithDataEvent);

    on<ShowPasswordEvent>(onShowPasswordEvent);
    on<DropdownSelectionEvent>(onDropdownSelectionEvent);

    on<CheckboxSelectionEvent>(onCheckboxSelectionEvent);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool isPasswordVisible = true;
  String selectedDropdownValue = "";

  bool isChecked = false;

  FutureOr<void> onLoginNavigateEvent(
    LoginNavigateEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    emit(LoginNavigateState());
  }

  FutureOr<void> onRegisterNavigateEvent(
    RegisterNavigateEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    emit(RegisterNavigateState());
  }

  FutureOr<void> onLoginWithDataEvent(
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

  FutureOr<void> onRegisterWithDataEvent(
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

  FutureOr<void> onShowPasswordEvent(
    ShowPasswordEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    isPasswordVisible = !isPasswordVisible;
    emit(ShowPasswordState(isVisible: isPasswordVisible));
  }

  FutureOr<void> onDropdownSelectionEvent(
    DropdownSelectionEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    selectedDropdownValue = event.selectedValue;
    emit(DropdownSelectionState(selectedValue: selectedDropdownValue));
  }

  FutureOr<void> onCheckboxSelectionEvent(
    CheckboxSelectionEvent event,
    Emitter<LoginRegisterState> emit,
  ) {
    isChecked = event.isChecked;
    emit(CheckboxSelectionState(isChecked: isChecked));
  }
}
