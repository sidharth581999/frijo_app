part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeBuildEvent extends HomeEvent {}

class HomeSearchEvent extends HomeEvent {
  final String serach;
  final String date;

  HomeSearchEvent({required this.serach, required this.date});
}
