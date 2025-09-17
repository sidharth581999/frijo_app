part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeBuildState extends HomeState {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMsg;
  final HomeDataModel? homeFeeds;

  HomeBuildState({required this.isLoading, required this.isError, required this.isSuccess, required this.homeFeeds, this.errorMsg}); 
}
