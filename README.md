# 📱 Flutter Pokédex

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)

**Aplicativo mobile de Pokédex criado com Flutter**, inspirado em um design gratuito da comunidade **Figma** e consumindo dados em tempo real da **PokeAPI**.

[Sobre](#-sobre-o-projeto) • [Recursos](#-recursos) • [Instalação](#-instalação) • [Uso](#-como-usar) • [Arquitetura](#-arquitetura) • [Contribuição](#-contribuição)

</div>

---

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Recursos](#-recursos)
- [Screenshots](#-screenshots)
- [Tecnologias](#-tecnologias-utilizadas)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Como Usar](#-como-usar)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Arquitetura](#-arquitetura)
- [API](#-api-e-cache)
- [Testes](#-testes)
- [Roadmap](#-roadmap)
- [Contribuição](#-contribuição)
- [Licença](#-licença)
- [Créditos](#-créditos)

---

## 🚀 Sobre o Projeto

O **Flutter Pokédex** é uma enciclopédia digital de Pokémon completa e moderna, oferecendo uma experiência rica e interativa para explorar o mundo Pokémon.

### ✨ Principais Diferenciais

- **🔄 Funciona Offline** - Cache inteligente para uso sem internet
- **🎨 Design Moderno** - Interface inspirada em designs profissionais
- **⚡ Performance Otimizada** - Carregamento rápido e navegação fluida
- **📱 Responsivo** - Adaptado para diferentes tamanhos de tela
- **🏗️ Arquitetura Limpa** - Código organizado e escalável

---

## � Recursos

### � Exploração de Pokémons
- ✅ **Lista completa** de todos os Pokémons disponíveis
- ✅ **Busca inteligente** por nome ou número
- ✅ **Filtros avançados** por tipo, geração, etc.
- ✅ **Ordenação customizável** (número, nome, tipo)

### � Informações Detalhadas
- ✅ **Estatísticas completas** (HP, Ataque, Defesa, etc.)
- ✅ **Tipos e fraquezas** de cada Pokémon
- ✅ **Altura e peso** com visualizações comparativas
- ✅ **Lista de movimentos** e habilidades
- ✅ **Descrições oficiais** da Pokédex

### 🎨 Interface e Experiência
- ✅ **Tema dinâmico** baseado no tipo do Pokémon
- ✅ **Animações fluidas** e transições suaves
- ✅ **Imagens de alta qualidade** carregadas dinamicamente
- ✅ **Design responsivo** para tablets e smartphones

---

## � Screenshots

<div align="center">

| Home Screen | Pokemon Details | Search Results |
|-------------|----------------|----------------|
| ![Home](docs/screenshots/home.png) | ![Details](docs/screenshots/details.png) | ![Search](docs/screenshots/search.png) |

*Screenshots serão adicionadas em breve*

</div>

---

## 🛠️ Tecnologias Utilizadas

### 📱 Frontend
- **[Flutter](https://flutter.dev/)** - Framework multiplataforma
- **[Dart](https://dart.dev/)** - Linguagem de programação

### 🌐 Backend/API
- **[PokeAPI](https://pokeapi.co/)** - API oficial de dados Pokémon
- **[HTTP Package](https://pub.dev/packages/http)** - Cliente HTTP para Dart

### 💾 Armazenamento
- **[SharedPreferences](https://pub.dev/packages/shared_preferences)** - Cache local persistente

### 🏗️ Arquitetura
- **[GetIt](https://pub.dev/packages/get_it)** - Injeção de dependências
- **Clean Architecture** - Separação de responsabilidades
- **MVVM Pattern** - Padrão de apresentação

---

## 📦 Dependências Principais

| Pacote | Versão | Descrição |
|--------|--------|-----------|
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) | ^5.9.3 | 📐 Responsividade adaptativa de layout |
| [flutter_svg](https://pub.dev/packages/flutter_svg) | ^2.1.0 | 🎨 Renderização de arquivos SVG |
| [http](https://pub.dev/packages/http) | ^1.4.0 | 🌐 Requisições HTTP para APIs |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | ^3.4.1 | 🖼️ Cache inteligente de imagens |
| [get_it](https://pub.dev/packages/get_it) | ^8.0.3 | 💉 Gerenciamento de dependências |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ^2.5.3 | 💾 Armazenamento local de dados |

---

## ⚙️ Pré-requisitos

Antes de começar, certifique-se de ter o ambiente Flutter configurado:

- **Flutter SDK:** `>= 3.10.0`
- **Dart SDK:** `>= 3.0.0`
- **Android Studio/Xcode** (para desenvolvimento mobile)
- **Git** para controle de versão

### 🔧 Verificar Instalação

```bash
flutter doctor
```

---

## 🚀 Instalação

### 1️⃣ Clone o Repositório

```bash
git clone https://github.com/seu-usuario/flutter_pokedex.git
cd flutter_pokedex
```

### 2️⃣ Instale as Dependências

```bash
flutter pub get
```

### 3️⃣ Configure o Ambiente

```bash
# Verifique se tudo está configurado corretamente
flutter doctor

# Execute o projeto
flutter run
```

### 4️⃣ Execute em Plataformas Específicas

```bash
# Android
flutter run -d android

# iOS (apenas em macOS)
flutter run -d ios

# Web (desenvolvimento)
flutter run -d chrome
```

---

## 🎮 Como Usar

### 🏠 Tela Principal
1. **Abra o aplicativo** - A lista de Pokémons será carregada automaticamente
2. **Explore a lista** - Role para ver todos os Pokémons disponíveis
3. **Use a busca** - Digite o nome ou número do Pokémon desejado

### 🔍 Busca e Filtros
- **Buscar por nome:** Digite "Pikachu" na barra de pesquisa
- **Buscar por número:** Digite "#025" ou apenas "25"
- **Filtrar por tipo:** Use os botões de tipo (Fogo, Água, etc.)

### 📊 Detalhes do Pokémon
1. **Toque em um Pokémon** na lista principal
2. **Explore as abas** de informações (Stats, Moves, etc.)
3. **Navegue entre Pokémons** usando os botões de seta

---

## 📁 Estrutura do Projeto

```
lib/
├── 📱 app/                     # Configurações da aplicação
│   ├── config/                 # Configurações gerais e tema
│   └── routes/                 # Definição de rotas
├── 🏗️ core/                    # Núcleo da aplicação
│   ├── constants/              # Constantes globais
│   ├── exceptions/             # Tratamento de erros
│   ├── extensions/             # Extensões utilitárias
│   ├── interfaces/             # Contratos e abstrações
│   └── result/                 # Wrapper para resultados
├── 💾 data/                    # Camada de dados
│   ├── datasources/            # Fontes de dados (API/Local)
│   └── models/                 # Modelos de dados
├── 🎯 domain/                  # Regras de negócio
│   ├── repositories/           # Contratos dos repositórios
│   └── usecases/               # Casos de uso da aplicação
├── 🎨 presentation/            # Interface do usuário
│   ├── home/                   # Tela principal
│   └── pokemon/                # Tela de detalhes
└── 🔧 shared/                  # Componentes compartilhados
    └── widgets/                # Widgets reutilizáveis
```

---

## 🏛️ Arquitetura

O projeto implementa **Clean Architecture** com **padrão MVVM**, garantindo:

### 📐 Princípios Aplicados
- **🔄 Separação de Responsabilidades** - Cada camada tem sua função específica
- **🧪 Testabilidade** - Código facilmente testável
- **🔧 Manutenibilidade** - Fácil de modificar e estender
- **♻️ Reutilização** - Componentes reutilizáveis

### 🏗️ Camadas da Arquitetura

| Camada | Responsabilidade | Exemplo |
|--------|------------------|---------|
| **🎨 Presentation** | Interface do usuário e lógica de apresentação | `home_view_model.dart` |
| **🎯 Domain** | Regras de negócio e contratos | `pokemon_repository.dart` |
| **💾 Data** | Acesso a dados (API/Local) | `pokemon_repository_impl.dart` |
| **🏗️ Core** | Utilitários e configurações base | `app_config.dart` |

---

## 🌐 API e Cache

### 📡 PokeAPI Integration
- **Endpoint Base:** `https://pokeapi.co/api/v2/`
- **Rate Limiting:** Respeitado automaticamente
- **Paginação:** Implementada para listas grandes

### 💾 Sistema de Cache
- **Estratégia:** Cache-first com fallback para API
- **Persistência:** Dados salvos localmente
- **Atualização:** Cache inteligente baseado em timestamp

### 🔄 Fluxo de Dados
```
UI → ViewModel → UseCase → Repository → DataSource → API
                     ↓
                  Cache Local
```

---

## 🧪 Testes

### 🚀 Executar Testes

```bash
# Todos os testes
flutter test

# Testes com coverage
flutter test --coverage

# Testes específicos
flutter test test/unit/
flutter test test/widget/
```

### 📊 Tipos de Teste
- **Unit Tests** - Lógica de negócio e ViewModels
- **Widget Tests** - Componentes da UI
- **Integration Tests** - Fluxos completos da aplicação

---

## 🗺️ Roadmap

### 🔄 Em Desenvolvimento
- [ ] 🌙 **Modo escuro** completo
- [ ] ⭐ **Sistema de favoritos** 
- [ ] 🔔 **Notificações** de novos Pokémons
- [ ] 🎯 **Comparação** entre Pokémons

### 🚀 Próximas Versões
- [ ] 🎮 **Minigames** integrados
- [ ] 📊 **Gráficos avançados** de estatísticas
- [ ] 🌍 **Mapas de regiões** Pokémon
- [ ] 🔊 **Sons e música** dos Pokémons

### 💡 Ideias Futuras
- [ ] 🤖 **Recomendações** com IA
- [ ] 👥 **Perfis de usuário** 
- [ ] 🏆 **Sistema de conquistas**
- [ ] 📱 **App para smartwatch**

---

## 🤝 Contribuição

Contribuições são sempre bem-vindas! Veja como você pode ajudar:

### 🐛 Reportar Bugs
1. Verifique se o bug já foi reportado nas [Issues](../../issues)
2. Crie uma nova issue com detalhes claros
3. Inclua prints e passos para reproduzir

### ✨ Sugerir Melhorias
1. Abra uma issue descrevendo sua sugestão
2. Explique o benefício da mudança
3. Aguarde feedback da comunidade

### 💻 Enviar Código
1. **Fork** este repositório
2. Crie uma **branch** para sua feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. **Push** para a branch (`git push origin feature/AmazingFeature`)
5. Abra um **Pull Request**

### 📋 Guidelines de Código
- Siga as convenções do Dart/Flutter
- Adicione testes para novas funcionalidades
- Mantenha o código bem documentado
- Use commits semânticos (feat, fix, docs, etc.)

---

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

```
MIT License - você pode usar, modificar e distribuir livremente
```

---

## 🎉 Créditos

### 👨‍💻 Desenvolvido com ❤️ por
**[Seu Nome](https://github.com/seu-usuario)**

### 🙏 Agradecimentos Especiais

- 🎨 **Design Original:** [Figma Community - Pokédx Design](https://www.figma.com/community/file/979132880663340794/pokedex)
- 🐱‍👤 **API de Dados:** [PokeAPI](https://pokeapi.co/) - A RESTful Pokémon API
- 🚀 **Flutter Team:** Por criar um framework incrível
- 🎮 **The Pokémon Company:** Por criar este universo fantástico
- 💙 **Comunidade Flutter:** Por todo o suporte e recursos

---

<div align="center">

### 🌟 Se este projeto te ajudou, considere dar uma estrela! ⭐

**[⬆ Voltar ao topo](#-flutter-pokédex)**

---

![Pokedex Flutter](https://media.licdn.com/dms/image/v2/D4D22AQHy8zrpc4vWLQ/feedshare-shrink_2048_1536/B4DZeNQHRDHAAo-/0/1750421502464?e=1753315200&v=beta&t=KwAh_vZff-wqZ5NTJBK8jYkkDu61T4cG3RrcIhJQPik)

**📱 Flutter Pokédx - Gotta Code 'Em All! 🚀**

</div>
