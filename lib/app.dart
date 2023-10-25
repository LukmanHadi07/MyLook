import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_look/pages/auth/login_pages.dart';
import 'package:my_look/pages/dashboard.dart';
import 'package:my_look/pages/produk/admin_dashboard.dart';
import 'package:my_look/pages/auth/cubit/auth_cubit.dart';
import 'package:my_look/pages/produk/cubit/produk_cubit.dart';

import 'package:my_look/pages/produk/tambah_produk.dart';
import 'package:my_look/pages/splashscreeen_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<ProdukCubit>(
            create: (context) => ProdukCubit()..fetchDataProduk()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashscreenPages(),
          '/dashboard': (context) => const Dashboard(),
          '/login': (context) => const Login(),
          '/admin': (context) => const AdminDashboard(),
          '/tambah-produk': (context) => const AddProductScreen(),
          // '/detail-produk': (context) {
          //   final  produk = ModalRoute.of(context)!.settings.arguments as Produk;
          //   return ProdukDetailPage(produk: produk);
          // },
        },
      ),
    );
  }
}
