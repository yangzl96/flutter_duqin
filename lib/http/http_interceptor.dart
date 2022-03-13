import 'package:dio/dio.dart';
import 'package:duqin/http/http_exception.dart';

// 自定义请求拦截 重构 dio中Interceptor里面的方法
class HttpInterceptor extends Interceptor {
  // 请求拦截
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // do something...
    // 调用父类原来的实现
    super.onRequest(options, handler);
  }

  // 响应拦截
  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // do something...
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // 生成自定义错误实例
    HttpException httpException = HttpException.create(err);
    // 将dioError里面的异常 覆盖为我们编写的自定义的异常类
    err.error = httpException;
    // 调用父类原来的实现方法
    super.onError(err, handler);
  }
}
