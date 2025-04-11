part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const PROFILE = _Paths.PROFILE;
  static const SUBKATEGORI = _Paths.SUBKATEGORI;
  static const SUB_KATEGORI = _Paths.SUB_KATEGORI;
  static const KATEGORI = _Paths.KATEGORI;
  static const PRODUK = _Paths.PRODUK;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const DASHBOARD = '/dashboard';
  static const PROFILE = '/profile';
  static const SUBKATEGORI = '/subkategori';
  static const SUB_KATEGORI = '/sub-kategori';
  static const KATEGORI = '/kategori';
  static const PRODUK = '/produk';
}
