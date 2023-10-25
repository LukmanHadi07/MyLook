import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_look/pages/produk/cubit/produk_cubit.dart';
import 'package:my_look/utils/color.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _namaProdukController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        backgroundColor: greenPrimary,
        title: Text(
          'Tambah Produk',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProdukCubit, ProdukState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _namaProdukController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Produk',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _kategoriController,
                      decoration: const InputDecoration(
                        labelText: 'Kategori Produk',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _deskripsiController,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi Produk',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                    ),
                  ),
                  (imagePath != null)
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(File(imagePath!)),
                              fit: BoxFit.cover,
                            ),
                          ))
                      : Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                  TextButton(
                      onPressed: () async {
                        XFile? file = await getImage();

                        setState(() {
                          imagePath = file?.path;
                        });
                      },
                      child: const Text('Pilih Gambar')),
                  ElevatedButton(
                    onPressed: () async {
                      final produkCubit = context.read<ProdukCubit>();
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const AlertDialog(
                              title: Text('Loading...'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text('Please wait...'),
                                ],
                              )));
                      try {
                        await produkCubit.addProduk(
                          _namaProdukController.text,
                          _deskripsiController.text,
                          _kategoriController.text,
                          File(imagePath!),
                        );
                        Navigator.pop(context);
                        await produkCubit.fetchDataProduk();
                        Navigator.pushReplacementNamed(context, '/admin');
                      } catch (e) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: Text('Simpan gagal: $e'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    )
                                  ],
                                ));
                      }
                    },
                    child: const Text('Simpan Data'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<XFile?> getImage() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}
