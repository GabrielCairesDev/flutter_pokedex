import '../exceptions/pokemon_exceptions.dart';

/// Classe que representa o resultado de uma operação que pode ser sucesso ou falha.
///
/// Esta classe implementa o padrão Result/Either, permitindo um tratamento mais
/// elegante e type-safe de operações que podem falhar.
///
/// Exemplo de uso:
/// ```dart
/// Result<List<PokemonModel>> result = await repository.fetchPokemons();
///
/// result.when(
///   success: (pokemons) => print('Pokémons carregados: ${pokemons.length}'),
///   failure: (error) => print('Erro: ${error.message}'),
/// );
/// ```
sealed class Result<T> {
  const Result();

  /// Cria um resultado de sucesso com o valor especificado.
  const factory Result.success(T value) = Success<T>;

  /// Cria um resultado de falha com a exceção especificada.
  const factory Result.failure(PokemonException exception) = Failure<T>;

  /// Verifica se o resultado é um sucesso.
  bool get isSuccess => this is Success<T>;

  /// Verifica se o resultado é uma falha.
  bool get isFailure => this is Failure<T>;

  /// Obtém o valor de sucesso, se disponível.
  T? get value => isSuccess ? (this as Success<T>).value : null;

  /// Obtém a exceção de falha, se disponível.
  PokemonException? get exception =>
      isFailure ? (this as Failure<T>).exception : null;

  /// Executa uma função baseada no tipo do resultado.
  ///
  /// - [success]: Função executada quando o resultado é sucesso.
  /// - [failure]: Função executada quando o resultado é falha.
  R when<R>({
    required R Function(T value) success,
    required R Function(PokemonException exception) failure,
  }) {
    return switch (this) {
      Success<T>(value: final value) => success(value),
      Failure<T>(exception: final exception) => failure(exception),
    };
  }

  /// Mapeia o valor de sucesso para um novo tipo.
  ///
  /// - [mapper]: Função que transforma o valor de sucesso.
  Result<R> map<R>(R Function(T value) mapper) {
    return when(
      success: (value) => Result.success(mapper(value)),
      failure: (exception) => Result.failure(exception),
    );
  }

  /// Mapeia a exceção de falha para um novo tipo.
  ///
  /// - [mapper]: Função que transforma a exceção de falha.
  Result<T> mapError(
    PokemonException Function(PokemonException exception) mapper,
  ) {
    return when(
      success: (value) => Result.success(value),
      failure: (exception) => Result.failure(mapper(exception)),
    );
  }

  /// Executa uma função quando o resultado é sucesso.
  ///
  /// - [onSuccess]: Função executada quando o resultado é sucesso.
  Result<T> onSuccess(void Function(T value) onSuccess) {
    if (isSuccess) {
      onSuccess((this as Success<T>).value);
    }
    return this;
  }

  /// Executa uma função quando o resultado é falha.
  ///
  /// - [onFailure]: Função executada quando o resultado é falha.
  Result<T> onFailure(void Function(PokemonException exception) onFailure) {
    if (isFailure) {
      onFailure((this as Failure<T>).exception);
    }
    return this;
  }

  /// Obtém o valor ou lança a exceção se for falha.
  ///
  /// Use com cuidado, pois pode lançar exceções.
  T getOrThrow() {
    return when(
      success: (value) => value,
      failure: (exception) => throw exception,
    );
  }

  /// Obtém o valor ou retorna um valor padrão se for falha.
  ///
  /// - [defaultValue]: Valor retornado em caso de falha.
  T getOrElse(T defaultValue) {
    return when(success: (value) => value, failure: (_) => defaultValue);
  }
}

/// Classe que representa um resultado de sucesso.
class Success<T> extends Result<T> {
  @override
  final T value;

  const Success(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

/// Classe que representa um resultado de falha.
class Failure<T> extends Result<T> {
  @override
  final PokemonException exception;

  const Failure(this.exception);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          exception == other.exception;

  @override
  int get hashCode => exception.hashCode;

  @override
  String toString() => 'Failure($exception)';
}
