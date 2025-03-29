import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:movie_search_application/controller/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/login_register_bloc/login_register_event.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final LoginRegisterBloc bloc;

  const CustomRadioButton({super.key, required this.title, required this.bloc});

  // Default selection
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Radio<String>(
              value: "Male",
              groupValue: bloc.selectedGender,
              activeColor: const Color.fromRGBO(74, 138, 196, 1),
              onChanged: (value) {
                bloc.selectedGender = value!;
                bloc.add(OnRadioSelectionEvent(selectedValue: value));
                log(bloc.selectedGender);
              },
            ),
            Text(
              "Male",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 20),
            Radio<String>(
              value: "Female",
              groupValue: bloc.selectedGender,
              activeColor: const Color.fromRGBO(74, 138, 196, 1),
              onChanged: (value) {
                bloc.selectedGender = value!;
                bloc.add(OnRadioSelectionEvent(selectedValue: value));
                log(bloc.selectedGender);
              },
            ),
            Text(
              "Female",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
