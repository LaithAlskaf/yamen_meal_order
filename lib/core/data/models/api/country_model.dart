class CountryModel {
  String? country;
  String? alpha2;
  String? alpha3;
  int? numeric;
  double? latitude;
  double? longitude;

  CountryModel(
      {this.country,
        this.alpha2,
        this.alpha3,
        this.numeric,
        this.latitude,
        this.longitude});

  CountryModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    alpha2 = json['alpha2'];
    alpha3 = json['alpha3'];
    numeric = json['numeric'];
    latitude = json['latitude'] is double?json['latitude']:double.parse(json['latitude'].toString());
    longitude = json['longitude'] is double?json['longitude']:double.parse(json['longitude'].toString());

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['alpha2'] = this.alpha2;
    data['alpha3'] = this.alpha3;
    data['numeric'] = this.numeric;
    data['latitude'] = this.latitude ;
    data['longitude'] = this.longitude;
    return data;
  }
}