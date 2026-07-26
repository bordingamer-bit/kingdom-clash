# FEATURES.md - Kingdom Clash Features & Architecture

## 🎮 Core Game Features

### 1. Character System
- **8 Base Characters**: Knight, Archer, Mage, Paladin, Rogue, Berserker, Priest, Druid
- **Character Stats**: Health, Attack, Defense, Speed
- **Leveling System**: Experience-based progression
- **Rarity System**: Common → Rare → Epic → Legendary

### 2. Fusion System
Combine any two characters to create a unique third character with:
- **Merged Stats**: Average of parents + random variation (±10)
- **Combined Abilities**: Pool of both parent's abilities
- **New Traits**: Randomly generated passive effects
- **Unique Visuals**: Procedural generation (emoji + symbol)
- **Rarity Upgrade**: Chance to increase rarity tier
- **Name Generation**: Blended parent names

**Example**: Knight + Mage = "Knage" (Hybrid Warrior)

### 3. Trait System (Passive Effects)
Each character can have up to 4 traits:
- **Stat Boosts**: +10% Health, Attack, Defense, Speed
- **Combat Effects**: Critical Hit Chance, Life Steal, Counter Attack
- **Resistances**: Fire, Frost, Poison Resistance (-30% damage)
- **Special**: Evasion, Energy Regeneration

### 4. Ability System
**Types**:
- Physical Attack - Direct damage based on stats
- Magic Attack - Special effects + damage
- Heal - Restore self or ally health
- Buff - Increase team stats
- Debuff - Reduce enemy stats
- Ultimate - High impact, high cooldown

**Mechanics**:
- Energy Cost (10-80 per ability)
- Cooldown Turns (0-3 turns)
- Target Types: Single, Multiple, Self, All
- Special Effects: Burn, Freeze, Poison, Stun

### 5. Battle System
**Turn-Based Combat**:
1. Hero turns in speed order
2. Player selects ability (if energy available)
3. Energy regenerates passively (5 per turn)
4. Damage calculation: (Base * Multiplier * Attacker.Stats) / Defender.Stats
5. Random variance (±10%)
6. Battle ends when all characters of one team defeated

**Victory Condition**: Destroy enemy king (all team defeated = kingdom defeated)

### 6. Kingdom Management
Each player controls a Kingdom with:
- **Health Pool**: Shared damage across battles
- **Character Roster**: Unlimited storage
- **Active Team**: Max 3 characters for battle
- **Gold/Resources**: Earned from victories

---

## 📊 Technical Architecture

### State Management
Using **Provider** pattern:
```
GameProvider
├── playerKingdom
│   ├── activeTeam
│   ├── roster
│   ├── gold
│   └── health
├── enemyKingdom
└── currentBattle
```

### Data Models

#### Character
```dart
Character {
  id: String (UUID)
  name: String
  level: int
  maxHealth: int
  attack: int
  defense: int
  speed: int
  characterClass: String
  customVisual: String (emoji + symbol)
  rarity: CharacterRarity
  traits: List<CharacterTrait>
  abilities: List<Ability>
}
```

#### Ability
```dart
Ability {
  id: String
  name: String
  type: AbilityType
  target: AbilityTarget
  energyCost: int
  baseEffectValue: int
  effectMultiplier: double
  cooldownTurns: int
  specialEffect: String?
}
```

#### CharacterTrait
```dart
CharacterTrait {
  id: String
  name: String
  effect: TraitEffect
  effectValue: double
  isPassive: bool
}
```

#### Battle
```dart
Battle {
  playerTeam: List<Character>
  enemyTeam: List<Character>
  state: BattleState
  currentRound: int
  battleLog: List<BattleAction>
}
```

### UI Structure
```
HomeScreen (IndexedStack)
├── RosterTab
│   └── CharacterCard (Grid)
│       └── CharacterDetailSheet (BottomSheet)
├── FusionTab
│   ├── Select Character 1
│   ├── Select Character 2
│   └── Fuse Button
├── BattleTab
│   ├── KingdomHealthBar (Player)
│   ├── Battle Arena
│   ├── KingdomHealthBar (Enemy)
│   └── Action Buttons
└── SettingsTab
```

