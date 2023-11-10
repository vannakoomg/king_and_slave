class ChatModel {
  Messagelking? messagelking;
  Messagelking? messagelslave;

  ChatModel({this.messagelking, this.messagelslave});

  ChatModel.fromJson(Map<String, dynamic> json) {
    messagelking = json['messagelking'] != null
        ? Messagelking.fromJson(json['messagelking'])
        : null;
    messagelslave = json['messagelslave'] != null
        ? Messagelking.fromJson(json['messagelslave'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messagelking != null) {
      data['messagelking'] = messagelking!.toJson();
    }
    if (messagelslave != null) {
      data['messagelslave'] = messagelslave!.toJson();
    }
    return data;
  }
}

class Messagelking {
  String? title;
  bool? turn;

  Messagelking({this.title, this.turn});

  Messagelking.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    turn = json['turn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['turn'] = turn;
    return data;
  }
}
