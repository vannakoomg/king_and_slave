class RoomModel {
  String? id;
  String? name;
  String? password;
  int? type;
  King? king;
  King? slave;
  String? createDate;
  String? chatId;
  RoomModel(
      {this.id,
      this.name,
      this.password,
      this.type,
      this.king,
      this.slave,
      this.createDate,
      this.chatId});

  RoomModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    id = json['id'];
    name = json['name'];
    createDate = json['createDate'];
    password = json['password'];
    type = json['type'];
    king = json['king'] != null ? King.fromJson(json['king']) : null;
    slave = json['slave'] != null ? King.fromJson(json['slave']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['id'] = id;
    data['createDate'] = createDate;
    data['name'] = name;
    data['password'] = password;
    data['type'] = type;
    if (king != null) {
      data['king'] = king!.toJson();
    }
    if (slave != null) {
      data['slave'] = slave!.toJson();
    }
    return data;
  }
}

class King {
  Cardmodel? card;
  ProfileModel? profile;
  int? index;
  int? length;
  bool? turn;
  String? status;

  King(
      {this.card,
      this.index,
      this.length,
      this.turn,
      this.status,
      this.profile});

  King.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? Cardmodel.fromJson(json['card']) : null;
    profile =
        json['profile'] != null ? ProfileModel.fromJson(json['profile']) : null;
    index = json['index'];
    length = json['length'];
    turn = json['turn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (card != null) {
      data['card'] = card!.toJson();
    }
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['index'] = index;
    data['length'] = length;
    data['turn'] = turn;
    data['status'] = status;
    return data;
  }
}

class Cardmodel {
  String? image;
  String? name;

  Cardmodel({this.image, this.name});

  Cardmodel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
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
