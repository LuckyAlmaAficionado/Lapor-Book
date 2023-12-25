import 'package:cloud_firestore/cloud_firestore.dart';

class Laporan {
  final String uid;
  final String docId;

  final String judul;
  final String instansi;
  String? deskripsi;
  String? gambar;
  final String nama;
  final String status;
  final DateTime tanggal;
  final String maps;
  List<Komentar>? komentar;

  Laporan({
    required this.uid,
    required this.docId,
    required this.judul,
    required this.instansi,
    this.deskripsi,
    this.gambar,
    required this.nama,
    required this.status,
    required this.tanggal,
    required this.maps,
    this.komentar,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) => Laporan(
        uid: json['uid'],
        docId: json['docId'],
        judul: json['judul'],
        instansi: json['instansi'],
        nama: json['nama'],
        status: json['status'],
        tanggal: (json['tanggal'] as Timestamp).toDate(),
        maps: json['maps'],
        gambar: json['gambar'],
        komentar: json['komentar'] != null
            ? (json['komentar'] as List)
                .map((e) => Komentar.fromJson(e))
                .toList()
            : [],
        deskripsi: json['deskripsi'],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "docId": docId,
        "judul": judul,
        "instansi": instansi,
        "nama": nama,
        "status": status,
        "tanggal": tanggal,
        "maps": maps,
        "komentar": komentar,
        "gambar": gambar,
        "deskripsi": deskripsi,
      };
}

class Komentar {
  final String nama;
  final String isi;

  Komentar({
    required this.nama,
    required this.isi,
  });

  factory Komentar.fromJson(Map<String, dynamic> json) => Komentar(
        nama: json['nama'],
        isi: json['isi'],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "isi": isi,
      };
}

enum Status { Posted, Process, Done }
