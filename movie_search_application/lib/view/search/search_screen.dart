import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/controller/search_bloc/search_bloc.dart';
import 'package:movie_search_application/controller/search_bloc/search_event.dart';
import 'package:movie_search_application/controller/search_bloc/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _movieBloc = SearchBloc();
    _movieBloc.add(LoadMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Field
            TextField(
              onChanged: (query) {
                _movieBloc.add(SearchMoviesEvent(query));
              },
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Movie List
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                bloc: _movieBloc,
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoadedState) {
                    final movies = state.movieList;
                    if (movies.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    }
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Image.network(
                              movie.posterUrl!,
                              width: 50,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: Text(movie.title!),
                            subtitle: Text(movie.genre!),
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
    );
  }
}
