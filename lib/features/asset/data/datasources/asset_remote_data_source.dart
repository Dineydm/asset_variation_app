import 'dart:convert';

import 'package:http/http.dart' as http;

import '/features/asset/models/asset_list.dart';

const kUrlBase = 'https://query1.finance.yahoo.com/v8/finance/chart/PETR4.SA?';

abstract class AssetRemoteDataSource {
  Future<dynamic> getAssetList(String period1, String period2);
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  @override
  Future<dynamic> getAssetList(String period1, String period2) async {
    final url =
        '${kUrlBase}period1=$period1&period2=$period2&interval=1d&lang=pt-BR&region=BR';

    final result = await http.get(Uri.parse(url));
    final body = jsonDecode(result.body);
    return AssetList.fromJson(body['chart']['result'].first);
  }
}
