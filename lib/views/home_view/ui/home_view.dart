// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaet/views/home_view/bloc/home_bloc.dart';
import 'package:vigaet/views/role_selection_view/ui/role_selection_view.dart';
import 'package:vigaet/widgets/comment_section/ui/comment_section.dart';

class HomeView extends StatefulWidget {
  final String userRole;
  const HomeView({super.key, required this.userRole});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  VoidCallback? listener;
  final HomeBloc homeBloc = HomeBloc();
  // final List<double> _markerPositions = [2.0, 3.5, 4.0, 6.0];
  double currentPosition = 0.00;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.userRole.toUpperCase()}..."),
        actions: [
          IconButton(
              onPressed: () {
                homeBloc.add(HomeLogoutBtnPressedEvent());
              },
              icon: const Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<HomeBloc, HomeState>(
            bloc: homeBloc,
            buildWhen: (previous, current) => current is! HomeActionState,
            listenWhen: (previous, current) => current is HomeActionState,
            builder: (context, state) {
              if (state is! HomeVideoControlUpdatedState) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: const Center(child: CircularProgressIndicator()));
              }
              state.controller.addListener(() {
                if (!homeBloc.isClosed) {
                  timer =
                      Timer.periodic(const Duration(milliseconds: 100), (val) {
                    if (mounted) {
                      setState(() {
                        currentPosition = state
                            .controller.value.position.inSeconds
                            .toDouble();
                      });
                    }
                    if (!homeBloc.isClosed) {
                      homeBloc.add(HomeVideoSeekbarUpdatedEvent());
                      if (state.controller.value.position ==
                          state.controller.value.duration) {
                        currentPosition = 0.0;
                        homeBloc.add(HomeVideoEndedEvent());
                      }
                    }
                  });
                }
              });
              return AspectRatio(
                aspectRatio: state.controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Video player
                    GestureDetector(
                      onTap: () {
                        if (!state.isControlsVisible) {
                          homeBloc.add(HomeVideoClickedEvent());
                        }
                      },
                      onLongPressStart: (details) {
                        state.controller.setPlaybackSpeed(2);
                      },
                      onLongPressEnd: (details) {
                        state.controller.setPlaybackSpeed(1);
                      },
                      child: AspectRatio(
                        aspectRatio: state.controller.value.aspectRatio,
                        child: VideoPlayer(state.controller),
                      ),
                    ),
                    //Slider
                    if (state.isControlsVisible)
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Stack(
                          children: [
                            Slider(
                              allowedInteraction: SliderInteraction.slideThumb,
                              value: state.currentPosition,
                              max: state.duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                homeBloc.add(
                                    HomeVideoSeekPressEvent(position: value));
                              },
                            ),
                            // Markers (Dots)
                            Positioned.fill(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final sliderWidth = constraints.maxWidth;

                                  return Stack(
                                    children: state.markers.map((marker) {
                                      final positionFraction = marker /
                                          state.controller.value.duration
                                              .inSeconds
                                              .toDouble();
                                      final markerOffset =
                                          sliderWidth * positionFraction;

                                      return Positioned(
                                        left: markerOffset -
                                            7.5, // Adjust for marker center alignment
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: const BoxDecoration(
                                            color: Colors.blueAccent,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Play/pause button
                    if (state.isControlsVisible)
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 48,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            homeBloc.add(HomeVideoPlayPauseBtnClickedEvent());
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
            listener: (context, state) {
              if (state is HomeNavigateToRoleActionState) {
                homeBloc.close();
                Navigator.popUntil(context, ((route) => route.isFirst));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RoleSelectionView()));
              }
            },
          ),
          Expanded(
              child: CommentSection(
                  homeBloc: homeBloc,
                  isArtist: widget.userRole == 'artist',
                  currentPosition: currentPosition))
        ],
      ),
    );
  }
}
