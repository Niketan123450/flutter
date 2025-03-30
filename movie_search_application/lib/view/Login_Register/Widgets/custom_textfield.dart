import 'package:flutter/material.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.title,
    required this.textcontroller,
    required this.bloc,
  });
  final String title;
  final LoginRegisterBloc bloc;
  final TextEditingController textcontroller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 246, 247, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: textcontroller,
            obscureText: title != "Password" ? false : bloc.isPasswordVisible,
            cursorColor: const Color.fromRGBO(184, 184, 184, 1),
            decoration: InputDecoration(
              hintText: " ${title.toLowerCase()}",
              hintStyle: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              suffixIcon:
                  title != "Password"
                      ? const SizedBox()
                      : GestureDetector(
                        onTap: () {
                          bloc.add(OnShowPasswordEvent());
                        },
                        child: Icon(
                          bloc.isPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }
}
