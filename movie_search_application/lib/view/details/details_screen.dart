import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_application/common/helper/message/display_message.dart';

import 'package:movie_search_application/controller/bloc/details_bloc/details_bloc.dart';
import 'package:movie_search_application/controller/bloc/details_bloc/details_event.dart';
import 'package:movie_search_application/controller/bloc/details_bloc/details_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/core/configs/theme/app_text.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/core/service_locator.dart';

class DetailsScreen extends StatefulWidget {
  final MovieModel movieModel;
  const DetailsScreen({super.key, required this.movieModel});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // create: (context) => DetailsBloc()..add(DetailsInitialEvent()),
      // create: (context) => getIt<DetailsBloc>()..add(DetailsInitialEvent()),
      value: getIt<DetailsBloc>()..add(DetailsInitialEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,

        body: BlocConsumer<DetailsBloc, DetailsState>(
          builder: (BuildContext context, state) {
            if (state is DetailsLoadingState) {
              return CircularProgressIndicator();
            } else if (state is DetailsSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text("Details", style: AppText.appBarTitle),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              if ((state.bookmarkList.any(
                                (movie) =>
                                    movie.title!.toLowerCase() ==
                                    widget.movieModel.title!.toLowerCase(),
                              ))) {
                                context.read<DetailsBloc>().add(
                                  RemoveBookmarkEvent(movie: widget.movieModel),
                                );
                                DisplayMessage.showMessage(
                                  message: "Movie remove from Bookmark!",
                                  context: context,
                                  isError: false,
                                );
                              } else {
                                context.read<DetailsBloc>().add(
                                  AddBookmarkEvent(movie: widget.movieModel),
                                );
                                DisplayMessage.showMessage(
                                  message: "Movie added to your Bookmark!",
                                  context: context,
                                  isError: false,
                                );
                              }
                            },
                            icon: Icon(
                              (state.bookmarkList.any(
                                    (movie) =>
                                        movie.title!.toLowerCase() ==
                                        widget.movieModel.title!.toLowerCase(),
                                  ))
                                  ? Icons.bookmark_sharp
                                  : Icons.bookmark_border_outlined,
                              color: AppColors.primary,
                              weight: 23,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if ((state.watchListList.any(
                                (movie) =>
                                    movie.title!.toLowerCase() ==
                                    widget.movieModel.title!.toLowerCase(),
                              ))) {
                                context.read<DetailsBloc>().add(
                                  RemoveWatchListEvent(
                                    movie: widget.movieModel,
                                  ),
                                );
                                DisplayMessage.showMessage(
                                  message: "Movie remove from WatchList!",
                                  context: context,
                                  isError: false,
                                );
                              } else {
                                context.read<DetailsBloc>().add(
                                  AddWatchListEvent(movie: widget.movieModel),
                                );
                                DisplayMessage.showMessage(
                                  message: "Movie added to your WatchList!",
                                  context: context,
                                  isError: false,
                                );
                              }
                            },
                            icon: Icon(
                              (state.watchListList.any(
                                    (movie) =>
                                        movie.title!.toLowerCase() ==
                                        widget.movieModel.title!.toLowerCase(),
                                  ))
                                  ? Icons.watch_later
                                  : Icons.watch_later_outlined,
                              color: AppColors.primary,

                              weight: 23,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              color: AppColors.primary,
                              weight: 23,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(widget.movieModel.posterUrl!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                // clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 71, 71, 71),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  border: Border.symmetric(
                                    vertical: BorderSide(
                                      color: const Color.fromARGB(
                                        255,
                                        71,
                                        71,
                                        71,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Releaseing on ${widget.movieModel.releaseDate}"
                                      .substring(0, 24),
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(widget.movieModel.title!, style: AppText.primaryTitle),
                  Row(
                    children: [
                      Text(
                        widget.movieModel.duration!,
                        style: AppText.secondaryDescription,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "-${widget.movieModel.genre!}",
                        style: AppText.secondaryDescription,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.movieModel.description!,
                      style: AppText.primaryDescription,
                    ),
                  ),
                  Text("Review", style: AppText.secondaryTitle),
                  Row(
                    children: [
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: widget.movieModel.rating!,
                        // glowColor: ,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, index) {
                          if (index < widget.movieModel.rating!) {
                            return Icon(Icons.star, color: AppColors.primary);
                          } else {
                            return Icon(
                              Icons.star,
                              color: AppColors.secondBackground,
                            );
                          }
                        },
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        "(${widget.movieModel.rating!})",
                        style: AppText.secondaryDescription,
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is DetailsFailureState) {
              return Center(child: Container());
            } else {
              return SizedBox.shrink();
            }
          },
          listener: (BuildContext context, DetailsState state) {},
        ),
      ),
    );
  }
}
