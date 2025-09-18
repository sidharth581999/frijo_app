import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:frijo/data/models/treatment_model.dart';
import 'package:frijo/data/repository/my_feedrepo_impl.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';
import 'package:frijo/domain/repository/myfeed_repo.dart';
import 'package:frijo/presentation/bloc/shareFeed/share_feed_bloc.dart';

class AddPost {
  final MyFeedRepository repository;

  AddPost(this.repository);

  factory AddPost.defaultRepo() {
    return AddPost(MyFeedRepositoryImpl());
  }

  Future<Either<MainFailure, MyFeedModel>> addFeed({required ShareFeedModel feed}) {
    return repository.addMyFeed(feed:  feed);
  }
}
