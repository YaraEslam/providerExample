
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class Dio_Api {
  final String base_url = "https://providerexample.getsandbox.com/";
  static  Dio dio = null ;

  static Dio getClient(){
    if (dio == null){
      dio = new Dio();
      dio.interceptors.add(LogInterceptor(responseBody: false));
      var cookieJar = CookieJar();
      dio.interceptors.add(CookieManager(cookieJar));
      dio.options.headers = {
        "Content-Type": "application/json"
      };
    }
    return dio;
  }
}