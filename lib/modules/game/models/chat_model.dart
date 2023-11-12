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
  ProfileModel? profile;

  bool? turn;

  Messagelking({this.title, this.turn, this.profile});

  Messagelking.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    turn = json['turn'];
    profile =
        json['profile'] != null ? ProfileModel.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['turn'] = turn;
    return data;
  }
}

class ProfileModel {
  String? avatar;
  String? name;

  ProfileModel({this.avatar, this.name});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['name'] = name;
    return data;
  }
}
