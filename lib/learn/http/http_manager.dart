import 'package:dio/dio.dart';
import 'api.dart';

class HttpManager {
  late Dio _dio;
  static late HttpManager _instance;

  factory HttpManager.getInstance() {
    _instance = HttpManager._internal();
    return _instance;
  }

  //以 _ 开头的函数、变量无法在库外使用
  HttpManager._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Api.baseUrl, //基础地址
      connectTimeout: 5000, //连接服务器超时时间，单位是毫秒
      receiveTimeout: 3000, //读取超时
    );
    _dio = Dio(options);
  }

  request(url, {String method = "get"}) async {
    try {
      Options option = Options(method: method);
      Response response = await _dio.request(url, options: option);
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
