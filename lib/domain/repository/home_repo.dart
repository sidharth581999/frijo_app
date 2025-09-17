import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/home_datamodel.dart';
import 'package:frijo/data/models/category_model.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';

abstract class HomeRepository {
  Future<Either<MainFailure, CategoryListModel>> getCategories();
  Future<Either<MainFailure, HomeDataModel>> getHomeFeeds();
}
