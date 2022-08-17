class Memo {
  int? id;
  String content;

  Memo({this.id, required this.content});

  factory Memo.fromJson(Map<String, dynamic> json) => Memo(
        id: json["id"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
      };
}
