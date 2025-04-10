class SubKategori {
  int? id;
  int? kategoriId;
  String? name;
  String? createdAt;
  String? updatedAt;
  Kategori? kategori;

  SubKategori(
      {this.id,
      this.kategoriId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.kategori});

  SubKategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategoriId = json['kategori_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kategori = json['kategori'] != null
        ? new Kategori.fromJson(json['kategori'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kategori_id'] = this.kategoriId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.kategori != null) {
      data['kategori'] = this.kategori!.toJson();
    }
    return data;
  }
}

class Kategori {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Kategori({this.id, this.name, this.createdAt, this.updatedAt});

  Kategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
