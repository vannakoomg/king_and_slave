class RoomModel {
  String? roomName;
  String? password;
  String? roomId;
  String? userId;

  RoomModel({this.roomName, this.password, this.roomId, this.userId});

  RoomModel.fromJson(Map<String, dynamic> json) {
    roomName = json['room_name'];
    password = json['password'];
    roomId = json['room_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_name'] = roomName;
    data['password'] = password;
    data['room_id'] = roomId;
    data['user_id'] = userId;
    return data;
  }
}
