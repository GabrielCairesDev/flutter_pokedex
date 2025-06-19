# 📱 Flutter Pokédex

Aplicativo mobile de Pokédex criado com **Flutter**, inspirado em um design gratuito da comunidade **Figma** e consumindo dados em tempo real da **PokeAPI**.

---

## ✅ Sobre o Projeto

O **Flutter Pokédex** é uma enciclopédia digital de Pokémon.

Com ele, o usuário pode:

- Consultar a **lista completa de Pokémons**
- Pesquisar **por nome ou número**
- Visualizar **detalhes completos de cada Pokémon**, como:
  - Tipos
  - Altura
  - Peso
  - Movimentos
  - Descrição

O app oferece uma experiência rápida, fluida e moderna, com interface adaptável a diferentes tamanhos de tela.

---

## 🎨 Design de Interface

O layout da Pokédex foi baseado neste projeto gratuito disponível no Figma Community:

🔗 [Figma Design: Pokédex](https://www.figma.com/community/file/979132880663340794/pokedex)

---

## 🌐 Funcionamento Geral

### 📡 Consumo de API (PokeAPI)

O app consome dados diretamente da [PokeAPI](https://pokeapi.co/), que fornece:

- Número total de Pokémons
- Dados de cada Pokémon
- Descrições e tipos

### 💾 Cache Local (Offline Ready)

Após o primeiro carregamento:

- Todos os Pokémons são armazenados localmente (usando **SharedPreferences**)
- As próximas consultas são feitas a partir do cache
- O app funciona **mesmo sem internet**

### 🔄 Fluxo de Navegação

1. O usuário abre o app
2. O app verifica o cache local
3. Se necessário, baixa dados da API
4. O usuário pode filtrar Pokémons e navegar entre eles
5. Ao abrir um Pokémon, o app exibe os detalhes

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia           | Função                              |
|----------------------|-------------------------------------|
| **Flutter**          | Framework principal de desenvolvimento |
| **Dart**             | Linguagem utilizada                |
| **PokeAPI**          | Fonte oficial dos dados de Pokémon |
| **SharedPreferences**| Cache local                        |
| **GetIt**            | Gerenciamento de dependências (DI) |
| **HTTP Package**     | Requisições de API                 |

---

## 📦 Pacotes Flutter Utilizados

| Pacote | Versão | Função |
|---|---|---|
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) | ^5.9.3 | Responsividade de tela (adaptar layout a diferentes dispositivos) |
| [flutter_svg](https://pub.dev/packages/flutter_svg) | ^2.1.0 | Exibição de imagens SVG (ex: Pokébola, ícones de tipo) |
| [http](https://pub.dev/packages/http) | ^1.4.0 | Comunicação com a PokeAPI |
| [cached_network_image](https://pub.dev/packages/cached_network_image) | ^3.4.1 | Carregamento e cache de imagens online |
| [get_it](https://pub.dev/packages/get_it) | ^8.0.3 | Injeção de dependências (Service Locator) |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ^2.5.3 | Armazenamento local dos dados (cache de Pokémons) |

---

## ✅ Arquitetura do Projeto

O projeto segue uma **arquitetura MVVM simples**, com camadas bem separadas:

| Camada            | Responsabilidade                          |
|-------------------|-------------------------------------------|
| **Models**        | Estruturas de dados (ex: `PokemonModel`) |
| **Datasource**    | Acesso à API ou ao cache local           |
| **Repository**    | Camada intermediária entre Datasource e ViewModel |
| **ViewModel**     | Lógica de tela e controle de estado      |
| **View (UI)**     | Interface visível ao usuário final       |

---


## ✅ Créditos

- 🎨 **Design original:**  
[Figma Community - Pokédex Design](https://www.figma.com/community/file/979132880663340794/pokedex)

- 🐱‍👤 **API de Dados:**  
[PokeAPI - https://pokeapi.co/](https://pokeapi.co/)

---
