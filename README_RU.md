# Ультимативный органайзер для игры Дюна: Империя

[English version](README.md)

Предназначен для хранения базовой игры с дополнениями "Расцвет Иксианцев" и "Бессмертие" а так же множества фанатских дополнений.

## Модули и их расположение в органайзере

### Базовая игра

1. Фишки игроков и стартовые карты кладутся в коробку игрока
2. Карты империи кладутся в коробку карт империи, которая может использоваться во время игры
3. Карты интриги кладутся в коробку карт интриги, которая может использоваться во время игры
4. Жетоны союзов, фишка ментата и жетоны барона кладутся в коробку "Setup"
5. Карты дома Хагаль кладутся в лоток "Hagal", который может использоваться во время игры
6. Карты конфликта кладутся в лоток "Conflict".
7. Карты "Пряность должна поступать", "Свернутое пространство" и "Связные Арракиса" кладутся в соответствубщие отделения тройного лотка для постоянныз карт рынка.

## Расцвет Иксианцев

1. Дополнительные фишки и стартовые карты кладутся в коробки игроков
2. Дополнительные карты империи и интриг кладутся в соответствующие коробки и отделяются разделителем "Ix"
3. Жетоны технологий кладутся в лоток "Ix tech", который может использоваться на игровом поле

## Бессмертие

1. Дополнительные фишки и стартовые карты кладутся в коробки игроков
2. Дополнительные карты империи и интриг кладутся в соответствующие коробки и отделяются разделителем "Im"
3. Карты рынка Тлейлаксу и жетон "Научная станция" кладутся в лоток "Tleilaxu market", который сожет быть использован во время игры

### Пятый игрок
Может использоваться в нескольких модулях. Кладется в отдельную коробочку как и основные игроки.

### M1: Фракции аутсайдеры 

Ориг. [Community expansion](https://boardgamegeek.com/thread/2589878/dune-imperium-community-expansion)

1. Поле клажется поверх основного поля
2. Карты кладутся в коробку с картами империи и отделяются разделителем M1
3. Карты интриги кладутся в коробку с картами интриг и отделяются разделителем M1
4. Замены стартовых карт кладутся в коробочки игроков
5. Дополнительные кубики кладутся в коробочки игроков в отдел Flags
6. Фишка искаженного ментата, жетоны союза фракций и жетоны барона кладутся в коробочку setup


### M2: Дипломатия войны

Ориг. [5p variant](https://boardgamegeek.com/thread/2935395/5p-variant-v2/page/1)

1. Жетоны ячеек кладутся в коробку с картами империи и отделяются разделителем M2
2. Сюда же можно положить жетон гарнизона для 5-го игрока

### M3: Выдающиеся лидеры 
Несколько оригинальных источников

1. Планшеты лидеров кладутся в коробку с планшетами лидеров.
2. Для планшетов лидеров с проеткторами 100 микрон предусмотрена коробочка без дна, т.к. не хватало места. В случае отсутствия протекторов возможно использование нормальной версии коробочки.


### M4: Власть и коварство
Ориг. [Chausumea](https://boardgamegeek.com/thread/2726109/di-expansion-chausumea)

1. Стартовые карты кладутся в коробочки игроков
2. Карты империи кладутся в коробку карт империи и отделяются разделителем M4
3. Карта "Вызов в Ландсраад" (Forgiving argument) кладется в лоток "Forgiving argument"

### M5: Донесения из арракина 

Ориг. [Arrakeen scouts](https://boardgamegeek.com/filepage/230587/arrakeen-scout-mode-card-conversion)

1. Карты событий, сделок итп. кладутся в коробочку Events
2. Жетоный раундов кладутся в отделение "Round tokens" в лотке для жетонов раунда и пророчеств.

### M6: Комитеты высшего совета

Ориг. [Subcommitties card deck variant](https://boardgamegeek.com/filepage/277259/subcommitties-card-deck-variant)

1. Жетоны комитетов кладутся в лоток "Committee"

### M7: Исполнение пророчеств

1. Карты пророчеств кладутся в отделение "Prophecies" в лотке для жетонов раунда и пророчеств.

### M8: Погода на Арракисе
1. Жетоны запрета добычи кладутся в отделение WEATHER в лотке для карт погоды и конфликта
2. Карты погоды кладутся в отделение WEATHER поверх жетонов

### M9: Опасная пряность

Ориг. [Spice Cards: New Card Deck for Making Spice Harvesting Dangerous ](https://boardgamegeek.com/filepage/221389/spice-cards-new-card-deck-for-making-spice-harvest)
1. Карты пряности кладуся в лоток "Spice harvest"

### Отрывной блокнот

Кладется куда-нибудь

### Жетон Шаи Хулуда

1. Жетон червя кладется в коробку для карт империи.

## Сборка

Для сборки используется make-like тул [oak-build](https://github.com/kirillsulim/oak-build).

```sh
oak build
```

.stl файлы будут в `./build` директории.

Однако есть ошибка разделения некоторых лотков, из-за чего они разбиваются на несколько частей. 
Поэтому рекомендуется ручной импорт из OpenSCAD для проблемных компонентов.

## Благодарности

В этом проекте используются:

1. Библиотека OpenSCAD [The-Boardgame-Insert-Toolkit](https://github.com/dppdppd/The-Boardgame-Insert-Toolkit).
2. Шрифт [Dune Rise](https://fontmeme.com/fonts/dune-rise-font/ )
