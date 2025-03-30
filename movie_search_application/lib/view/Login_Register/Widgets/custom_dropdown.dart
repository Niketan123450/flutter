import 'package:flutter/material.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.bloc,
  });

  final String title;
  final List<String> items;
  final LoginRegisterBloc bloc;

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
        Container(
          height: 49,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(250, 250, 250, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: bloc.selectedDropdownValue,
              hint: Text(
                "Select ",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              isExpanded: true,
              onChanged: (String? newValue) {
                bloc.selectedDropdownValue = newValue!;
                bloc.add(OnDropdownSelectionEvent(selectedValue: newValue));
              },
              items:
                  items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
