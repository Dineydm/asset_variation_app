import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/features/asset/models/asset.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;

  const AssetCard(this.asset);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      width: double.infinity,
      height: 220,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    RowAssetCard(
                      'Dia',
                      asset.day.toString(),
                      trailingTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      tailTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    _getDivider(),
                    RowAssetCard(
                        'Data', DateFormat('dd/MM/yyyy').format(asset.date)),
                    _getDivider(),
                    RowAssetCard(
                        'Valor',
                        asset.value != null
                            ? NumberFormat.simpleCurrency(locale: 'pt')
                                .format(asset.value)
                            : '-'),
                    _getDivider(),
                    RowAssetCard(
                        'Variação em relação a D-1',
                        asset.dayVariation != null
                            ? '${num.parse(asset.dayVariation!.toStringAsFixed(2))} %'
                            : '-'),
                    _getDivider(),
                    RowAssetCard(
                      'Variação em relação a primeira data',
                      asset.firstDayVariation != null
                          ? '${num.parse(asset.firstDayVariation!.toStringAsFixed(2))} %'
                          : '-',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider _getDivider() {
    return Divider(
      color: Colors.grey[400],
      thickness: .5,
    );
  }
}

class RowAssetCard extends StatelessWidget {
  final String trailing;
  final String tail;
  final TextStyle trailingTextStyle;
  final TextStyle tailTextStyle;

  const RowAssetCard(
    this.trailing,
    this.tail, {
    this.trailingTextStyle =
        const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
    this.tailTextStyle = const TextStyle(fontSize: 13),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          trailing,
          style: trailingTextStyle,
        ),
        Text(
          tail,
          style: tailTextStyle,
        ),
      ],
    );
  }
}
