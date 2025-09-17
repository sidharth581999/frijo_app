
import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/branch_model.dart';
import 'package:frijo/data/models/patient_model.dart';
import 'package:frijo/data/remote/api_client.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';
import 'package:frijo/domain/repository/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {

  @override
  Future<Either<MainFailure, CategoryListModel>> getCategories() async {
    try {
      final result = await ApiClient.getCategoriesApi();
      return right(result);
    } catch (e) {
      return left(MainFailure.genericError(errorMsg: e.toString()));
    }
  }

 @override
  Future<Either<MainFailure, HomeDataModel>> getHomeFeeds() async {
    try {
      print("4-------------------------");
      final result = await ApiClient.getHomeDataApi();
      return right(result);
    } catch (e) {
      return left(MainFailure.genericError(errorMsg: e.toString()));
    }
  }
}
