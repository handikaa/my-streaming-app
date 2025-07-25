import 'package:dio/dio.dart';
import 'package:my_streaming/app/data/api/api_const.dart';

class DioClient {
  final String apiBaseUrl;

  int errorToken = 0;

  DioClient(this.apiBaseUrl);
  Dio get dio => getDio();

  Dio getDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        connectTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(seconds: 40),
      ),
    );

    return dio;
  }
}
