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
  String? introduction;
  String? introductionDetail;
  String? setting;

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
      this.introduction,
      this.introductionDetail,
      this.setting});

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
    introduction = json['introduction'];
    introductionDetail = json['introduction_detail'];
    setting = json['setting'];
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
    data['introduction'] = introduction;
    data['introduction_detail'] = introductionDetail;
    data['setting'] = setting;
    return data;
  }
}
