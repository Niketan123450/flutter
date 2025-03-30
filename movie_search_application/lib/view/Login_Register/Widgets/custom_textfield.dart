import 'package:flutter/material.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_bloc.dart';
import 'package:movie_search_application/controller/bloc/login_register_bloc/login_register_event.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

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
              hintText:
                  title == "Email"
                      ? " ${title.toLowerCase()}/phone"
                      : " ${title.toLowerCase()}",
              hintStyle: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.secondBackground,
              ),
              prefixIcon:
                  title == "Name"
                      ? Icon(Icons.person, color: Colors.grey)
                      : title == "Password"
                      ? const Icon(Icons.lock, color: Colors.grey)
                      : Icon(Icons.email, color: Colors.grey),
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
