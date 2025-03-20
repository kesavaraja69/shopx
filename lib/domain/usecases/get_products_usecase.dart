import 'package:fpdart/fpdart.dart';
import 'package:shopx/domain/repositories/product_repositories.dart';
import '../../core/errors/failures.dart';
import '../entities/product.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getProducts();
  }
}
