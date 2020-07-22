class Audio {
  int id;
  int user;
  int survey_id;
  String createdDate;
  String key;

  Audio({this.id, this.user, this.survey_id, this.key, this.createdDate});

  // Converte um objeto JSON em um objeto Survey
  Audio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    survey_id = json['vehicle'];
    key = json['local'];
    createdDate = json['createdDate'];
  }

  // Converte um objeto Survey em um objeto JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['survey_id'] = this.survey_id;
    data['createdDate'] = this.createdDate;
    data['key']= this.key;
    return data;
  }
}