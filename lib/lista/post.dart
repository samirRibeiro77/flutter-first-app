class Post {
  late int _userId;
  late int? id;
  late String _title, _body;

  Post(this._userId, this._title, this._body, {this.id});

  Post.fromJson(Map<String, dynamic> json){
    _userId = json["userId"];
    id = json["id"];
    _title = json["title"];
    _body = json["body"];
  }

  Map toJson() {
    return {
      "userId": _userId,
      "title": _title,
      "body": _body
    };
  }

  get body => _body;

  String get title => _title;

  int get userId => _userId;

  @override
  String toString() {
    return "UserId: $_userId // Id: $id // Title: $_title // Body: $_body";
  }
}