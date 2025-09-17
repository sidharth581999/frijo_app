import 'dart:io';
import 'package:dio/dio.dart';
import 'package:frijo/application/core/utils/extentions.dart';
import 'package:frijo/application/core/utils/logger.dart';
import 'package:frijo/application/core/utils/urls.dart';
import 'package:frijo/data/storage/login_data.dart';
import 'package:frijo/domain/core/exception/custom_exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DioClient {
  final Dio dio;
  String? token;
  late String fcmToken;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = Urls.baseURL
      ..options.connectTimeout = const Duration(milliseconds: 60000)
      ..options.receiveTimeout = const Duration(milliseconds: 60000);
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
      ),
    );
    dio.interceptors.add(InternetConnectionInterceptor());
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            // TODO Navigate
          } else {
            return handler.next(error);
          }
        },
      ),
    );
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      Logger.logError(e);
      // print("no network - 1");
      throw CustomException(
        errMsg: e.toString(),
      );
    } on FormatException catch (_) {
      throw CustomException(errMsg: "Unable to process the data");
    } catch (e) {
      Logger.logError("Dio Get Error: $e");

      if (e is DioException && e.message == "No internet connection") {
        Logger.logWarning(e.response);
        throw CustomException(errMsg: e.message ?? '');
      }

      if (e is DioException) {
        final message = e.response?.data['message'];

        throw CustomException(errMsg: '$message'.capitalize);
      }

      throw CustomException(errMsg: "Unknown error occurred");
    }
  }

  Future<Response> post(
  String uri, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
}) async {
  print("here in post -------------------");
  try {
    var response = await dio.post(
      uri,
      data: data , 
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  } on SocketException catch (e) {
    print("------------------------------)))");
    throw CustomException(errMsg: e.toString());
  } on FormatException catch (_) {
    print("------------------------------000");
    throw CustomException(errMsg: "Unable to process the data");
  } catch (e) {
    print("------------------------------999");
    if (e is DioException && e.message == "No internet connection") {
      throw CustomException(errMsg: e.message ?? '');
    }
    if (e is DioException) {
      print(e);
      print(e.message);
      print(e.error);
      print(e.response?.data);
      print("[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]");
      final message = e.response?.data['message'];
      print("----------$message");
      throw CustomException(errMsg: '$message'.capitalize);
    }
    print("44444444444444444");
    rethrow;
  }
}


  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw CustomException(errMsg: "Unable to process the data");
    } catch (e) {
      if (e is DioException && e.message == "No internet connection") {
        throw CustomException(errMsg: e.message ?? '');
      }
      if (e is DioException) {
        final message = e.response?.data['message'];

        throw CustomException(errMsg: '$message'.capitalize);
      }
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw CustomException(errMsg: "Unable to process the data");
    } catch (e) {
      if (e is DioException && e.message == "No internet connection") {
        throw CustomException(errMsg: e.message ?? '');
      }
      if (e is DioException) {
        final message = e.response?.data['message'];

        throw CustomException(errMsg: '$message'.capitalize);
      }
      throw CustomException(
        errMsg: e.toString(),
      );
    }
  }
}



class LoggingInterceptor extends InterceptorsWrapper {
 Future<String?> _getToken() async {
  final login = await LoginDataStore.getLogin();
  return login?.token?.access; // ✅ safe null check
}

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    DateTime now = DateTime.now().toUtc();

    final token = await _getToken();

    options.headers.addAll({
      'Timestamp': now.millisecondsSinceEpoch,
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token != null ? 'Bearer $token' : '',
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json',
      'Device-Type': Platform.isAndroid
          ? 1
          : Platform.isIOS
              ? 2
              : 0,
    });

    Logger.logWarning("Headers: ${options.headers.toString()}");
    Logger.logWarning("Parms: ${options.data.toString()}");
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    try {
      if (response.statusCode == 201) {
        return super.onResponse(response, handler);
      } else if (response.data['status'] == true) {
        return super.onResponse(response, handler);
      } else {
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: response.data,
            response: response,
            type: DioExceptionType.unknown,
          ),
        );
      }
    } catch (_) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: "Something went wrong",
          response: response,
          type: DioExceptionType.unknown,
        ),
      );
    }
  }
}


// class LoggingInterceptor extends InterceptorsWrapper {
//   @override
//   Future onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     DateTime now = DateTime.now().toUtc();
//     // String? token = box.read(AppConstants.token);
//     options.headers.addAll({
//       'Timestamp': now.millisecondsSinceEpoch,
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer ',
//       'Access-Control-Allow-Origin': '*',
//       'Accept': 'application/json',
//       'Device-Type': Platform.isAndroid
//           ? 1
//           : Platform.isIOS
//               ? 2
//               : 0,
//       // 'Device-Token': AppConstants.fcmToken ?? "",
//       // 'Language': di.sl<LanguageBloc>().locale.languageCode,
//       // 'User-Agent': AppConstants.userAgent ?? {}
//     });

//     Logger.logWarning("Headers: ${options.headers.toString()}");
//     Logger.logWarning("Parms: ${options.data.toString()}");
//     return super.onRequest(options, handler);
//   }

//   @override
//   Future onResponse(
//       Response response, ResponseInterceptorHandler handler) async {
//     try {
//       if (response.statusCode == 201) {
//         return super.onResponse(response, handler);
//       } else if (response.data['status'] == true) {
//         return response.data['status'] == true
//             ? super.onResponse(response, handler)
//             : handler.reject(
//                 DioException(
//                   requestOptions: response.requestOptions,
//                   error: response.data,
//                   response: response,
//                   type: DioExceptionType.unknown,
//                 ),
//               );
//         //newly added else
//       } else {
//         return response.data['status'] == true
//             ? super.onResponse(response, handler)
//             : handler.reject(
//                 DioException(
//                   requestOptions: response.requestOptions,
//                   error: response.data,
//                   response: response,
//                   type: DioExceptionType.unknown,
//                 ),
//               );
//       }
//     } catch (e) {
//       handler.reject(
//         DioException(
//           requestOptions: response.requestOptions,
//           error: "Something went wrong",
//           response: response,
//           type: DioExceptionType.unknown,
//         ),
//       );
//     }
//   }

//   @override
//   Future onError(DioException err, ErrorInterceptorHandler handler) async {
//     return super.onError(err, handler);
//   }
// }

class InternetConnectionInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return handler.reject(
        DioException(
          requestOptions: options,
          message: 'No internet connection',
          type: DioExceptionType.connectionTimeout,
        ),
      );
    }
    return super.onRequest(options, handler);
  }
}

