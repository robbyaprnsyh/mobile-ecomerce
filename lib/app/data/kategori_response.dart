class KategoriResponse {
  bool? success;
  List<DataKategori>? data;

  KategoriResponse({this.success, this.data});

  KategoriResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataKategori>[];
      json['data'].forEach((v) {
        data!.add(DataKategori.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataKategori {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  DataKategori({this.id, this.name, this.createdAt, this.updatedAt});

  DataKategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
