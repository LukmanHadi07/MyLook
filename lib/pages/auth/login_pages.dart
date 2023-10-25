import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_look/pages/auth/cubit/auth_cubit.dart';
import 'package:my_look/pages/produk/cubit/produk_cubit.dart';
import 'package:my_look/utils/color.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo_mylook.png',
                    width: 300,
                  ),
                ),
                Center(
                  child: Text(
                    'Login To My Look',
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: greenPrimary),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: MediaQuery.of(context).size.height * 0.1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 44),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: greenPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.account_box,
                                      color: Colors.white),
                                  hintText: 'Email',
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ))),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 44),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: greenPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_clock,
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 44,
                      vertical: MediaQuery.of(context).size.height * 0.05),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: greenPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () async {
                        final authCubit = context.read<AuthCubit>();
                        final produkCubit = context.read<ProdukCubit>();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                                title: Text('Login'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16),
                                    Text('Please wait...'),
                                  ],
                                )));
                        try {
                          if (await authCubit.login(
                            _emailController.text,
                            _passwordController.text,
                          )) {
                            Navigator.pop(context);
                            await produkCubit.fetchDataProduk();
                            Navigator.pushReplacementNamed(context, '/admin');
                          } else {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Login gagal'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('OK'),
                                        )
                                      ],
                                    ));
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Login gagal: $e'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      )
                                    ],
                                  ));
                        }
                      },
                      child: Text('Login',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
