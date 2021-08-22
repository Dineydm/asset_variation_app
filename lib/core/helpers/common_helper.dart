import 'package:assetvariation/core/error/failures.dart';

String mapFailureToMessage(failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return failure.message ?? 'Falha do servidor';
    case CacheFailure:
      return failure.message ?? 'Falha de cache';
    default:
      return 'Erro inesperado';
  }
}
