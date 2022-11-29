import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/presentation/pages/pages.dart';
import 'package:covidia/providers/admin_provider.dart';
import 'package:covidia/providers/authentication_provider.dart';
import 'package:covidia/providers/engine_provider.dart';
import 'package:covidia/providers/providers.dart';
import 'package:covidia/providers/saran_provider.dart';
import 'package:covidia/providers/sign_up_provider.dart';
import 'package:covidia/services/admin_services.dart';
import 'package:covidia/services/authentication_service.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:covidia/services/engine_service.dart';
import 'package:covidia/services/saran_service.dart';
import 'package:covidia/services/storage_service.dart';
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
          create: (BuildContext context) => DiagnoseProvider(
            DiagnoseService(FirebaseFirestore.instance),
            StorageService(),
          ),
        ),
        ChangeNotifierProvider<SaranProvider>(
          create: (BuildContext context) => SaranProvider(
            SaranService(FirebaseFirestore.instance),
          ),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(
            AuthenticationService(FirebaseAuth.instance),
          ),
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
        ChangeNotifierProvider<SignUpProvider>(
          create: (BuildContext context) => SignUpProvider(StorageService()),
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (BuildContext context) => AdminProvider(
            AdminServices(
              FirebaseFirestore.instance,
            ),
          ),
        ),
        ChangeNotifierProvider<EngineProvider>(
          create: (BuildContext context) => EngineProvider(
            EngineService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'covidia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.poppinsTextTheme(),
          canvasColor: Colors.white,
        ),
        home: const AdminHomePage(),
      ),
    );
  }
}
