import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_look/pages/produk/cubit/produk_cubit.dart';
import 'package:my_look/pages/produk/custom_container.dart';

import '../../models/produk/produk_models.dart';
import '../../utils/color.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: greenPrimary,
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/tambah-produk');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: greenPrimary,
        centerTitle: true,
        title: Text('HALAMAN ADMIN REKOMENDASI FASHION',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: Image.asset(
                'assets/images/menu_image.png',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false, // Menonaktifkan ikon back
      ),
      body: BlocBuilder<ProdukCubit, ProdukState>(
        builder: (context, state) {
          if (state is ProdukLoaded) {
            final combinedProducts = [
              ...state.produk,
            ];

            return ListView.builder(
              itemCount: combinedProducts.length,
              itemBuilder: (context, index) {
                Produk product = combinedProducts[index];
                return CustomContainer(produk: product);
              },
            );
          } else if (state is ProdukError) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
