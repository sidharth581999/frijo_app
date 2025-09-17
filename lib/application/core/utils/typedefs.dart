
import 'package:dartz/dartz.dart';
import 'package:frijo/domain/core/failures/main_failures.dart';


typedef Result<T> = Either<MainFailure, T>;
typedef ResultFuture<T> = Future<Result<T>>;
