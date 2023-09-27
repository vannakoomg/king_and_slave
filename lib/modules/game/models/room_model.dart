class RoomModel {
  String? id;
  String? name;
  String? password;
  int? type;
  King? king;
  King? slave;

  RoomModel(
      {this.id, this.name, this.password, this.type, this.king, this.slave});

  RoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    type = json['type'];
    king = json['king'] != null ? King.fromJson(json['king']) : null;
    slave = json['slave'] != null ? King.fromJson(json['slave']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
  int? index;
  int? length;
  bool? turn;
  String? status;
  King({this.card, this.index, this.length, this.turn, this.status});

  King.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? Cardmodel.fromJson(json['card']) : null;
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
