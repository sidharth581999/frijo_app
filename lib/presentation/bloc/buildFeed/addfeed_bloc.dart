import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:frijo/data/models/category_model.dart';
import 'package:frijo/data/models/login_model.dart';
import 'package:frijo/data/storage/login_data.dart';
import 'package:frijo/domain/usecase/add_post.dart';
import 'package:frijo/domain/usecase/get_home_data.dart';
import 'package:frijo/domain/usecase/login_user.dart';
import 'package:meta/meta.dart';
part 'addfeed_event.dart';
part 'addfeed_state.dart';

class AddFeedBloc extends Bloc<AddFeedEvent, AddFeedState> {
  AddFeedBloc() : super(AddFeedInitial()) {
    on<CategoryBuildEvent>(categoryBuildEvent);
  }

  FutureOr<void> categoryBuildEvent(CategoryBuildEvent event, Emitter<AddFeedState> emit) async{
    emit(AddFeedBuildState(isLoading: true, isError: false, isSuccess: false, categories: null, errorMsg: ""));
    final getHomeFeeds = GetHomeData.defaultRepo();
    final categories = await getHomeFeeds.getCategories();
    // final addFeed = AddPost.defaultRepo();
    // final response = await addFeed.addFeed();
    // final response = ;
    emit(
      categories.fold((L){
        return AddFeedBuildState(isLoading: false, isError: true, isSuccess: false, categories: null, errorMsg: L.errorMsg);
      }, (R){
        return
         AddFeedBuildState(isLoading: false, isError: false, isSuccess: true, categories: R, errorMsg: "");
      })
    );
  }
}
