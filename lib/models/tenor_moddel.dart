// To parse this JSON data, do
//
//     final apIjson = apIjsonFromJson(jsonString);

import 'dart:convert';

ApIjson apIjsonFromJson(String str) => ApIjson.fromJson(json.decode(str));

String apIjsonToJson(ApIjson data) => json.encode(data.toJson());

class ApIjson {
  ApIjson({
    this.results,
    this.next,
  });

  List<Result> results;
  String next;

  factory ApIjson.fromJson(Map<String, dynamic> json) => ApIjson(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "next": next,
      };
}

class Result {
  Result({
    this.id,
    this.title,
    this.h1Title,
    this.media,
    this.bgColor,
    this.created,
    this.itemurl,
    this.url,
    this.tags,
    this.flags,
    this.shares,
    this.hasaudio,
    this.hascaption,
    this.sourceId,
    this.composite,
  });

  String id;
  String title;
  String h1Title;
  List<Map<String, Media>> media;
  String bgColor;
  double created;
  String itemurl;
  String url;
  List<dynamic> tags;
  List<dynamic> flags;
  int shares;
  bool hasaudio;
  bool hascaption;
  String sourceId;
  dynamic composite;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        h1Title: json["h1_title"],
        media: List<Map<String, Media>>.from(json["media"].map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, Media>(k, Media.fromJson(v))))),
        bgColor: json["bg_color"],
        created: json["created"].toDouble(),
        itemurl: json["itemurl"],
        url: json["url"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        flags: List<dynamic>.from(json["flags"].map((x) => x)),
        shares: json["shares"],
        hasaudio: json["hasaudio"],
        hascaption: json["hascaption"],
        sourceId: json["source_id"],
        composite: json["composite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "h1_title": h1Title,
        "media": List<dynamic>.from(media.map((x) => Map.from(x)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "bg_color": bgColor,
        "created": created,
        "itemurl": itemurl,
        "url": url,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "flags": List<dynamic>.from(flags.map((x) => x)),
        "shares": shares,
        "hasaudio": hasaudio,
        "hascaption": hascaption,
        "source_id": sourceId,
        "composite": composite,
      };
}

class Media {
  Media({
    this.size,
    this.preview,
    this.dims,
    this.url,
    this.duration,
  });

  int size;
  String preview;
  List<int> dims;
  String url;
  double duration;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        size: json["size"],
        preview: json["preview"],
        dims: List<int>.from(json["dims"].map((x) => x)),
        url: json["url"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "preview": preview,
        "dims": List<dynamic>.from(dims.map((x) => x)),
        "url": url,
        "duration": duration == null ? null : duration,
      };
}
