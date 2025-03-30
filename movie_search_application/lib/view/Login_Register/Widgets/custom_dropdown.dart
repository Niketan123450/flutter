import 'package:flutter/material.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

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
        const SizedBox(height: 5),
        Container(
          height: 49,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(250, 250, 250, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ), // Optional border
          ),
          child: Row(
            children: [
              const Icon(
                Icons.language, // Language Icon
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value:
                        bloc.selectedDropdownValue.isNotEmpty
                            ? bloc.selectedDropdownValue
                            : null,
                    hint: Text(
                      "Language",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 16,
                        color: AppColors.secondBackground,
                      ),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        bloc.selectedDropdownValue = newValue;
                        bloc.add(
                          DropdownSelectionEvent(selectedValue: newValue),
                        );
                      }
                    },
                    items:
                        items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
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
          ),
        ),
      ],
    );
  }
}
