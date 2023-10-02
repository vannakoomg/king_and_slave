class LanguagesModel {
  String? enemySerrender;
  String? king;
  String? letsGo;
  String? next;
  String? ok;
  String? password;
  String? slave;
  String? surrender;
  String? wait;
  String? weEqual;
  String? youLose;
  String? youSurrender;
  String? youWin;
  String? number1;
  String? number2;
  String? number3;
  String? join;
  String? create;
  String? roomName;
  String? wrongPassword;
  String? setting;
  String? customize;
  String? language;
  String? sound;
  String? law;
  String? lawDetail;

  LanguagesModel(
      {this.enemySerrender,
      this.king,
      this.letsGo,
      this.next,
      this.ok,
      this.password,
      this.slave,
      this.surrender,
      this.wait,
      this.weEqual,
      this.youLose,
      this.youSurrender,
      this.youWin,
      this.number1,
      this.number2,
      this.number3,
      this.join,
      this.create,
      this.roomName,
      this.wrongPassword,
      this.setting,
      this.customize,
      this.language,
      this.sound,
      this.law,
      this.lawDetail});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    enemySerrender = json['enemy_serrender'];
    king = json['king'];
    letsGo = json['lets_go'];
    next = json['next'];
    ok = json['ok'];
    password = json['password'];
    slave = json['slave'];
    surrender = json['surrender'];
    wait = json['wait'];
    weEqual = json['we_equal'];
    youLose = json['you_lose'];
    youSurrender = json['you_surrender'];
    youWin = json['you_win'];
    number1 = json['number1'];
    number2 = json['number2'];
    number3 = json['number3'];
    join = json['join'];
    create = json['create'];
    roomName = json['room_name'];
    wrongPassword = json['wrong_password'];
    setting = json['setting'];
    customize = json['customize'];
    language = json['language'];
    sound = json['sound'];
    law = json['law'];
    lawDetail = json['law_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enemy_serrender'] = enemySerrender;
    data['king'] = king;
    data['lets_go'] = letsGo;
    data['next'] = next;
    data['ok'] = ok;
    data['password'] = password;
    data['slave'] = slave;
    data['surrender'] = surrender;
    data['wait'] = wait;
    data['we_equal'] = weEqual;
    data['you_lose'] = youLose;
    data['you_surrender'] = youSurrender;
    data['you_win'] = youWin;
    data['number1'] = number1;
    data['number2'] = number2;
    data['number3'] = number3;
    data['join'] = join;
    data['create'] = create;
    data['room_name'] = roomName;
    data['wrong_password'] = wrongPassword;
    data['setting'] = setting;
    data['customize'] = customize;
    data['language'] = language;
    data['sound'] = sound;
    data['law'] = law;
    data['law_detail'] = lawDetail;
    return data;
  }
}
