import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_search_application/core/network/dio_client.dart';
import 'package:movie_search_application/data/auth/models/signin_req_params.dart';
import 'package:movie_search_application/data/auth/models/signup_req_params.dart';
import 'package:movie_search_application/utils/service_locator.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams params);
  Future<Either> signin(SigninReqParams params);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams params) async {
    //implement firebase auth
    try {
      var response = await sl<DioClient>().fireBaseAuthSignin();
      return Right(response);
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either> signin(SigninReqParams params) async {
    //implement firebase auth
    try {
      var response = await sl<DioClient>().fireBaseAuthSignin();
      return Right(response);
    } catch (e) {
      return Left(e);
    }
  }
}

// class AuthFirebaseServiceImpl extends AuthApiService {
//   @override
//   Future<Either> signup(SignupReqParams params) {
//     // TODO: implement signup
//     throw UnimplementedError();
//   }
// }
