import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frijo/application/core/route/app_route.dart';
import 'package:frijo/application/core/theme/app_theme.dart';
import 'package:frijo/application/core/utils/device_size.dart';
import 'package:frijo/application/core/utils/enums.dart';
import 'package:frijo/application/core/utils/toast.dart';
import 'package:frijo/presentation/bloc/homeBloc/home_bloc.dart';
import 'package:frijo/presentation/bloc/loginBloc/login_bloc.dart';
import 'package:frijo/presentation/bloc/theme_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeviceSize.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),

        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: HelperService.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Fliq',
            onGenerateRoute: AppRoute.onGenerateRoute,
            initialRoute: AppRoute.login,
            theme: AppTheme.getTheme(AppThemeMode.light),
          );
        },
      ),
    );
  }
}
