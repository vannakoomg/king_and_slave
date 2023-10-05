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
  String? customize;
  String? law;
  String? lawDetail;
  String? sound;
  String? language;
  String? noLife;
  String? nextDayYouGetX5life;
  String? x5;

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
      this.setting,
      this.customize,
      this.law,
      this.lawDetail,
      this.sound,
      this.language,
      this.noLife,
      this.nextDayYouGetX5life,
      this.x5});

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
    customize = json['customize'];
    law = json['law'];
    lawDetail = json['law_detail'];
    sound = json['sound'];
    language = json['language'];
    noLife = json['no_life'];
    nextDayYouGetX5life = json['next_day_you_get_x5life'];
    x5 = json['x5'];
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
    data['customize'] = customize;
    data['law'] = law;
    data['law_detail'] = lawDetail;
    data['sound'] = sound;
    data['language'] = language;
    data['no_life'] = noLife;
    data['next_day_you_get_x5life'] = nextDayYouGetX5life;
    data['x5'] = x5;
    return data;
  }
}
