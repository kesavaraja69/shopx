import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopx/domain/usecases/get_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  CategoryBloc({required this.getCategories}) : super(CategoryInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  void _onFetchCategories(
    FetchCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoriesLoading());
    final result = await getCategories();
    emit(
      result.fold(
        (failure) => CategoriesError(failure.toString()),
        (categories) => CategoriesLoaded(categories),
      ),
    );
  }
}
