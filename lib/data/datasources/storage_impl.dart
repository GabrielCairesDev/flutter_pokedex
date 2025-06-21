import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_pokedex/core/interfaces/storage_interface.dart';
import 'package:flutter_pokedex/core/exceptions/pokemon_exceptions.dart';

/// Implementação concreta da interface [StorageInterface] usando SharedPreferences.
///
/// Esta classe encapsula as operações de armazenamento local usando SharedPreferences,
/// fornecendo uma implementação real para injeção de dependência.
class StorageImpl implements StorageInterface {
  SharedPreferences? _prefs;

  /// Construtor que inicializa o SharedPreferences.
  StorageImpl();

  /// Inicializa o SharedPreferences.
  ///
  /// Deve ser chamado antes de usar qualquer método da classe.
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      await _ensureInitialized();
      return await _prefs!.setString(key, value);
    } catch (e) {
      throw StorageException(
        'Erro ao salvar string: $e',
        errorCode: 'SET_STRING_ERROR',
        details: {'key': key, 'value': value, 'originalError': e.toString()},
      );
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      await _ensureInitialized();
      return _prefs!.getString(key);
    } catch (e) {
      throw StorageException(
        'Erro ao recuperar string: $e',
        errorCode: 'GET_STRING_ERROR',
        details: {'key': key, 'originalError': e.toString()},
      );
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      await _ensureInitialized();
      return await _prefs!.remove(key);
    } catch (e) {
      throw StorageException(
        'Erro ao remover chave: $e',
        errorCode: 'REMOVE_ERROR',
        details: {'key': key, 'originalError': e.toString()},
      );
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      await _ensureInitialized();
      return _prefs!.containsKey(key);
    } catch (e) {
      throw StorageException(
        'Erro ao verificar chave: $e',
        errorCode: 'CONTAINS_KEY_ERROR',
        details: {'key': key, 'originalError': e.toString()},
      );
    }
  }

  @override
  Future<bool> clear() async {
    try {
      await _ensureInitialized();
      return await _prefs!.clear();
    } catch (e) {
      throw StorageException(
        'Erro ao limpar armazenamento: $e',
        errorCode: 'CLEAR_ERROR',
        details: {'originalError': e.toString()},
      );
    }
  }

  /// Garante que o SharedPreferences foi inicializado.
  Future<void> _ensureInitialized() async {
    if (_prefs == null) {
      await initialize();
    }
  }
}
