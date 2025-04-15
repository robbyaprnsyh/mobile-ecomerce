import 'package:ecommerce/app/data/subKategori_response.dart';

class ProdukResponse {
  int? id;
  int? kategoriId;
  int? subKategoriId;
  String? namaProduk;
  String? hpp;
  double? harga;
  int? stok;
  int? diskon;
  String? deskripsi;
  String? createdAt;
  String? updatedAt;
  Kategori? kategori;
  SubKategori? subKategori;
  List<String>? images;

  ProdukResponse({
    this.id,
    this.kategoriId,
    this.subKategoriId,
    this.namaProduk,
    this.hpp,
    this.harga,
    this.stok,
    this.diskon,
    this.deskripsi,
    this.createdAt,
    this.updatedAt,
    this.kategori,
    this.subKategori,
    this.images,
  });

  ProdukResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategoriId = json['kategori_id'];
    subKategoriId = json['sub_kategori_id'];
    namaProduk = json['nama_produk'];
    hpp = json['hpp'];
    harga = json['harga'] != null
        ? double.tryParse(json['harga'].toString())
        : null;
    stok = json['stok'];
    diskon = json['diskon'];
    deskripsi = json['deskripsi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kategori = json['kategori'] != null ? Kategori.fromJson(json['kategori']) : null;
    subKategori = json['sub_kategori'] != null ? SubKategori.fromJson(json['sub_kategori']) : null;
    images = (json['gambar_produk'] as List?)
    ?.map((e) => e is Map && e['url'] != null ? e['url'].toString() : '')
    .where((url) => url.isNotEmpty)
    .toList();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kategori_id'] = kategoriId;
    data['sub_kategori_id'] = subKategoriId;
    data['nama_produk'] = namaProduk;
    data['hpp'] = hpp;
    data['harga'] = harga?.toString();
    data['stok'] = stok;
    data['diskon'] = diskon;
    data['deskripsi'] = deskripsi;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (kategori != null) data['kategori'] = kategori!.toJson();
    if (subKategori != null) data['sub_kategori'] = subKategori!.toJson();
    if (images != null) {
      data['gambar_produk'] = images!.map((e) => {'url': e}).toList();
    }
    return data;
  }
}
