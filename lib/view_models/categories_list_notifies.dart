import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newproject/model/categories_model.dart';
import 'package:newproject/networking/repository/category_list_repository.dart';


final CategoryListNotifierProvider = StateNotifierProvider<CategoryListNotifier, AsyncValue<CategoriesModel>>(
        (ref) {
      return CategoryListNotifier(
        ref.watch(categoryListRepositoryProvider),
      );
    });


class CategoryListNotifier
    extends StateNotifier<AsyncValue<CategoriesModel>> {

  final CategoryListRepository _repository;
  // late final String email, password;

  CategoryListNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    getListOfCategories();
  }

  Future<void> getListOfCategories() async {
    try {
      state = const AsyncValue.loading();

      final response = await _repository.getListOfCategories();

      if (response.isSuccess) {
        state = AsyncValue.data(response.data!);
      } else {
        state = AsyncValue.error(response.errorMessage.toString(), StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}