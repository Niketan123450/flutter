import 'package:dartz/dartz.dart';
import 'package:movie_search_application/data/auth/models/signin_req_params.dart';
import 'package:movie_search_application/data/auth/models/signup_req_params.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams perams);
  Future<Either> signin(SigninReqParams perams);
}
