import 'package:covidia/presentation/pages/pages.dart';
import 'package:covidia/providers/preview_provider.dart';
import 'package:covidia/providers/providers.dart';
import 'package:covidia/providers/sign_up_provider.dart';
import 'package:covidia/services/authentication_service.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DiagnoseService _diagnoseService = DiagnoseService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider<DiagnoseProvider>(
          create: (BuildContext context) => DiagnoseProvider(_diagnoseService),
        ),
        ChangeNotifierProvider<ZoomProvider>(
          create: (BuildContext context) => ZoomProvider(),
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
        ChangeNotifierProvider<AiModelProvider>(
          create: (BuildContext context) => AiModelProvider(),
        ),
        ChangeNotifierProvider<ImgProvider>(
          create: (BuildContext context) => ImgProvider(),
        ),
        ChangeNotifierProvider<PreviewProvider>(
          create: (BuildContext context) => PreviewProvider(),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (BuildContext context) => SignUpProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'covidia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
          canvasColor: Colors.white,
        ),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}
