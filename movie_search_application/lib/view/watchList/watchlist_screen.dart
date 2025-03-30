import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/controller/watchlist_bloc/watchlist_bloc.dart';
import 'package:movie_search_application/controller/watchlist_bloc/watchlist_event.dart';
import 'package:movie_search_application/controller/watchlist_bloc/watchlist_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchListBloc()..add(WatchListInitialEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              AppNavigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.primary),
          ),
          title: Text(
            "WatchList",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: BlocConsumer<WatchListBloc, WatchListState>(
          builder: (BuildContext context, state) {
            if (state is WatchListLoadingState) {
              return CircularProgressIndicator();
            } else if (state is WatchListSuccessState) {
              return ListView.builder(
                itemCount: state.watchListList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            state.watchListList[index].posterUrl!,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.04,
                        ),
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                  );
                },
              );
            } else if (state is WatchListFailureState) {
              return Center(child: Container());
            } else {
              return SizedBox.shrink();
            }
          },
          listener: (BuildContext context, WatchListState state) {},
        ),
      ),
    );
  }
}
