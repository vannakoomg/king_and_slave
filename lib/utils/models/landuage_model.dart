class LanguageModel {
  String? create;
  String? introductionDetail;
  String? join;
  String? king;
  String? law;
  String? name;
  String? password;
  String? setting;
  String? slave;
  String? soldier;
  String? surrender;

  LanguageModel(
      {this.create,
      this.introductionDetail,
      this.join,
      this.king,
      this.law,
      this.name,
      this.password,
      this.setting,
      this.slave,
      this.soldier,
      this.surrender});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    create = json['create'];
    introductionDetail = json['introduction_detail'];
    join = json['join'];
    king = json['king'];
    law = json['law'];
    name = json['name'];
    password = json['password'];
    setting = json['setting'];
    slave = json['slave'];
    soldier = json['soldier'];
    surrender = json['surrender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create'] = create;
    data['introduction_detail'] = introductionDetail;
    data['join'] = join;
    data['king'] = king;
    data['law'] = law;
    data['name'] = name;
    data['password'] = password;
    data['setting'] = setting;
    data['slave'] = slave;
    data['soldier'] = soldier;
    data['surrender'] = surrender;
    return data;
  }
}
