import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/asset/bloc/bloc.dart';
import '/features/asset/models/asset.dart';
import '/features/asset/presentation/widgets/asset_card.dart';

class AssetPage extends StatefulWidget {
  final List<Asset> assetList;

  const AssetPage(this.assetList);

  @override
  _AssetPageState createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AssetBloc, AssetState>(builder: (context, state) {
      if (widget.assetList.isNotEmpty) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blueAccent,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ...widget.assetList
                        .map<AssetCard>((e) => AssetCard(e))
                        .toList()
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }

      String? error = '';
      if (state is Error) {
        error = state.message ?? '';
      }

      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueAccent,
        child: Center(
            child: Text(
          error,
          style: const TextStyle(color: Colors.white),
        )),
      );
    }));
  }
}
