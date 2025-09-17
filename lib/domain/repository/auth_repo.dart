
import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/login_model.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';

abstract class AuthRepository {
  Future<Either<MainFailure, LoginModel>> verifyOtp({
    required String countryCode,
    required String phoneNo,
  });
}
