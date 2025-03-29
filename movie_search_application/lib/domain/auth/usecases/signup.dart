import 'package:dartz/dartz.dart';
import 'package:movie_search_application/core/usecase/usecase.dart';
import 'package:movie_search_application/data/auth/models/signup_req_params.dart';
import 'package:movie_search_application/domain/auth/repositories/auth.dart';
import 'package:movie_search_application/utils/service_locator.dart';

class SignupUseCase extends UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
