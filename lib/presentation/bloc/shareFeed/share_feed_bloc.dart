import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frijo/domain/usecase/add_post.dart';
import 'package:meta/meta.dart';

part 'share_feed_event.dart';
part 'share_feed_state.dart';

class ShareFeedBloc extends Bloc<ShareFeedEvent, ShareFeedState> {
  ShareFeedBloc() : super(ShareFeedInitial()) {
    on<ShareFeedClickedEvent>(shareFeedClickedEvent);
  }

  FutureOr<void> shareFeedClickedEvent(ShareFeedClickedEvent event, Emitter<ShareFeedState> emit) async{
    emit(ShareFeedClickedState(isLoading: true, isError: false, isSuccess: false, errorMsg: null));
    final shareFeed = AddPost.defaultRepo();
    final response = await shareFeed.addFeed(feed: event.data);
    emit(
      response.fold((l) => ShareFeedClickedState(isLoading: false, isError: true, isSuccess: false, errorMsg: l.errorMsg), 
      (r)=> ShareFeedClickedState(isLoading: false, isError: false, isSuccess: true, errorMsg: "Feed shared suuceesfully"))
    );
  }
}


class ShareFeedModel{
  final String video;
  final String image;
  final String desc;
  final List<int> categories;

  ShareFeedModel({required this.video, required this.image, required this.desc, required this.categories});
}