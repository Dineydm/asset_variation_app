import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/features/asset/presentation/pages/dashboard_page.dart';
import '/injection_container.dart' as di;
import 'features/asset/bloc/bloc.dart';

Future<void> main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asset Variation',
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto(fontSize: 16).fontFamily,
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AssetBloc>(
            create: (context) => di.sl<AssetBloc>(),
          ),
        ],
        child: DashboardPage(),
      ),
    );
  }
}
