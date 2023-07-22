class BoreHoleModel {
  String? name;
  String? boreholeID;
  double? latitude;
  double? longitude;
  String? image;
  String? address;

  BoreHoleModel(
      {this.name,
      this.boreholeID,
      this.latitude,
      this.longitude,
      this.image,
      this.address});

  BoreHoleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    boreholeID = json['borehole-ID'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['borehole-ID'] = this.boreholeID;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    data['address'] = this.address;
    return data;
  }
}
