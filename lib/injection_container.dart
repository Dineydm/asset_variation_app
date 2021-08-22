import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/asset/bloc/asset_bloc.dart';
import 'features/asset/data/datasources/asset_remote_data_source.dart';
import 'features/asset/data/repositories/asset_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => AssetBloc(sl()),
  );

  sl.registerLazySingleton<AssetRepository>(
    () => AssetRepositoryImpl(dataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AssetRemoteDataSource>(
    () => AssetRemoteDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
