import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/asset/bloc/bloc.dart';
import '/features/asset/models/asset.dart';
import '/features/asset/presentation/pages/about_page.dart';
import 'asset_page.dart';
import 'line_chart_page.dart';

enum Pages { list, chart, about }

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Asset> _assetList = [];

  @override
  void initState() {
    super.initState();

    _searchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.list, size: 30),
            Icon(Icons.insert_chart_outlined, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: BlocBuilder<AssetBloc, AssetState>(builder: (context, state) {
          if (state is GetAssetsListSuccess) {
            _assetList = state.assetList;
          }
          if (_assetList.isNotEmpty) {
            return _getPage(_page, _assetList);
          }
          return const Center(
              child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
        }));
  }

  Widget _getPage(int page, List<Asset> assetList) {
    final widgetList = [
      AssetPage(assetList),
      LineChartPage(assetList),
      AboutPage()
    ];
    return widgetList[page];
  }

  void _searchData() {
    const initialDate = 1609470000;

    BlocProvider.of<AssetBloc>(context).add(GetAssetsListEvent(
        initialDate.toString(),
        DateTime.now().millisecondsSinceEpoch.toString()));
  }
}
