import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/categories_model.dart';
import 'package:newproject/networking/rest_client/rest_client.dart';
import 'package:newproject/providers/global_providers.dart';
import 'package:newproject/utils/handler/network_response_handler.dart';

abstract class CategoryListRepository {
  Future<NetworkResponseHandler<CategoriesModel>> getListOfCategories();
}

final categoryListRepositoryProvider =
Provider<CategoryListRepositoryImpl>((ref) {
  return CategoryListRepositoryImpl(RestClient(ref.watch(dioProvider)));
});

class CategoryListRepositoryImpl implements CategoryListRepository {
  RestClient client;

  CategoryListRepositoryImpl(this.client);

  @override
  Future<NetworkResponseHandler<CategoriesModel>> getListOfCategories() async{
    try {
      final response = await client.getListOfCategories();
      if (response.code == 200) {
        return NetworkResponseHandler(
          isSuccess: true,
          data: response,
        );
      } else {
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: response.message ?? 'Unknown error',
        );
      }
    } catch (e) {
      print("An exception was caught: $e");
      if (e is DioError) {
        // Handle Dio specific errors here
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: e.message,
        );
      } else {
        // Handle other kinds of errors
        return NetworkResponseHandler(
          isSuccess: false,
          errorMessage: 'Unknown error occurred',
        );
      }
    }
  }
}
