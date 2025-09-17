import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:frijo/data/models/home_datamodel.dart';
import 'package:frijo/domain/usecase/get_home_data.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeBuildEvent>(homeBuildEvent);
  }

  FutureOr<void> homeBuildEvent(HomeBuildEvent event, Emitter<HomeState> emit) async{
    emit(HomeBuildState(isLoading: true, isError: false, isSuccess: false, homeFeeds: null));
    final getHomeFeeds = GetHomeData.defaultRepo();
    final response = await getHomeFeeds.getHomeFeeds();
    print("--------------------------------ttttttttttttt");
print(response);
    emit(
      response.fold(
        (l) => HomeBuildState(isLoading: false, isError: true, isSuccess: false, homeFeeds: null, errorMsg: l.errorMsg), 
        (R)=> HomeBuildState(isLoading: false, isError: false, isSuccess: true, homeFeeds: R, errorMsg: null), )
    );
  }
}
