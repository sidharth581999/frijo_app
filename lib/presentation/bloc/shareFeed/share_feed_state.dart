part of 'share_feed_bloc.dart';

@immutable
sealed class ShareFeedState {}

final class ShareFeedInitial extends ShareFeedState {}

final class ShareFeedClickedState extends ShareFeedState {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMsg;

  ShareFeedClickedState({required this.isLoading, required this.isError, required this.isSuccess, required this.errorMsg});
}
