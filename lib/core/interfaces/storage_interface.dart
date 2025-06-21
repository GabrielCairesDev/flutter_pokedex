/// Interface para operações de armazenamento local seguindo o princípio de inversão de dependência.
///
/// Esta interface abstrai as operações de persistência local, permitindo que diferentes
/// implementações sejam injetadas (como SharedPreferences, Hive, SQLite, etc.).
abstract class StorageInterface {
  /// Salva uma string no armazenamento local.
  ///
  /// - [key]: Chave para identificar o valor.
  /// - [value]: Valor a ser salvo.
  /// - Retorna [true] se a operação foi bem-sucedida, [false] caso contrário.
  Future<bool> setString(String key, String value);

  /// Recupera uma string do armazenamento local.
  ///
  /// - [key]: Chave do valor a ser recuperado.
  /// - Retorna o valor salvo ou [null] se não encontrado.
  Future<String?> getString(String key);

  /// Remove um valor do armazenamento local.
  ///
  /// - [key]: Chave do valor a ser removido.
  /// - Retorna [true] se a operação foi bem-sucedida, [false] caso contrário.
  Future<bool> remove(String key);

  /// Verifica se existe um valor para a chave especificada.
  ///
  /// - [key]: Chave a ser verificada.
  /// - Retorna [true] se a chave existe, [false] caso contrário.
  Future<bool> containsKey(String key);

  /// Limpa todos os dados do armazenamento local.
  ///
  /// - Retorna [true] se a operação foi bem-sucedida, [false] caso contrário.
  Future<bool> clear();
}
