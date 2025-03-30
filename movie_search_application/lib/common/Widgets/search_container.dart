import 'package:flutter/material.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

class SearchContainer extends StatefulWidget {
  const SearchContainer({super.key});

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width * 0.02,
            ),
            border: Border.all(color: AppColors.primary),
            // color: Colors.amber,
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Icon(Icons.search, color: AppColors.primary),
              ),
              SizedBox(width: 12),
              Text("Search movie", style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ),
        Spacer(),
        Icon(Icons.notifications_sharp, color: AppColors.primary),
      ],
    );
  }
}
