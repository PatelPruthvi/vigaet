// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:vigaet/models/video_model.dart';
import 'package:vigaet/views/home_view/bloc/home_bloc.dart';
import 'package:vigaet/widgets/comment_section/bloc/comment_bloc.dart';

import '../../../db/local/local_db_helper.dart';

class CommentSection extends StatefulWidget {
  final bool isArtist;
  final double currentPosition;
  final HomeBloc homeBloc;
  const CommentSection(
      {super.key,
      required this.isArtist,
      required this.currentPosition,
      required this.homeBloc});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  TextEditingController commentController = TextEditingController();
  final CommentBloc commentBloc = CommentBloc();
  final FocusNode focusNode = FocusNode();
  final Map<int, TextEditingController> replyControllers = {};

  @override
  void initState() {
    commentBloc.add(CommentInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments Section'),
      ),
      body: BlocBuilder<CommentBloc, CommentState>(
        bloc: commentBloc,
        builder: (context, state) {
          if (state is! CommentsLoadedSuccessState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.comment.isEmpty) {
            return const Center(
                child: Text('No comments are added in this video'));
          }
          return ListView.builder(
            itemCount: state.comment.length,
            itemBuilder: (context, index) {
              Comments comment = state.comment[index];
              double timestamp = comment.videoTimestamp ?? 0.0;
              String commentValue = comment.commentValue ?? "";
              ArtistReply? artistReply = comment.artistReply;

              return Column(
                children: [
                  const Divider(),
                  ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.amber),
                      child: Image.asset("assets/images/commenter.png"),
                    ),
                    title:
                        Text(widget.isArtist ? 'Director' : 'Director (YOU)'),
                    subtitle: Text('$timestamp $commentValue'),
                  ),
                  artistReply != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Divider(color: Colors.grey.shade800),
                        )
                      : Container(),
                  artistReply != null
                      ? Row(
                          children: [
                            const SizedBox(width: 50),
                            Expanded(
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber),
                                  child:
                                      Image.asset("assets/images/replier.png"),
                                ),
                                title: Text(widget.isArtist
                                    ? 'Artist (YOU)'
                                    : 'Artist'),
                                subtitle: Text(artistReply.commentValue!),
                              ),
                            ),
                          ],
                        )
                      : widget.isArtist
                          ? Row(
                              children: [
                                const SizedBox(width: 60),
                                Expanded(
                                  child: TextField(
                                      controller: replyControllers.putIfAbsent(
                                          comment.commentId!,
                                          () => TextEditingController()),
                                      style: const TextStyle(fontSize: 14)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (replyControllers[comment.commentId]
                                              ?.text
                                              .isNotEmpty ??
                                          false) {
                                        LocalDbHelper().addReply(
                                            comment.commentId!,
                                            replyControllers[comment.commentId]
                                                    ?.text ??
                                                'Nil');
                                        commentBloc.add(CommentInitialEvent());
                                        replyControllers[comment.commentId]
                                            ?.clear();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Reply can not be empty...');
                                      }
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text("Reply"),
                                    ))
                              ],
                            )
                          : Container(
                              height: 0,
                            ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: widget.isArtist
          ? null
          : Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.withOpacity(0.2),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(widget.currentPosition
                        .toDouble()
                        .toStringAsPrecision(2)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        focusNode: focusNode,
                        controller: commentController,
                        cursorColor: Colors.white,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.withOpacity(0.2),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  ),
                  IconButton.filled(
                    color: Colors.black,
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      LocalDbHelper().addComment(
                          commentController.text, widget.currentPosition);
                      focusNode.unfocus();
                      commentController.clear();
                      commentBloc.add(CommentInitialEvent());
                      widget.homeBloc.add(HomeNewCommentAddedEvent(
                          videoTimestamp: widget.currentPosition));
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
    );
  }
}
