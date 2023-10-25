// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'produk_cubit.dart';

@immutable
sealed class ProdukState {}

final class ProdukInitial extends ProdukState {}

final class ProdukLoaded extends ProdukState {
  final List<Produk> produk;

  ProdukLoaded(this.produk);
}

final class ProdukAdded extends ProdukState {
  final Produk produk;
  ProdukAdded(
    this.produk,
  );
}

final class ProdukError extends ProdukState {
  final String error;
  ProdukError(
    this.error,
  );
}
