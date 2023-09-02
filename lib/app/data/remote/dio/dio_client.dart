import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:poc_isar/app/data/remote/dio/interceptors/dio_auth_interceptor.dart';

final class DioClient extends DioForNative {
  DioClient()
      : super(
          BaseOptions(
            baseUrl: 'http://192.168.10.113:8000',
            // baseUrl: 'http://192.168.10.113:8080',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        DioAuthInterceptor(),
      ],
    );
  }
  DioClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  DioClient get unauth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }
}
