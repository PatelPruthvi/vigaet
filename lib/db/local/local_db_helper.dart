import 'package:vigaet/db/local/demo_data.dart';

import '../../models/video_model.dart';

class LocalDbHelper {
  void addComment(String commentValue, double timestamp) {
    VideoModel videoModel = VideoModel.fromJson(videoDetails);

    int newCommentId = videoModel.details?.comments?.length ??
        0 + 1; // Generate unique commentId
    print(newCommentId);
    Comments newComment = Comments(
      commentId: newCommentId,
      commentValue: commentValue,
      videoTimestamp: timestamp,
      artistReply: null, // Optionally add a reply
    );

    videoModel.details?.comments?.add(newComment);

    // Convert the VideoModel back to JSON and update the global variable
    videoDetails = videoModel.toJson();
  }

  void addReply(int commentId, String replyValue) {
    VideoModel videoModel = VideoModel.fromJson(videoDetails);
    Comments? comment = videoModel.details?.comments
        ?.firstWhere((comment) => comment.commentId == commentId);
    if (comment != null) {
      int replyId = comment.artistReply?.commentId ?? 0 + 100;

      ArtistReply newReply = ArtistReply(
        commentId: replyId,
        commentValue: replyValue,
      );

      // Set the artistReply for the comment
      comment.artistReply = newReply;

      // Convert the VideoModel back to JSON and update the global variable
      videoDetails = videoModel.toJson();
    }
  }
}
