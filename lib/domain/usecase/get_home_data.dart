
import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/branch_model.dart';
import 'package:frijo/data/models/patient_model.dart';
import 'package:frijo/data/repository/home_repo_impl.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';
import 'package:frijo/domain/repository/home_repo.dart';

class GetHomeData {
  final HomeRepository repository;

  GetHomeData(this.repository);

  factory GetHomeData.defaultRepo() {
    return GetHomeData(HomeRepositoryImpl());
  }

  Future<Either<MainFailure, HomeDataModel>> getHomeFeeds() {
    return repository.getHomeFeeds();
  }

  //get categories
  Future<Either<MainFailure, CategoryListModel>> getCategories() {
    return repository.getCategories();
  }
}
