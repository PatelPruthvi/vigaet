import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaet/resources/constants/app_constants.dart';
import 'package:vigaet/views/home_view/ui/home_view.dart';
import 'package:vigaet/views/role_selection_view/ui/role_selection_view.dart';
import 'package:vigaet/views/splash_view/bloc/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashBloc splashBloc = SplashBloc();
  @override
  void initState() {
    splashBloc.add(SplashInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: splashBloc,
        listener: (context, state) {
          if (state is SplashNavigateToHomePageActionState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(userRole: state.userRole)));
          } else if (state is SplashNavigateToRolePageActionState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RoleSelectionView()));
          }
        },
        child: Center(
            child: Image.asset(AppConstants.vigaIconImgPath,
                width: MediaQuery.of(context).size.width * 0.8)),
      ),
    );
  }
}
