import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/controller/home_bloc/home_bloc.dart';
import 'package:movie_search_application/controller/home_bloc/home_event.dart';
import 'package:movie_search_application/controller/home_bloc/home_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

import 'package:movie_search_application/view/details/pages/details_screen.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeBloc()..add(HomeInitialEvent()), // Correct Bloc creation
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<HomeBloc, HomeState>(
          builder: (BuildContext context, state) {
            if (state is HomeLoadingState) {
              return CircularProgressIndicator();
            } else if (state is HomeSuccessState) {
              return GridView.builder(
                // scrollDirection: Axis.horizontal, // Horizontal scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Only 1 row for horizontal scrolling
                  // mainAxisExtent: 150, // Set width of each container
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.47,
                  mainAxisSpacing: 10, // Add spacing between containers
                ),
                itemCount: state.movieList.length, // Number of items to display
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AppNavigator.push(
                        context,
                        DetailsScreen(movieModel: state.movieList[index]),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        // width: 150, // Reduced width to fit 3 containers
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height *
                                  0.2, // Set fixed height for image
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKI5TAOsqD7FtzJjsuO-eH0OxinunQMrWjug&s",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: AppColors.primary),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.movieList[index].title!,
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Action, Crime, Thriller",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is HomeFailureState) {
              return Center(child: Container());
            } else {
              return SizedBox.shrink();
            }
          },
          listener: (BuildContext context, HomeState state) {},
        ),
      ),
    );
  }
}
