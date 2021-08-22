import 'dart:async';

import 'package:bloc/bloc.dart';

import '/core/helpers/common_helper.dart';
import '/features/asset/models/asset.dart';
import '/features/asset/models/asset_list.dart';
import '../data/repositories/asset_repository_impl.dart';
import 'bloc.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetRepository _assetRepository;

  AssetBloc(this._assetRepository) : super(Empty());

  @override
  Stream<AssetState> mapEventToState(
    AssetEvent event,
  ) async* {
    if (event is ClearEvent) {
      yield Empty();
    }
    if (event is GetAssetsListEvent) {
      final result =
          await _assetRepository.getAssetList(event.period1, event.period2);
      yield await result.fold((l) => Error(message: mapFailureToMessage(l)),
          (r) => GetAssetsListSuccess(_getAssetList(r)));
    }
  }

  List<Asset> _getAssetList(AssetList getAssetsList) {
    final _mapAsset = Map<int, double?>();
    List.generate(getAssetsList.timestamp.length, (i) {
      if (getAssetsList.indicators.quote.first.open[i] == null) {
        print(getAssetsList.indicators.quote.first.open[i]);
      }
      _mapAsset.putIfAbsent(getAssetsList.timestamp[i],
          () => getAssetsList.indicators.quote.first.open[i]);
    });

    final _assetList = _mapAsset.entries
        .map((e) => Asset(
              date: DateTime.fromMillisecondsSinceEpoch(e.key * 1000),
              value: e.value,
            ))
        .toList();

    return _processList(_assetList);
  }

  List<Asset> _processList(List<Asset> assets) {
    final _assets =
        assets.reversed.toList().getRange(0, 30).toList().reversed.toList();
    double? firstDay, dayLessOne;

    firstDay = _assets[0].value!;

    for (int i = 0; i <= _assets.length - 1; i++) {
      _assets[i].day = i + 2;

      if (i > 0) {
        if (dayLessOne != null) {
          _assets[i].dayVariation = (_assets[i].value! / dayLessOne - 1) * 100;
        }

        _assets[i].firstDayVariation = (_assets[i].value! / firstDay - 1) * 100;
      } else {
        _assets[i].dayVariation = null;
        _assets[i].firstDayVariation = null;
      }

      dayLessOne = _assets[i].value ?? 0;
    }

    return _assets;
  }
}
