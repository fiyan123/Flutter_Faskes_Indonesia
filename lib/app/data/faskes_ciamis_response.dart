class kabCiamisResponse {
  bool? success;
  String? message;
  int? countTotal;
  List<Data>? data;

  kabCiamisResponse({this.success, this.message, this.countTotal, this.data});

  kabCiamisResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    countTotal = json['count_total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count_total'] = this.countTotal;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? kode;
  String? nama;
  String? kota;
  String? provinsi;
  String? alamat;
  String? latitude;
  String? longitude;
  String? telp;
  String? jenisFaskes;
  String? kelasRs;
  String? status;
  List<Detail>? detail;
  String? sourceData;

  Data(
      {this.id,
      this.kode,
      this.nama,
      this.kota,
      this.provinsi,
      this.alamat,
      this.latitude,
      this.longitude,
      this.telp,
      this.jenisFaskes,
      this.kelasRs,
      this.status,
      this.detail,
      this.sourceData});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    kota = json['kota'];
    provinsi = json['provinsi'];
    alamat = json['alamat'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    telp = json['telp'];
    jenisFaskes = json['jenis_faskes'];
    kelasRs = json['kelas_rs'];
    status = json['status'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
    sourceData = json['source_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['nama'] = this.nama;
    data['kota'] = this.kota;
    data['provinsi'] = this.provinsi;
    data['alamat'] = this.alamat;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['telp'] = this.telp;
    data['jenis_faskes'] = this.jenisFaskes;
    data['kelas_rs'] = this.kelasRs;
    data['status'] = this.status;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    data['source_data'] = this.sourceData;
    return data;
  }
}

class Detail {
  int? id;
  String? kode;
  String? batch;
  int? divaksin;
  int? divaksin1;
  int? divaksin2;
  int? batalVaksin;
  int? batalVaksin1;
  int? batalVaksin2;
  int? pendingVaksin;
  int? pendingVaksin1;
  int? pendingVaksin2;
  String? tanggal;

  Detail(
      {this.id,
      this.kode,
      this.batch,
      this.divaksin,
      this.divaksin1,
      this.divaksin2,
      this.batalVaksin,
      this.batalVaksin1,
      this.batalVaksin2,
      this.pendingVaksin,
      this.pendingVaksin1,
      this.pendingVaksin2,
      this.tanggal});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    batch = json['batch'];
    divaksin = json['divaksin'];
    divaksin1 = json['divaksin_1'];
    divaksin2 = json['divaksin_2'];
    batalVaksin = json['batal_vaksin'];
    batalVaksin1 = json['batal_vaksin_1'];
    batalVaksin2 = json['batal_vaksin_2'];
    pendingVaksin = json['pending_vaksin'];
    pendingVaksin1 = json['pending_vaksin_1'];
    pendingVaksin2 = json['pending_vaksin_2'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['batch'] = this.batch;
    data['divaksin'] = this.divaksin;
    data['divaksin_1'] = this.divaksin1;
    data['divaksin_2'] = this.divaksin2;
    data['batal_vaksin'] = this.batalVaksin;
    data['batal_vaksin_1'] = this.batalVaksin1;
    data['batal_vaksin_2'] = this.batalVaksin2;
    data['pending_vaksin'] = this.pendingVaksin;
    data['pending_vaksin_1'] = this.pendingVaksin1;
    data['pending_vaksin_2'] = this.pendingVaksin2;
    data['tanggal'] = this.tanggal;
    return data;
  }
}
