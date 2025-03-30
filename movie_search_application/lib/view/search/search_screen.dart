import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/controller/bloc/search_bloc/search_bloc.dart';
import 'package:movie_search_application/controller/bloc/search_bloc/search_event.dart';
import 'package:movie_search_application/controller/bloc/search_bloc/search_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/view/details/details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc movieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = SearchBloc();
    movieBloc.add(LoadMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (query) {
                  movieBloc.add(SearchMoviesEvent(query));
                },
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: AppColors.primary,
                    ),
                    onPressed: () {},
                  ),
                  filled: true,
                  fillColor: Colors.black,

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Movie List
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  bloc: movieBloc,
                  builder: (context, state) {
                    if (state is SearchLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchLoadedState) {
                      final movies = state.movieList;
                      if (movies.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 80,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No Results Found",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Try searching for something else.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return GestureDetector(
                            onTap: () {
                              AppNavigator.pushReplacement(
                                context,
                                DetailsScreen(movieModel: movie),
                              );
                            },
                            child: Card(
                              color: AppColors.secondBackground,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                textColor: AppColors.primary,

                                leading: Image.network(
                                  movie.posterUrl!,
                                  width: 50,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(movie.title!),
                                subtitle: Text(movie.genre!),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is SearchErrorState) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('Search for movies!'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
