part of 'models.dart';

class ApiReturnValue<T> {
  /// sebuah class yang khusus mengurusi return dari sebuah api
  ///
  /// variabel [value] merupakan nilai kembalian dari proses request API
  /// dapat bertipe data sesuai dengan nilai kembalian dari API.
  ///
  /// [message] merupakan pesan dari hasil request api, bisa berupa pesan error
  /// ataupun pesan success.
  ///
  final T? value;
  final String? message;

  ApiReturnValue({this.value, this.message});
}
