part of 'addfeed_bloc.dart';

@immutable
sealed class AddFeedEvent {}

class CategoryBuildEvent extends AddFeedEvent {}
