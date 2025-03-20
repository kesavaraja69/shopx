import 'package:fpdart/fpdart.dart';
import 'package:shopx/data/models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/product_repositories.dart';
import '../src/product_datasource.dart';
import 'dart:developer' as devtools show log;

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final List<ProductModel> productModels =
          await remoteDataSource.getProducts();
      final List<Product> products =
          productModels.map((model) => model.toEntity()).toList();
      devtools.log('products - ${products[0]}');

      return Right(products);
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      devtools.log('categories - ${categories[0]}');
      return Right(categories);
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }
}
