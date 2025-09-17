import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/branch_model.dart';
import 'package:frijo/data/models/patient_model.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';

abstract class HomeRepository {
  Future<Either<MainFailure, CategoryListModel>> getCategories();
  Future<Either<MainFailure, HomeDataModel>> getHomeFeeds();
}
