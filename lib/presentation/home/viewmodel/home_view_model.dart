import 'package:flutter/material.dart';
import 'package:flutter_pokedex/data/models/pokemon_model.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_local_repository.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:get_it/get_it.dart';

/// ViewModel responsável por gerenciar o estado da tela inicial (Home) da Pokédex.
///
/// Essa classe cuida de toda a lógica por trás da lista de Pokémons,
/// busca de dados, ordenação, seleção de Pokémon e filtros de pesquisa.
///
/// Também integra o padrão de injeção de dependência utilizando o [GetIt],
/// permitindo fácil acesso ao estado da ViewModel de qualquer lugar da aplicação.
class HomeViewModel extends ChangeNotifier {
  /// Controlador para o campo de pesquisa de Pokémons (search bar).
  final searchController = TextEditingController();

  List<PokemonModel> _pokemons = [];
  bool _isLoading = true;

  /// Pokémon atualmente selecionado na interface.
  PokemonModel? selectedPokemon;

  /// Valor atual do grupo de ordenação.
  ///
  /// - 1 → Ordenar por ID.
  /// - 2 → Ordenar por nome.
  int groupValue = 1;

  /// Lista de Pokémons filtrada com base no texto da pesquisa e no tipo de ordenação selecionado.
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

  /// Indica se os dados ainda estão sendo carregados.
  bool get isLoading => _isLoading;

  /// Indica se o Pokémon selecionado é o primeiro da lista filtrada.
  bool get isFirst =>
      selectedPokemon != null && pokemons.indexOf(selectedPokemon!) == 0;

  /// Indica se o Pokémon selecionado é o último da lista filtrada.
  bool get isLast =>
      selectedPokemon != null &&
      pokemons.indexOf(selectedPokemon!) == pokemons.length - 1;

  /// Inicializa a ViewModel, buscando os Pokémons do cache local ou da API.
  ///
  /// Fluxo:
  /// 1. Verifica o total de Pokémons online na API.
  /// 2. Busca o cache local.
  /// 3. Se o cache for insuficiente, faz o download de todos os Pokémons.
  /// 4. Atualiza o cache local.
  Future<void> init() async {
    final PokemonRepository repository = GetIt.I.get<PokemonRepository>();
    final PokemonLocalRepository localRepository = PokemonLocalRepository();

    _registerInGetIt();
    _setLoading(true);

    int totalOnlinePokemons = await repository.fetchPokemonCount();
    List<PokemonModel> cachedPokemons = await localRepository.getAllPokemons();

    if (cachedPokemons.length < totalOnlinePokemons) {
      _pokemons = await repository.fetchAllPokemons(totalOnlinePokemons);
      await localRepository.savePokemons(_pokemons);
    } else {
      _pokemons = cachedPokemons;
    }

    _setLoading(false);
  }

  /// Define o estado de loading e notifica os listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Define o Pokémon selecionado na interface.
  ///
  /// Exemplo:
  /// ```dart
  /// viewModel.selectPokemon(pokemon);
  /// ```
  void selectPokemon(PokemonModel pokemon) {
    selectedPokemon = pokemon;
    notifyListeners();
  }

  /// Avança para o próximo Pokémon na lista filtrada.
  void nextPokemon() {
    final index = pokemons.indexOf(selectedPokemon!);
    if (index < pokemons.length - 1) {
      selectedPokemon = pokemons[index + 1];
      notifyListeners();
    }
  }

  /// Volta para o Pokémon anterior na lista filtrada.
  void previousPokemon() {
    final index = pokemons.indexOf(selectedPokemon!);
    if (index > 0) {
      selectedPokemon = pokemons[index - 1];
      notifyListeners();
    }
  }

  /// Notifica os listeners para reagir a mudanças no campo de pesquisa.
  void searching() => notifyListeners();

  /// Atualiza a opção de ordenação (por ID ou por nome) e notifica os listeners.
  void onChangedRadio(int? value) {
    groupValue = value!;
    notifyListeners();
  }

  /// Faz o registro da ViewModel no [GetIt], caso ainda não esteja registrada.
  void _registerInGetIt() {
    if (!GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.registerSingleton<HomeViewModel>(this);
    }
  }

  @override
  void dispose() {
    if (GetIt.I.isRegistered<HomeViewModel>()) {
      GetIt.I.unregister<HomeViewModel>();
    }
    super.dispose();
  }
}
