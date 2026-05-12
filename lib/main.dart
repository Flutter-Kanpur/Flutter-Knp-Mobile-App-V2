import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_knp_mobile_app_v2/app/environments/env.dart';
import 'package:flutter_knp_mobile_app_v2/modules/auth/presentation/screens/screen1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName:".env");
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey:Env.supabaseAnonKey,
  );
  print("Supabase Initialized Successfully");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {



  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Kanpur App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Screen1(),
    );
  }
}
