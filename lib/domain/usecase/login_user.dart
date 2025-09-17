import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/login_model.dart';
import 'package:frijo/data/repository/auth_repository_impl.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';
import 'package:frijo/domain/repository/auth_repo.dart';

class VerifyUserOtp {
  final AuthRepository repository;

  VerifyUserOtp(this.repository);

  factory VerifyUserOtp.defaultRepo() {
    return VerifyUserOtp(AuthRepositoryImpl());
  }

  Future<Either<MainFailure, LoginModel>> call({
    required String countryCode,
    required String phoneNo,
  }) {
    return repository.verifyOtp(countryCode: countryCode, phoneNo: phoneNo);
  }
}
