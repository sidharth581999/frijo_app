part of 'addfeed_bloc.dart';

@immutable
sealed class AddFeedState {}

final class AddFeedInitial extends AddFeedState {}

final class AddFeedBuildState extends AddFeedState {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final CategoryListModel? categories;
  final String? errorMsg;

  AddFeedBuildState({required this.isLoading, required this.isError, required this.isSuccess, required this.categories, required this.errorMsg});
}