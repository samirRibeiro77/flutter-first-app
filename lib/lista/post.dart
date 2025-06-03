class Post {
  late int _userId, _id;
  late String _title, _body;

  Post(this._userId, this._id, this._title, this._body);

  Post.fromJson(Map<String, dynamic> json){
    _userId = json["userId"];
    _id = json["id"];
    _title = json["title"];
    _body = json["body"];
  }

  get body => _body;

  String get title => _title;

  get id => _id;

  int get userId => _userId;

  @override
  String toString() {
    return "UserId: $_userId // Id: $_id // Title: $_title // Body: $_body";
  }
}