import 'package:covid_detection_system/presentation/pages/pages.dart';
import 'package:covid_detection_system/providers/bottom_nav_provider.dart';
import 'package:covid_detection_system/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DiagnoseProvider>(
          create: (BuildContext context) => DiagnoseProvider(),
        ),
        ChangeNotifierProvider<DetailProvider>(
          create: (BuildContext context) => DetailProvider(),
        ),
        ChangeNotifierProvider<BottomNavProvider>(
          create: (BuildContext context) => BottomNavProvider(),
        ),
        ChangeNotifierProvider<SortProvider>(
          create: (BuildContext context) => SortProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Covid Detection',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const PreviewPage(),
      ),
    );
  }
}
