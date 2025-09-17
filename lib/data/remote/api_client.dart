
import 'package:dio/dio.dart';
import 'package:frijo/application/core/serveice/dio_client.dart';
import 'package:frijo/data/models/home_datamodel.dart';
import 'package:frijo/data/models/login_model.dart';
import 'package:frijo/data/models/category_model.dart';
import 'package:frijo/data/models/treatment_model.dart';
import 'package:frijo/domain/core/exception/custom_exception.dart';

class ApiClient {
  
  //login api
  static final DioClient _dioClient = DioClient(Dio());

  static Future<LoginModel> verifyOtp(String countryCode,String phone) async {
    print(countryCode); print(phone);
    try {
      final response = await _dioClient.post(
        '/otp_verified',
        options: Options(extra: {"requiresToken": false}),
        data: {
          'country_code': countryCode,
          'phone': phone
        },
      );
      return LoginModel.fromJson(response.data);
    } catch (e) {
      if (e is CustomException) rethrow;
      throw CustomException(errMsg: e.toString());
    }
  }

//get category list
static Future<CategoryListModel> getCategoriesApi() async {
    try {
      final response = await _dioClient.get(
        '/category_list',
      );
      return CategoryListModel.fromJson(response.data);
    } catch (e) {
      if (e is CustomException) rethrow;
      throw CustomException(errMsg: e.toString());
    }
  }

  //get home data
static Future<HomeDataModel> getHomeDataApi() async {
    try {
      final response = await _dioClient.get(
        '/home',
      );
      return HomeDataModel.fromJson(response.data);
    } catch (e) {
      if (e is CustomException) rethrow;
      throw CustomException(errMsg: e.toString());
    }
  }


  //get my feed
static Future<MyFeedModel> addMyFeedApi() async {
    try {
      final response = await _dioClient.get(
        '/my_feed',
      );
      return MyFeedModel.fromJson(response.data);
    } catch (e) {
      if (e is CustomException) rethrow;
      throw CustomException(errMsg: e.toString());
    }
  }
}
