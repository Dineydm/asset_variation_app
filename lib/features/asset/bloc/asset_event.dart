import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AssetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClearEvent extends AssetEvent {}

class GetAssetsListEvent extends AssetEvent {
  final String period1;
  final String period2;

  GetAssetsListEvent(this.period1, this.period2);
}
