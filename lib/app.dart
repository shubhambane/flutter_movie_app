import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/presentation/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:movieflix/routes/app_routes.dart';
import 'package:movieflix/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieFlix',
        themeMode: ThemeMode.system,
        theme: MAppTheme.lightTheme,
        // darkTheme: MAppTheme.darkTheme,
        initialRoute: AppRoutes.main,
        routes: AppRoutes.routes,
      ),
    );
  }
}
