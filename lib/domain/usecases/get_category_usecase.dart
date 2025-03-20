import 'package:fpdart/fpdart.dart';
import 'package:shopx/core/errors/failures.dart';
import 'package:shopx/domain/repositories/product_repositories.dart';

class GetCategories {
  final ProductRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<String>>> call() {
    return repository.getCategories();
  }
}
