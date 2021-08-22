import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '/features/asset/models/asset.dart';

@immutable
abstract class AssetState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends AssetState {}

class GetAssetsListSuccess extends AssetState {
  final List<Asset> assetList;

  GetAssetsListSuccess(this.assetList);
}

class Error extends AssetState {
  final String? message;

  Error({@required this.message});
}
