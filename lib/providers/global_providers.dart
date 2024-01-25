import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/common/constant.dart';

import '../database/shared_pref/save_local_info.dart';

final dioInterceptorProvider = Provider<InterceptorsWrapper>(
  (ref) => InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Request header: ${options.headers}');

    log('Request uri: ${options.uri}');
    log('Request Body: ${options.data}');
    log('Request Body: ${options.data}');

    return handler.next(options);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response body: ${response.data}');
    return handler.next(response);
  }, onError: (DioError error, ErrorInterceptorHandler handler) {
    debugPrint('DIO ERROR: ${error.message}');
    debugPrint('ERROR TYPE: ${error.type}');
    debugPrintStack(stackTrace: error.stackTrace);
    return handler.next(error);
  }),
);

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio();
  dio.interceptors.add(ref.read(dioInterceptorProvider));
  return dio;
});

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) => SharedPreferencesService());
final sharedPreferencesInitializedProvider = FutureProvider<void>((ref) async {
  final service = ref.watch(sharedPreferencesServiceProvider);
  return service.init();
});

final saveTokenProvider =
    FutureProvider.family<void, String>((ref, token) async {
  final service = ref.watch(sharedPreferencesServiceProvider);
  return service.saveToken(token: token);
});

final tokenExistsProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(sharedPreferencesServiceProvider);
  bool doesExist = await service.doesKeyExist(
      authTokenIdentifier); // Assuming 'TOKEN_KEY' is the key you use for the token
  return doesExist;
});

final authTokenProvider = FutureProvider<String>((ref) async {
  final service = ref.watch(sharedPreferencesServiceProvider);
  String doesExist = await service.getString(
      authTokenIdentifier); // Assuming 'TOKEN_KEY' is the key you use for the token
  return doesExist;
});
