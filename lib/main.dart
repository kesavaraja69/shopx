import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shopx/core/theme/app_theme.dart';
import 'package:shopx/firebase_options.dart';
import 'package:shopx/presentation/bloc/Auth/auth_bloc.dart';
import 'package:shopx/presentation/screens/splash_screen.dart';
import 'package:shopx/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => GetIt.I<AuthBloc>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Shopx',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
