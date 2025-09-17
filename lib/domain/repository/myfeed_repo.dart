
import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/treatment_model.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';

abstract class MyFeedRepository {
  Future<Either<MainFailure, MyFeedModel>> addMyFeed();
}
