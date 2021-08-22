import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';

import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/core/network/network_info.dart';
import '/features/asset/data/datasources/asset_remote_data_source.dart';
import '/features/asset/models/asset_list.dart';

abstract class AssetRepository {
  Future<Either<Failure, AssetList>> getAssetList(
      String period1, String period2);
}

class AssetRepositoryImpl extends AssetRepository {
  final AssetRemoteDataSource? dataSource;
  final NetworkInfo? networkInfo;

  AssetRepositoryImpl({this.dataSource, this.networkInfo});

  @override
  Future<Either<Failure, AssetList>> getAssetList(
      String period1, String period2) async {
    try {
      final connectivityResult = await networkInfo!.isConnected;
      if (connectivityResult == ConnectivityResult.none) {
        return Left(ServerFailure(message: 'Sem conexão de internet'));
      }

      final assets = await dataSource!.getAssetList(period1, period2);

      return Right(assets!);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure(message: (e as dynamic).message));
    }
  }
}
