import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_look/pages/produk/cubit/produk_cubit.dart';
import 'package:my_look/pages/widgets/customcontainerdashboard.dart';
import '../../models/produk/produk_models.dart';
import '../utils/color.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenPrimary,
        centerTitle: true,
        title: Text(
          'MY LOOK REKOMENDASI FASHION',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
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

            return RefreshIndicator(
              onRefresh: () async {
                final produkCubit = context.read<ProdukCubit>();
                await produkCubit.fetchDataProduk();
              },
              child: ListView.builder(
                physics:
                    AlwaysScrollableScrollPhysics(), // Membuat list selalu bisa ditarik ke atas
                itemCount: combinedProducts.length,
                itemBuilder: (context, index) {
                  Produk product = combinedProducts[index];
                  return CustomContainerDashboard(produk: product);
                },
              ),
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
