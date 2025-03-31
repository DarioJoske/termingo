import 'package:termingo/src/core/utils/typedefs.dart';

abstract class UsecaseWithParams<T, Params> {
  const UsecaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class UsecaseWithoutParams<T> {
  const UsecaseWithoutParams();

  ResultFuture<T> call();
}

abstract class StreamUsecaseWithoutParams<T> {
  const StreamUsecaseWithoutParams();

  Stream<T> call();
}
