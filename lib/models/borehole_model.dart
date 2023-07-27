class BoreHoleModel {
  String? name;
  String? boreholeID;
  double? latitude;
  double? longitude;
  String? waterQuality;
  String? pumpFunctionality;
  String? image;
  String? address;

  BoreHoleModel(
      {this.name,
      this.boreholeID,
      this.latitude,
      this.longitude,
      this.waterQuality,
      this.pumpFunctionality,
      this.image,
      this.address});

  BoreHoleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    boreholeID = json['borehole-ID'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    waterQuality = json['waterQuality'];
    pumpFunctionality = json['pumpFunctionality'];
    image = json['image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['borehole-ID'] = this.boreholeID;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['waterQuality'] = this.waterQuality;
    data['pumpFunctionality'] = this.pumpFunctionality;
    data['image'] = this.image;
    data['address'] = this.address;
    return data;
  }
}
