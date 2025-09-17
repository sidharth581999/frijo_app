import 'package:flutter/material.dart';
import 'package:frijo/application/core/route/app_route.dart';
import 'package:frijo/application/core/theme/colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) {
     Navigator.pushReplacementNamed(context, AppRoute.login);
  });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorResources.blackBG,
          ));
  }

  // loginCheck() async{
  //   // await LoginDataStore.clearLogin();
  //   final res = await LoginDataStore.getLogin();
  //   if (res != null && res.token != null) {
  //     // context.read<HomeBloc>().add(
  //     //                     HomeBuildEvent()
  //     //                   );
  //     Navigator.pushReplacementNamed(context, AppRoute.home);
  //   } else{
  //     Navigator.pushReplacementNamed(context, AppRoute.login);
  //   }
  // }
}