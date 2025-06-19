/// Classe que centraliza os caminhos dos arquivos de assets (imagens, ícones, etc).
///
/// Esta classe define constantes com os caminhos dos arquivos SVG utilizados no aplicativo.
///
/// Utilizar uma classe como esta ajuda a evitar erros de digitação,
/// facilita a manutenção futura e melhora a organização dos recursos visuais.
///
/// Exemplo de uso:
/// ```dart
/// SvgPicture.asset(AppAssets.pokeball);
/// ```
class AppAssets {
  /// Construtor privado para evitar instanciação.
  AppAssets._();

  static const String pokeball = 'assets/svg/pokeball.svg';
  static const String search = 'assets/svg/search.svg';
  static const String tag = 'assets/svg/tag.svg';
  static const String arrowLeft = 'assets/svg/arrow_left.svg';
  static const String weight = 'assets/svg/weight.svg';
  static const String height = 'assets/svg/height.svg';
}
