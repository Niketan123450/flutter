import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/controller/bloc/home_bloc/home_bloc.dart';
import 'package:movie_search_application/controller/bloc/home_bloc/home_event.dart';
import 'package:movie_search_application/controller/bloc/home_bloc/home_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/core/configs/theme/app_text.dart';

import 'package:movie_search_application/view/details/details_screen.dart';
import 'package:movie_search_application/view/search/search_screen.dart';

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
              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      color: Colors.black,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              AppNavigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          Text("All Movies", style: AppText.appBarTitle),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              AppNavigator.push(context, SearchScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  border: Border.all(color: AppColors.primary),
                                  // color: Colors.amber,
                                ),
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Search movie",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal, // Horizontal scrolling
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        3, // Only 1 row for horizontal scrolling
                                    // mainAxisExtent: 150, // Set width of each container
                                    crossAxisSpacing: 0.1,
                                    childAspectRatio: 0.50,
                                    mainAxisSpacing:
                                        0, // Add spacing between containers
                                  ),
                              itemCount:
                                  state
                                      .movieList
                                      .length, // Number of items to display
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    AppNavigator.push(
                                      context,
                                      DetailsScreen(
                                        movieModel: state.movieList[index],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 6,
                                    ),
                                    child: Container(
                                      // width: 150, // Reduced width to fit 3 containers
                                      decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.2, // Set fixed height for image
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  state
                                                      .movieList[index]
                                                      .posterUrl!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: AppColors.primary,
                                              ),
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
                                          Text(
                                            state.movieList[index].genre!,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
