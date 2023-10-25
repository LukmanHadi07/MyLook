import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_look/models/produk/produk_models.dart';

class ProdukService {
  final CollectionReference produkCollection =
      FirebaseFirestore.instance.collection('produk');

  Future<List<Produk>> getProducts() async {
    try {
      QuerySnapshot snapshot = await produkCollection.get();
      List<Produk> produk =
          snapshot.docs.map((docs) => Produk.fromSnapshot(docs)).toList();
      return produk;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
