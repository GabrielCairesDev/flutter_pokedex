import 'package:flutter/material.dart';

/// Extensão para facilitar a aplicação de opacidade em cores.
///
/// Permite adicionar opacidade a qualquer instância de [Color] de forma fluente,
/// usando uma porcentagem de 0 a 100.
///
/// Exemplo de uso:
/// ```dart
/// Color primaryColorWith50Opacity = AppColors.identityPrimary.o(50);
/// ```
extension ColorOpacity on Color {
  /// Retorna uma nova cor com a opacidade ajustada de acordo com o percentual informado.
  ///
  /// Parâmetros:
  /// - [percent]: Valor de opacidade em percentual (0 a 100).
  ///
  /// Retorna:
  /// - Uma nova instância de [Color] com o alpha correspondente ao percentual.
  ///
  /// Exemplo:
  /// ```dart
  /// Color semiTransparent = Colors.red.o(30); // Red com 30% de opacidade
  /// ```
  Color o(int percent) => withAlpha(((percent / 100) * 255).round());
}
