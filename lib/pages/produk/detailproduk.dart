import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/produk/produk_models.dart';
import '../../utils/color.dart';

class ProdukDetailPage extends StatelessWidget {
  final Produk produk;

  ProdukDetailPage({required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenPrimary,
        centerTitle: true,
        title: Text('Detail Produk',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(produk.gambarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              produk.nama,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              produk.kategori,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              produk.deskripsi,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
