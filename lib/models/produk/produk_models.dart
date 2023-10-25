// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  final String id;
  final String nama;
  final String deskripsi;
  final String kategori;
  final String gambarUrl;
  Produk({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.kategori,
    required this.gambarUrl,
  });

  factory Produk.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Produk(
      id: snapshot.id,
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      kategori: data['kategori'],
      gambarUrl: data['gambarUrl'],
    );
  }
}
