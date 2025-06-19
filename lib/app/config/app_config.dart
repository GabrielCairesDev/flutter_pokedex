import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Classe de configuração principal do aplicativo.
///
/// Esta classe define o tamanho base de design responsivo,
/// configura a adaptação de texto e o modo de tela dividida.
/// Também inicializa o `MaterialApp` com as rotas e título definidos.
class AppConfig extends StatelessWidget {
  /// Construtor constante da classe [AppConfig].
  ///
  /// O [key] permite identificar exclusivamente este widget na árvore de widgets.
  const AppConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      /// Define o tamanho base do design usado para a responsividade.
      ///
      /// Neste caso, o tamanho base é de 360x640 pixels,
      /// um tamanho comum de referência para dispositivos móveis.
      designSize: Size(360, 640),

      /// Garante que o texto se adapte proporcionalmente
      /// quando o dispositivo tiver configurações de fonte maiores ou menores.
      minTextAdapt: true,

      /// Permite que o app funcione corretamente em modo de tela dividida
      /// (Split Screen Mode), muito comum em tablets e dispositivos dobráveis.
      splitScreenMode: true,

      /// Construtor que define o widget raiz da aplicação.
      builder: (_, __) {
        return MaterialApp(
          /// Título do aplicativo (usado em alguns dispositivos
          /// para exibição na lista de apps recentes, por exemplo).
          title: 'Pokedex PokeApi',

          /// Rota inicial da aplicação (ponto de entrada da navegação).
          initialRoute: AppRoutes.home,

          /// Mapa de rotas do aplicativo, definindo os caminhos de navegação.
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
