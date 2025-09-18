import 'package:dartz/dartz.dart';
import 'package:frijo/data/models/treatment_model.dart';
import 'package:frijo/data/remote/api_client.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';
import 'package:frijo/domain/repository/myfeed_repo.dart';
import 'package:frijo/presentation/bloc/shareFeed/share_feed_bloc.dart';

class MyFeedRepositoryImpl implements MyFeedRepository {

  @override
  Future<Either<MainFailure, MyFeedModel>> addMyFeed ({required ShareFeedModel feed}) async {
    try {
      final result = await ApiClient.addMyFeedApi(feed);
      return right(result);
    } catch (e) {
      return left(MainFailure.genericError(errorMsg: e.toString()));
    }
  }
}
