// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaet/resources/constants/app_constants.dart';
import 'package:vigaet/views/home_view/ui/home_view.dart';
import 'package:vigaet/views/role_selection_view/bloc/role_bloc.dart';

import '../../../widgets/role_widget.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleBloc roleBloc = RoleBloc();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi There!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocListener<RoleBloc, RoleState>(
          bloc: roleBloc,
          listener: (context, state) {
            if (state is RoleNavigateToHomePageState) {
              Navigator.popUntil(context, ((route) => route.isFirst));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeView(userRole: state.userRole)));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoleWidget(
                imageAsset: AppConstants.artistImgPath,
                label: "I'm an Artist",
                onTap: () {
                  roleBloc.add(RoleSelectedBtnClickedEvent(userRole: 'artist'));
                },
              ),
              RoleWidget(
                imageAsset: AppConstants.directorImgPath,
                label: "I'm a Director",
                onTap: () {
                  roleBloc
                      .add(RoleSelectedBtnClickedEvent(userRole: 'director'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
