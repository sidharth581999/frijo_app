part of 'share_feed_bloc.dart';

@immutable
sealed class ShareFeedEvent {}

class ShareFeedClickedEvent extends ShareFeedEvent {
  final ShareFeedModel data;

  ShareFeedClickedEvent({required this.data});
}