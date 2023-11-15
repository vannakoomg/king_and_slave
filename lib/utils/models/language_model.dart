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
  String? feedback;
  String? feedbackTitle;
  String? enterFeedback;
  String? thankforFeedback;
  String? tellTrueAnswer;
  String? question;
  String? nickName;
  String? updateProfile;
  String? avatar;
  String? botMessage01;
  String? botMessage02;
  String? botMessage03;
  String? botMessage04;
  String? botMessage051;
  String? botMessage052;
  String? botMessage061;
  String? botMessage062;
  String? botMessage07;
  String? botMessage08;
  String? botMessageReply;
  String? botMessageHi;
  String? introduction02;
  String? introduction01;

  LanguagesModel(
      {this.enemySerrender,
      this.introduction02,
      this.introduction01,
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
      this.x5,
      this.feedback,
      this.feedbackTitle,
      this.enterFeedback,
      this.thankforFeedback,
      this.question,
      this.tellTrueAnswer,
      this.avatar,
      this.nickName,
      this.updateProfile,
      this.botMessage01,
      this.botMessage02,
      this.botMessage03,
      this.botMessage04,
      this.botMessage051,
      this.botMessage052,
      this.botMessage061,
      this.botMessage062,
      this.botMessage07,
      this.botMessage08,
      this.botMessageReply,
      this.botMessageHi});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    introduction02 = json['introduction02'];
    introduction01 = json['introduction01'];

    botMessage01 = json['bot_message01'];
    botMessage02 = json['bot_message02'];
    botMessage03 = json['bot_message03'];
    botMessage04 = json['bot_message04'];
    botMessage051 = json['bot_message05_1'];
    botMessage052 = json['bot_message05_2'];
    botMessage061 = json['bot_message06_1'];
    botMessage062 = json['bot_message06_2'];
    botMessage07 = json['bot_message07'];
    botMessage08 = json['bot_message08'];
    botMessageReply = json['bot_message_reply'];
    botMessageHi = json['bot_message_hi'];
    tellTrueAnswer = json['tell_true_answer'];
    question = json['question'];
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
    feedback = json['feedback'];
    feedbackTitle = json['feedback_title'];
    enterFeedback = json['enter_feedback'];
    thankforFeedback = json['thankfor_feedback'];
    updateProfile = json['update_profile'];
    nickName = json['nickname'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bot_message01'] = botMessage01;
    data['bot_message02'] = botMessage02;
    data['bot_message03'] = botMessage03;
    data['bot_message04'] = botMessage04;
    data['bot_message05_1'] = botMessage051;
    data['bot_message05_2'] = botMessage052;
    data['bot_message06_1'] = botMessage061;
    data['bot_message06_2'] = botMessage062;
    data['bot_message07'] = botMessage07;
    data['bot_message08'] = botMessage08;
    data['bot_message_reply'] = botMessageReply;
    data['introduction02'] = introduction02;
    data['introduction01'] = introduction01;
    data['bot_message_hi'] = botMessageHi;
    data['update_profile'] = updateProfile;
    data['nickname'] = nickName;
    data['avatar'] = avatar;
    data['tell_true_answer'] = tellTrueAnswer;
    data['question'] = question;
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
    data['feedback'] = feedback;
    data['feedback_title'] = feedbackTitle;
    data['enter_feedback'] = enterFeedback;
    data['thankfor_feedback'] = thankforFeedback;
    return data;
  }
}
