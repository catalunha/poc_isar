import 'package:dio/dio.dart';

class DioAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final RequestOptions(:headers, :extra) = options;
    headers.remove('Authorization');
    if (extra case {'DIO_AUTH_KEY': true}) {
      // headers.addAll({'Authorization': 'Bearer 123'});
    }
    handler.next(options);
  }
}
