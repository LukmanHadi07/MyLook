import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_look/pages/produk/cubit/produk_cubit.dart';
import 'package:my_look/pages/produk/detailproduk.dart';

import '../../models/produk/produk_models.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.produk,
  }) : super(key: key);

  final Produk produk;

  @override
  Widget build(BuildContext context) {
    final produkCubit = context.read<ProdukCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 10), // Updated padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10), // Updated spacing
          const Divider(height: 10), // Updated spacing
          FutureBuilder<String>(
            future: loadImageWithDelay(produk.gambarUrl), // Menunggu 2 detik
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Menampilkan indikator loading ketika menunggu
                return Container(
                  width: double.infinity,
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasData) {
                final imagePath = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10), // Updated spacing
                        Text(
                          produk.nama,
                          style: GoogleFonts.poppins(
                            fontSize: 18, // Updated font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          produk.kategori,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          produk.deskripsi,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                        const Divider(height: 10),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await produkCubit.fetchDataProduk();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProdukDetailPage(
                                      produk: produk,
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset(
                                'assets/images/eye.png',
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Konfirmasi'),
                                      content: Text(
                                        'Apakah Anda yakin ingin menghapus produk ini?',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Tidak'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Iya'),
                                          onPressed: () async {
                                            await produkCubit
                                                .deleteProduk(produk.id);
                                            await produkCubit.fetchDataProduk();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Image.asset(
                                'assets/images/delete.png',
                                width: 30,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return SizedBox(); // Tidak ada data
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String> loadImageWithDelay(String url) async {
    await Future.delayed(Duration(seconds: 2)); // Menunggu 2 detik
    return url;
  }
}
