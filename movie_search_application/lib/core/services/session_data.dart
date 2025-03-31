import 'dart:convert';

import 'package:movie_search_application/model/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;
  static String? email;
  static String? username;

  static Future<void> storeBookmarks(List<MovieModel> movies) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String moviesJson = jsonEncode(
      movies.map((movie) => movie.toJson()).toList(),
    );
    await pref.setString('bookmarkList', moviesJson);
  }

  static Future<void> storeWatchLists(List<MovieModel> movies) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String moviesJson = jsonEncode(
      movies.map((movie) => movie.toJson()).toList(),
    );
    await pref.setString('watchListList', moviesJson);
  }

  static Future<List<MovieModel>> getBookmarks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? moviesJson = pref.getString('bookmarkList');

    if (moviesJson != null) {
      List<dynamic> jsonList = jsonDecode(moviesJson);
      return jsonList.map((json) => MovieModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<MovieModel>> getWatchLists() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? moviesJson = pref.getString('watchListList');

    if (moviesJson != null) {
      List<dynamic> jsonList = jsonDecode(moviesJson);
      return jsonList.map((json) => MovieModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> removeBookmark(MovieModel movie) async {
    List<MovieModel> movies = await getBookmarks();
    movies.removeWhere((m) => m.title == movie.title);
    await storeBookmarks(movies);
  }

  static Future<void> removeWatchList(MovieModel movie) async {
    List<MovieModel> movies = await getWatchLists();
    movies.removeWhere((m) => m.title == movie.title);
    await storeWatchLists(movies);
  }

  static Future<void> storeSessiondata({
    required bool isLogin,
    required String email,
    required String username,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isLogin", isLogin);
    pref.setString("email", email);
    pref.setString("username", username);

    getSessiondata();
  }

  static Future<void> getSessiondata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool("isLogin") ?? false;
    email = pref.getString("email") ?? "";
    username = pref.getString("username") ?? "";
  }
}
