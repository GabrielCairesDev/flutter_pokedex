import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_pokedex/core/interfaces/http_client_interface.dart';
import 'package:flutter_pokedex/core/exceptions/pokemon_exceptions.dart';

/// Implementação concreta da interface [HttpClientInterface] usando o pacote http.
///
/// Esta classe encapsula as operações HTTP usando o cliente http do Dart,
/// fornecendo uma implementação real para injeção de dependência.
class HttpClientImpl implements HttpClientInterface {
  final http.Client _client;

  /// Construtor que recebe um cliente HTTP.
  ///
  /// - [client]: Cliente HTTP a ser usado para as requisições.
  HttpClientImpl({required http.Client client}) : _client = client;

  @override
  Future<http.Response> get(Uri url) async {
    try {
      final response = await _client.get(url);
      return response;
    } on http.ClientException catch (e) {
      throw NetworkException(
        'Erro de conectividade: ${e.message}',
        errorCode: 'NETWORK_ERROR',
        details: {'url': url.toString(), 'originalError': e.toString()},
      );
    } on SocketException catch (e) {
      throw NetworkException(
        'Erro de conexão: ${e.message}',
        errorCode: 'SOCKET_ERROR',
        details: {'url': url.toString(), 'originalError': e.toString()},
      );
    } catch (e) {
      throw NetworkException(
        'Erro inesperado na requisição GET: $e',
        errorCode: 'UNKNOWN_ERROR',
        details: {'url': url.toString(), 'originalError': e.toString()},
      );
    }
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await _client.post(url, headers: headers, body: body);
      return response;
    } on http.ClientException catch (e) {
      throw NetworkException(
        'Erro de conectividade na requisição POST: ${e.message}',
        errorCode: 'NETWORK_ERROR',
        details: {'url': url.toString(), 'originalError': e.toString()},
      );
    } on SocketException catch (e) {
      throw NetworkException(
        'Erro de conexão na requisição POST: ${e.message}',
        errorCode: 'SOCKET_ERROR',
        details: {'url': url.toString(), 'originalError': e.toString()},
      );
    } catch (e) {
      throw NetworkException(
        'Erro inesperado na requisição POST: $e',
        errorCode: 'UNKNOWN_ERROR',
        details: {'url': url.toString(), 'originalError': e.toString()},
      );
    }
  }

  @override
  void close() {
    _client.close();
  }
}
