import 'package:flutter/material.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/usecases/sync_pokemon_cache_usecase.dart';
import 'package:get_it/get_it.dart';

/// ViewModel responsável por controlar o estado da tela inicial da Pokédex.
///
/// - Sincroniza os dados com o cache/local.
/// - Gerencia busca, seleção e navegação entre Pokémons.
/// - Controla ordenação e filtro.
/// - Implementa [ChangeNotifier] para atualização reativa da UI.
class HomeViewModel extends ChangeNotifier {
  /// Caso de uso que sincroniza o cache local com os dados da API.
  final SyncPokemonCacheUseCase _syncPokemonCacheUseCase;

  /// Controlador de texto usado na busca.
  final searchController = TextEditingController();

  /// Pokémon atualmente selecionado (exibido em destaque).
  PokemonModel? selectedPokemon;

  /// Lista completa de Pokémons carregados.
  List<PokemonModel> _pokemons = [];

  /// Indica se os dados estão sendo carregados.
  bool _isLoading = true;

  /// Valor atual do grupo de ordenação (1 = por ID, 2 = por nome).
  int groupValue = 1;

  /// Construtor padrão da ViewModel.
  ///
  /// Recebe o [SyncPokemonCacheUseCase] via injeção de dependência.
  HomeViewModel({required SyncPokemonCacheUseCase syncPokemonCacheUseCase})
    : _syncPokemonCacheUseCase = syncPokemonCacheUseCase;

  /// Retorna se os dados ainda estão carregando.
  bool get isLoading => _isLoading;

  /// Retorna se o Pokémon selecionado é o primeiro da lista filtrada.
  bool get isFirst =>
      selectedPokemon != null && pokemons.indexOf(selectedPokemon!) == 0;

  /// Retorna se o Pokémon selecionado é o último da lista filtrada.
  bool get isLast =>
      selectedPokemon != null &&
      pokemons.indexOf(selectedPokemon!) == pokemons.length - 1;

  /// Retorna a lista de Pokémons, aplicando busca e ordenação.
  List<PokemonModel> get pokemons {
    final searchText = searchController.text.trim().toLowerCase();

    final filtered = searchText.isEmpty
        ? _pokemons
        : _pokemons.where((p) {
            final nameMatches = p.name.toLowerCase().contains(searchText);
            final idMatches = p.id.toString().contains(searchText);
            return nameMatches || idMatches;
          }).toList();

    if (groupValue == 1) {
      filtered.sort((a, b) => a.id.compareTo(b.id));
    } else if (groupValue == 2) {
      filtered.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    }

    return filtered;
  }

  /// Inicializa a ViewModel carregando os dados e registrando no GetIt.
  Future<void> init() async {
    _registerInGetIt();
    _setLoading(true);
    _pokemons = await _syncPokemonCacheUseCase();
    _setLoading(false);
  }

  /// Altera o estado de carregamento e notifica a UI.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Define um Pokémon como selecionado e notifica a UI.
  void selectPokemon(PokemonModel pokemon) {
    selectedPokemon = pokemon;
    notifyListeners();
  }

  /// Avança para o próximo Pokémon da lista filtrada.
  void nextPokemon() {
    final index = pokemons.indexOf(selectedPokemon!);
    if (index < pokemons.length - 1) {
      selectedPokemon = pokemons[index + 1];
      notifyListeners();
    }
  }

  /// Retrocede para o Pokémon anterior na lista filtrada.
  void previousPokemon() {
    final index = pokemons.indexOf(selectedPokemon!);
    if (index > 0) {
      selectedPokemon = pokemons[index - 1];
      notifyListeners();
    }
  }

  /// Notifica a UI quando a busca for atualizada.
  void searching() => notifyListeners();

  /// Atualiza o valor de ordenação da lista e notifica a UI.
  void onChangedRadio(int? value) {
    groupValue = value!;
    notifyListeners();
  }

  /// Registra a instância atual no GetIt (caso ainda não esteja registrada).
  void _registerInGetIt() {
    if (!GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.registerSingleton<HomeViewModel>(this);
    }
  }

  /// Libera os recursos e remove a instância do GetIt.
  @override
  void dispose() {
    if (GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.unregister<HomeViewModel>();
    }
    super.dispose();
  }
}