---

## 🔧 Implementation Details

### Procedural Generation

#### Character Name Fusion
```dart
String fusedName = name1.substring(0, name1.length~/2) + 
                   name2.substring(name2.length~/2)
// "Knight" + "Mage" = "Knage"
```

#### Visual Generation
```dart
colors = ['🔴', '🔵', '🟢', '⚫', '🟡', '⚪']
symbols = ['⚔️', '🗡️', '🏹', '🔮', '🛡️', '⚡']
visual = colors[random()] + symbols[random()]
// Example: "🔴⚔️", "🟢🔮"
```

#### Rarity Determination
```
Common (Base)   → 40%
Rare (↑1)       → 30%
Epic (↑2)       → 20%
Legendary (↑3)  → 10%
```

### Damage Calculation
```
baseDamage = ability.baseEffectValue
totalDamage = (baseDamage × ability.multiplier × attacker.attack/50) ÷ (defender.defense/50)
finalDamage = totalDamage + variance(-10% to +10%)
actualDamage = max(1, finalDamage - defender.defense/4)
```

### AI Decision Making (Enemy)
1. Get all available abilities (energy check + not on cooldown)
2. Select random ability
3. Calculate damage/effect
4. Execute action
5. Update turn state

---

## 📱 UI/UX Features

### Character Card
- Character visual (emoji + symbol, color-coded by rarity)
- Name, level, class
- Health bar with percentage
- Quick stats (ATK, DEF, SPD, LVL)
- Rarity badge

### Character Detail Sheet
- Full stats display
- Health with progress bar
- All traits with descriptions
- All abilities with costs
- Cooldown status

### Kingdom Health Bar
- Kingdom name
- Health with color gradient
  - Green: > 50%
  - Orange: 25-50%
  - Red: < 25%
- Active team count
- Damage/heal indicators

### Battle Screen
- Player team formation (left side)
- Enemy team formation (right side)
- Active character highlight
- Action buttons for each ability
- Energy bar
- Turn counter
- Battle log (recent actions)

---

## 🚀 Performance Optimization

### Memory
- Reuse Character objects when possible
- Lazy load roster (paginate if > 50 characters)
- Cache computed stats

### Rendering
- IndexedStack for tab navigation (not PageView)
- Const widgets where possible
- ListView/GridView with physics: NeverScrollableScrollPhysics when nested

### Data
- Hive for local persistence
- In-memory cache for active battle
- Minimal JSON serialization

---

## 📋 Future Expansions

### Phase 2: Advanced Features
- [ ] Campaign Mode with story
- [ ] Raid Bosses (cooperative battles)
- [ ] PvP ranked battles
- [ ] Guilds/Alliances
- [ ] Battle Pass system

### Phase 3: Monetization (cosmetic only)
- [ ] Character skins
- [ ] Battle animations
- [ ] Kingdom themes
- [ ] Emote/achievement system

### Phase 4: Community
- [ ] Friend system
- [ ] Leaderboards
- [ ] Replay sharing
- [ ] Tournament mode

---

## 🐛 Known Limitations

1. **AI**: Currently random action selection (upgrade with pathfinding later)
2. **UI**: Temporary placeholder images (replace with actual assets)
3. **Persistence**: Not yet integrated (Hive setup ready)
4. **Animations**: Basic (add flutter_animate later)
5. **Sounds**: Not implemented (add audioplayers)

---

## 📚 Code Quality

### Patterns Used
- **Provider**: State management
- **Factory Pattern**: Character generation
- **Immutability**: Character.copyWith()
- **Composition**: Traits + Abilities on Character

### Best Practices
- Const constructors where possible
- Proper error handling (try-catch in critical paths)
- Type safety (Enums for states)
- Separation of concerns (Models, Widgets, Providers)

---

**Last Updated**: July 26, 2026
**Version**: 1.0.0 MVP
