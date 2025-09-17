import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/login_model.dart';
import 'package:frijo/data/remote/api_client.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';
import 'package:frijo/domain/repository/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {

  @override
  Future<Either<MainFailure, LoginModel>> verifyOtp({
    required String countryCode,
    required String phoneNo,
  }) async {
    try {
      print("4-------------------------");
      final result = await ApiClient.verifyOtp(countryCode, phoneNo);
      return right(result);
    } catch (e) {
      return left(MainFailure.genericError(errorMsg: e.toString()));
    }
  }
}
