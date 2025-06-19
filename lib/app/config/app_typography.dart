import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Classe responsável por definir a tipografia padrão da aplicação.
///
/// Esta classe centraliza os estilos de texto utilizados ao longo
/// do app, garantindo consistência visual e facilitando a manutenção.
///
/// Os tamanhos de fonte e espaçamentos (line height) usam o `flutter_screenutil`
/// para adaptar-se dinamicamente a diferentes tamanhos de tela.
class AppTypography {
  /// Estilo de texto para **títulos principais** (Headline).
  ///
  /// - Tamanho: 24sp
  /// - Altura de linha proporcional: 24.h / 32.sp
  /// - Peso: Negrito
  TextStyle headline = TextStyle(
    fontSize: 24.sp,
    height: 24.h / 32.sp,
    fontWeight: FontWeight.bold,
  );

  /// Estilo de texto para **subtítulo pequeno** (Subtitle3).
  ///
  /// - Tamanho: 10sp
  /// - Altura de linha: 10.h / 16.sp
  /// - Peso: Negrito
  TextStyle subtitle3 = TextStyle(
    fontSize: 10.sp,
    height: 10.h / 16.sp,
    fontWeight: FontWeight.bold,
  );

  /// Estilo de texto para **subtítulo grande** (Subtitle1).
  ///
  /// - Tamanho: 14sp
  /// - Altura de linha: 14.h / 16.sp
  /// - Peso: Negrito
  TextStyle subtitle1 = TextStyle(
    fontSize: 14.sp,
    height: 14.h / 16.sp,
    fontWeight: FontWeight.bold,
  );

  /// Estilo de texto para **subtítulo médio** (Subtitle2).
  ///
  /// - Tamanho: 12sp
  /// - Altura de linha: 12.h / 16.sp
  /// - Peso: Negrito
  TextStyle subtitle2 = TextStyle(
    fontSize: 12.sp,
    height: 12.h / 16.sp,
    fontWeight: FontWeight.bold,
  );

  /// Estilo de texto para **corpo de texto principal** (Body1).
  ///
  /// - Tamanho: 14sp
  /// - Altura de linha: 14.h / 16.sp
  /// - Peso: Normal
  TextStyle body1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 14.h / 16.sp,
  );

  /// Estilo de texto para **corpo de texto secundário** (Body2).
  ///
  /// - Tamanho: 12sp
  /// - Altura de linha: 12.h / 16.sp
  /// - Peso: Normal
  TextStyle body2 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 12.h / 16.sp,
  );

  /// Estilo de texto para **corpo de texto pequeno** (Body3).
  ///
  /// - Tamanho: 10sp
  /// - Altura de linha: 10.h / 16.sp
  /// - Peso: Normal
  TextStyle body3 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    height: 10.h / 16.sp,
  );

  /// Estilo de texto para **legendas e anotações** (Caption).
  ///
  /// - Tamanho: 8sp
  /// - Altura de linha: 8.h / 12.sp
  /// - Peso: Normal
  TextStyle caption = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.normal,
    height: 8.h / 12.sp,
  );
}
