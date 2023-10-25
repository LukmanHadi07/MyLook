import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:my_look/services/produkservice.dart';
import '../../../models/produk/produk_models.dart';

part 'produk_state.dart';

class ProdukCubit extends Cubit<ProdukState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ProdukCubit() : super(ProdukInitial());
  final ProdukService produkService = ProdukService();

  // Method add Produk ke database
  Future<String> addProduk(
    String nama,
    String deskripsi,
    String kategori,
    File? imageFile,
  ) async {
    try {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();

      Reference storageRef = FirebaseStorage.instance.ref();
      Reference storageRefImages = storageRef.child('images');
      Reference imageToUpload = storageRefImages.child(fileName);
      UploadTask uploadTask = imageToUpload.putFile(imageFile!);
      TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      // Save product data to Firestore
      await _firestore.collection('produk').add({
        'nama': nama,
        'deskripsi': deskripsi,
        'kategori': kategori,
        'gambarUrl': downloadUrl
      });

      final newProduk = Produk(
        id: '',
        nama: nama,
        deskripsi: deskripsi,
        kategori: kategori,
        gambarUrl: downloadUrl,
      );

      emit(ProdukAdded(newProduk));

      return downloadUrl;
    } catch (e) {
      // Handle error
      emit(ProdukError('Failed to add product'));
      return '';
    }
  }

  // Method Fetch Data Produk
  Future<void> fetchDataProduk() async {
    try {
      // Fetch Produk
      QuerySnapshot productSnapshot =
          await _firestore.collection('produk').get();

      // List Data Produk
      final List<Produk> products = productSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Produk(
            id: doc.id,
            nama: data['nama'],
            deskripsi: data['deskripsi'],
            kategori: data['kategori'],
            gambarUrl: data['gambarUrl']);
      }).toList();
      emit(ProdukLoaded(products));
    } catch (e) {
      emit(ProdukError('Failed to fetch products'));
    }
  }

  Future<void> deleteProduk(String id) async {
    try {
      await _firestore.collection('produk').doc(id).delete();
    } catch (e) {
      print(e);
      emit(ProdukError('Failed to delete product'));
    }
  }
}
