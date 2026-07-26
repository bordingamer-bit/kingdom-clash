# Kingdom Clash - Mobile Battle Game 🏰⚔️

Um jogo mobile de batalha por turnos com dois reinos medievais, onde você comanda personagens fantasia e pode fundi-los para criar guerreiros mais poderosos.

## 🎮 Características Principais

### 1. **Sistema de Personagens**
- 8 personagens base iniciais (Knight, Archer, Mage, Paladin, Rogue, Berserker, Priest, Druid)
- Sistema de raridade (Common, Rare, Epic, Legendary)
- Estatísticas completas (HP, ATK, DEF, SPD)
- Traços passivos e habilidades especiais

### 2. **Sistema de Fusão**
- Combine dois personagens para criar um novo
- Visuais aleatórios e únicos (emojis+símbolos)
- Habilidades combinadas aleatoriamente
- Traços e estatísticas derivadas dos pais
- Raridade pode aumentar após fusão

### 3. **Sistema de Batalha**
- Turnos alternados entre jogador e inimigo
- Múltiplas habilidades por personagem
- Sistema de energia para usar habilidades
- IA básica para inimigos
- Foco na destruição do rei adversário

### 4. **Gerenciamento de Reino**
- Roster de personagens ilimitado
- Equipe ativa de até 3 personagens
- Saúde do reino compartilhada
- Sistema de ouro/recursos

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                 # Entrada da aplicação
├── theme/
│   └── app_theme.dart       # Temas e cores
├── models/
│   ├── character.dart       # Modelo de personagem
│   ├── ability.dart         # Sistema de habilidades
│   ├── character_trait.dart # Traços e efeitos passivos
│   ├── kingdom.dart         # Modelo de reino
│   ├── battle.dart          # Motor de batalha
│   └── character_factory.dart # Gerador de personagens
├── providers/
│   └── game_provider.dart   # State management com Provider
├── widgets/
│   ├── character_card.dart           # Card visual do personagem
│   ├── kingdom_health_bar.dart       # Barra de saúde do reino
│   └── character_detail_sheet.dart   # Detalhes do personagem
└── screens/
    └── home_screen.dart     # Tela principal com abas
```

## 🚀 Como Rodar

### Requisitos
- Flutter 3.0+
- Dart 3.0+

### Instalação
```bash
# Clonar repositório
git clone https://github.com/bordingamer-bit/kingdom-clash.git
cd kingdom-clash

# Instalar dependências
flutter pub get

# Rodar em modo debug
flutter run
```

### Build para produção
```bash
# Android
flutter build apk

# iOS
flutter build ios
```

## 📦 Dependências Principais

- **Provider** - State management
- **Get** - Navegação e roteamento
- **Hive** - Armazenamento local
- **Flutter Animate** - Animações suaves
- **Google Fonts** - Tipografia medieval

## 🎯 Gameplay

### Início do Jogo
1. Escolha seu reino e personalize
2. Comece com 8 personagens base
3. Crie uma equipe ativa de até 3

### Fusão de Personagens
1. Vá para a aba "Fusion"
2. Selecione dois personagens
3. Confirme a fusão
4. Receba um novo personagem com:
   - Estatísticas combinadas + variação
   - Habilidades dos dois pais
   - Novo visual procedural
   - Possível aumento de raridade

### Batalha
1. Selecione sua equipe ativa
2. Inicie a batalha contra inimigo IA
3. Alterne turnos:
   - Use habilidades (custam energia)
   - Aumente energia passivamente
   - Derrote todos os personagens inimigos
4. Destrua o rei adversário para vencer

## 🎨 Sistema Visual

- **Design Simples**: Uso de emojis e formas geométricas
- **Paleta Medieval**: Ouro, marrom escuro, verde floresta, sangue
- **Raridade Colorida**:
  - Common: Cinza
  - Rare: Azul
  - Epic: Roxo
  - Legendary: Ouro

## 🛠️ Funcionalidades Elaboradas

### 1. **Gerador Procedural de Personagens**
```dart
CharacterFactory.fuseCharacters(char1, char2)
// Gera: nome, visual, habilidades, traços, raridade
```

### 2. **Sistema de Traços Passivos**
- Health Boost, Attack Boost, Defense Boost
- Speed Boost, Crit Chance, Life Steal
- Resistências (Fire, Frost, Poison)
- Evasion, Counter Attack, Energy Regeneration

### 3. **Tipos de Habilidades**
- Physical Attack
- Magic Attack
- Heal
- Buff/Debuff
- Ultimate

### 4. **IA Inteligente**
- Seleção dinâmica de habilidades
- Consideração de energy/cooldown
- Diferentes estratégias por classe

## 📊 Progresso do Desenvolvimento

- [x] Estrutura base do Flutter
- [x] Modelos de dados
- [x] Sistema de fusão
- [x] Motor de batalha básico
- [x] Interface de usuário
- [ ] Salvar e carregar jogo
- [ ] Tutorial/Onboarding
- [ ] Desafios e modos de jogo
- [ ] Ranking online
- [ ] Monetização (cosmética)

## 💡 Próximos Passos

1. Implementar persistência com Hive
2. Adicionar animações de batalha
3. Criar sistema de sons
4. Balancear estatísticas
5. Adicionar mais personagens base
6. Sistema de efeitos especiais

## 📝 Licença

Este projeto está sob licença MIT.

## 👤 Autor

bordingamer-bit

---

**Kingdom Clash** - Onde reinos colidem e reis caem! 🎮⚔️👑
