import 'package:dartz/dartz.dart';
import 'package:movie_search_application/data/auth/models/signin_req_params.dart';
import 'package:movie_search_application/data/auth/models/signup_req_params.dart';
import 'package:movie_search_application/data/auth/sources/auth_api_service.dart';
import 'package:movie_search_application/domain/auth/repositories/auth.dart';
import 'package:movie_search_application/utils/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(SignupReqParams params) async {
    return await sl<AuthApiService>().signup(params);
  }

  @override
  Future<Either> signin(SigninReqParams perams) async {
    return await sl<AuthApiService>().signin(perams);
  }
}
