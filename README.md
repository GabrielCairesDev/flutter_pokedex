# 📱 Flutter Pokédex

Aplicativo mobile de Pokédex criado com **Flutter**, inspirado em um design gratuito da comunidade **Figma** e consumindo dados em tempo real da **PokeAPI**. O projeto segue os princípios de **Clean Architecture** e **SOLID** para garantir código limpo, testável e manutenível.

---

## ✅ Sobre o Projeto

O **Flutter Pokédex** é uma enciclopédia digital de Pokémon que oferece uma experiência moderna e responsiva.

### 🎯 Funcionalidades Principais

Com ele, o usuário pode:

- **Consultar a lista completa de Pokémons** (atualmente 1025+ espécies)
- **Pesquisar por nome ou número** da Pokédex
- **Ordenar por ID ou nome** alfabeticamente
- **Visualizar detalhes completos** de cada Pokémon:
  - ✨ Tipos e cores correspondentes
  - 📏 Altura e peso
  - ⚔️ Movimentos aprendidos no nível 1
  - 📊 Estatísticas base (HP, Ataque, Defesa, etc.)
  - 📝 Descrição oficial em inglês
- **Navegar entre Pokémons** com botões de próximo/anterior
- **Funcionamento offline** com cache inteligente

### 🎨 Experiência do Usuário

- **Interface responsiva** que se adapta a diferentes tamanhos de tela
- **Estados visuais claros** para loading, erro e lista vazia
- **Recuperação de erros** com botão de retry
- **Feedback visual** adequado para todas as ações
- **Design moderno** com animações suaves

---

## 🏗️ Arquitetura do Projeto

O projeto implementa **Clean Architecture** com **SOLID** principles, alcançando nível **10/10** em qualidade de código:

### 📐 Clean Architecture

```
lib/
├── app/                    # Configuração da aplicação
│   ├── config/            # Configurações gerais
│   └── routes/            # Sistema de navegação
├── core/                  # Camada central
│   ├── interfaces/        # Contratos de infraestrutura
│   ├── exceptions/        # Exceções customizadas
│   ├── result/           # Padrão Result/Either
│   └── constants/        # Constantes da aplicação
├── data/                  # Camada de dados
│   ├── datasources/      # Implementações concretas
│   └── models/           # Modelos de dados
├── domain/               # Camada de domínio
│   ├── repositories/     # Contratos de repositórios
│   └── usecases/        # Casos de uso
├── presentation/         # Camada de apresentação
│   ├── home/            # Tela inicial
│   └── pokemon/         # Tela de detalhes
└── shared/              # Componentes compartilhados
    └── widgets/         # Widgets reutilizáveis
```

### 🔧 Princípios SOLID Implementados

- **SRP (Single Responsibility)**: Cada classe tem uma responsabilidade bem definida
- **OCP (Open/Closed)**: Extensível através de interfaces sem modificar código existente
- **LSP (Liskov Substitution)**: Implementações podem ser substituídas pelas interfaces
- **ISP (Interface Segregation)**: Interfaces específicas e coesas
- **DIP (Dependency Inversion)**: Dependências de abstrações, não implementações

### 🛡️ Tratamento de Erros Robusto

- **Sistema de exceções customizadas** para diferentes tipos de erro
- **Padrão Result/Either** para tratamento funcional de erros
- **Recuperação automática** de falhas de rede
- **Feedback adequado** ao usuário em caso de erro

---

## 🎨 Design de Interface

O layout da Pokédex foi baseado neste projeto gratuito disponível no Figma Community:

🔗 [Figma Design: Pokédex](https://www.figma.com/community/file/979132880663340794/pokedex)

### 🎯 Características do Design

- **Paleta de cores** baseada nos tipos de Pokémon
- **Tipografia consistente** com hierarquia clara
- **Componentes reutilizáveis** para manter consistência
- **Animações suaves** para melhor experiência
- **Layout adaptativo** para diferentes dispositivos

---

## 🌐 Funcionamento Geral

### 📡 Consumo de API (PokeAPI)

O app consome dados diretamente da [PokeAPI](https://pokeapi.co/), que fornece:

- **Número total de Pokémons** disponíveis
- **Dados detalhados** de cada Pokémon
- **Descrições oficiais** em múltiplos idiomas
- **Informações de espécie** e evolução

### 💾 Cache Local Inteligente

Após o primeiro carregamento:

- **Todos os Pokémons são armazenados** localmente usando SharedPreferences
- **Sincronização automática** quando há novos dados disponíveis
- **Funcionamento offline** completo
- **Performance otimizada** para consultas rápidas

### 🔄 Fluxo de Navegação

1. **Abertura do app** → Verificação de cache local
2. **Sincronização** → Download de dados da API se necessário
3. **Listagem** → Exibição dos Pokémons com filtros
4. **Navegação** → Seleção e visualização de detalhes
5. **Cache** → Armazenamento local para uso offline

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia           | Função                              | Versão |
|----------------------|-------------------------------------|---------|
| **Flutter**          | Framework principal de desenvolvimento | 3.8.1+ |
| **Dart**             | Linguagem utilizada                | 3.8.1+ |
| **PokeAPI**          | Fonte oficial dos dados de Pokémon | v2 |
| **SharedPreferences**| Cache local                        | ^2.5.3 |
| **GetIt**            | Injeção de dependências (DI)       | ^8.0.3 |
| **HTTP Package**     | Requisições de API                 | ^1.4.0 |

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

## 🚀 Como Executar o Projeto

### 📋 Pré-requisitos

- Flutter SDK 3.8.1 ou superior
- Dart 3.8.1 ou superior
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

### ⚡ Passos para Execução

1. **Clone o repositório**
   ```bash
   git clone https://github.com/seu-usuario/flutter_pokedex.git
   cd flutter_pokedex
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Execute o projeto**
   ```bash
   flutter run
   ```

### 🔧 Configurações Adicionais

- **Android**: Configurado para API 21+
- **iOS**: Configurado para iOS 11.0+
- **Web**: Suporte completo para PWA

---

## ✅ Créditos

- 🎨 **Design original:**  
[Figma Community - Pokédex Design](https://www.figma.com/community/file/979132880663340794/pokedex)

- 🐱‍👤 **API de Dados:**  
[PokeAPI - https://pokeapi.co/](https://pokeapi.co/)

- 🏗️ **Arquitetura:**  
Clean Architecture + SOLID Principles

---

## 📱 Screenshots

![Pokedex Flutter](https://media.licdn.com/dms/image/v2/D4D22AQHy8zrpc4vWLQ/feedshare-shrink_2048_1536/B4DZeNQHRDHAAo-/0/1750421502464?e=1753315200&v=beta&t=KwAh_vZff-wqZ5NTJBK8jYkkDu61T4cG3RrcIhJQPik)

---