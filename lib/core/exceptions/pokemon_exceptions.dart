/// Exceção base para erros relacionados a Pokémon.
///
/// Esta classe serve como base para todas as exceções específicas do domínio Pokémon.
abstract class PokemonException implements Exception {
  /// Mensagem descritiva do erro.
  final String message;

  /// Código de erro opcional para identificação.
  final String? errorCode;

  /// Dados adicionais relacionados ao erro.
  final Map<String, dynamic>? details;

  const PokemonException(this.message, {this.errorCode, this.details});

  @override
  String toString() => 'PokemonException: $message';
}

/// Exceção lançada quando há problemas de conectividade de rede.
class NetworkException extends PokemonException {
  const NetworkException(super.message, {super.errorCode, super.details});

  @override
  String toString() => 'NetworkException: $message';
}

/// Exceção lançada quando há problemas com a API.
class ApiException extends PokemonException {
  /// Código de status HTTP da resposta.
  final int? statusCode;

  const ApiException(
    super.message, {
    super.errorCode,
    this.statusCode,
    super.details,
  });

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Exceção lançada quando há problemas com o armazenamento local.
class StorageException extends PokemonException {
  const StorageException(super.message, {super.errorCode, super.details});

  @override
  String toString() => 'StorageException: $message';
}

/// Exceção lançada quando há problemas de parsing de dados.
class DataParsingException extends PokemonException {
  /// Dados que falharam no parsing.
  final dynamic rawData;

  const DataParsingException(
    super.message, {
    super.errorCode,
    this.rawData,
    super.details,
  });

  @override
  String toString() => 'DataParsingException: $message';
}

/// Exceção lançada quando um Pokémon não é encontrado.
class PokemonNotFoundException extends PokemonException {
  /// ID do Pokémon que não foi encontrado.
  final int? pokemonId;

  const PokemonNotFoundException(
    super.message, {
    super.errorCode,
    this.pokemonId,
    super.details,
  });

  @override
  String toString() =>
      'PokemonNotFoundException: $message${pokemonId != null ? ' (ID: $pokemonId)' : ''}';
}

/// Exceção lançada quando há timeout em operações.
class TimeoutException extends PokemonException {
  /// Duração do timeout que foi excedida.
  final Duration? timeout;

  const TimeoutException(
    super.message, {
    super.errorCode,
    this.timeout,
    super.details,
  });

  @override
  String toString() =>
      'TimeoutException: $message${timeout != null ? ' (Timeout: ${timeout!.inSeconds}s)' : ''}';
}
