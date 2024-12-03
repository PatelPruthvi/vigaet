class VideoModel {
  String? videoLink;
  Details? details;

  VideoModel({this.videoLink, this.details});

  VideoModel.fromJson(Map<String, dynamic> json) {
    videoLink = json['videoLink'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoLink'] = videoLink;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  List<Comments>? comments;
  double? duration;

  Details({this.comments, this.duration});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['duration'] = duration;
    return data;
  }
}

class Comments {
  int? commentId;
  String? commentValue;
  double? videoTimestamp;
  ArtistReply? artistReply;

  Comments(
      {this.commentId,
      this.commentValue,
      this.videoTimestamp,
      this.artistReply});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentValue = json['commentValue'];
    videoTimestamp = json['videoTimestamp'];
    artistReply = json['artistReply'] != null
        ? ArtistReply.fromJson(json['artistReply'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commentValue'] = commentValue;
    data['videoTimestamp'] = videoTimestamp;
    if (artistReply != null) {
      data['artistReply'] = artistReply!.toJson();
    }
    return data;
  }
}

class ArtistReply {
  int? commentId;
  String? commentValue;

  ArtistReply({this.commentId, this.commentValue});

  ArtistReply.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentValue = json['commentValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commentValue'] = commentValue;
    return data;
  }
}
