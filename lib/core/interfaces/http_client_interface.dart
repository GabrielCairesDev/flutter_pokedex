import 'package:http/http.dart' as http;

/// Interface para cliente HTTP seguindo o princípio de inversão de dependência.
///
/// Esta interface abstrai as operações HTTP, permitindo que diferentes implementações
/// sejam injetadas (como para testes ou diferentes bibliotecas HTTP).
abstract class HttpClientInterface {
  /// Realiza uma requisição GET para a URL especificada.
  ///
  /// - [url]: URI da requisição.
  /// - Retorna uma [Future<http.Response>] com a resposta da requisição.
  Future<http.Response> get(Uri url);

  /// Realiza uma requisição POST para a URL especificada.
  ///
  /// - [url]: URI da requisição.
  /// - [headers]: Cabeçalhos opcionais da requisição.
  /// - [body]: Corpo da requisição opcional.
  /// - Retorna uma [Future<http.Response>] com a resposta da requisição.
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  });

  /// Fecha o cliente HTTP e libera recursos.
  void close();
}
