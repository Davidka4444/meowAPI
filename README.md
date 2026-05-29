# meowAPI
![Баннер](https://github.com/Davidka4444/meowAPI/blob/main/banner.jpg?raw=true)

> **meowAPI** — Lua-библиотека для работы с API [meow.camera](https://meow.camera). Позволяет получать информацию о кормушках для котиков, смотреть прямые трансляции и скачивать превью.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Lua](https://img.shields.io/badge/Lua-5.1%2B-blue)](https://www.lua.org)

---

## Установка

### Зависимости
Убедитесь, что установлены следующие модули Lua:
- [LuaSocket](https://github.com/lunarmodules/luasocket)
- [lua-cjson](https://github.com/mpx/lua-cjson)
- [luasec](https://github.com/brunoos/luasec) (для HTTPS)

### Установка через LuaRocks
```bash
luarocks install luasocket
luarocks install luasec
luarocks install lua-cjson
```

### Подключение
Поместите `meowAPI.lua` в папку с вашим скриптом или в `LUA_PATH`:
```lua
local meowAPI = require("meowAPI")
```

---

## API

### `meowAPI.getRandom()`
Возвращает список случайных кормушек, где сейчас есть котики.

**Возвращает:** `table` — массив объектов кормушек.

<details>
<summary>Пример ответа</summary>

```json
[
  {
    "id": 12345,
    "name": "Кормушка у бабушки",
    "catPresent": true,
    "lightTurnedOn": true,
    "todayFeedCount": 42,
    "subscribeCount": 150,
    "todayShowCount": 1200,
    "stock": {
      "kibble": 80,
      "snack": 15
    },
    "deviceTemperatureCelsius": 24.5,
    "timeZone": "Europe/Moscow",
    "viewers": {
      "local": 3,
      "jiemao": 1,
      "purrrr": 0
    },
    "images": ["https://..."],
    "time": 0.5
  }
]
```

</details>

---

### `meowAPI.getFeatured()`
Возвращает список популярных кормушек.

**Возвращает:** `table` — массив объектов кормушек (структура та же, что и у `getRandom()`).

---

### `meowAPI.getInfo(target)`
Получает подробную информацию о конкретной кормушке по её цифровому ID.

**Параметры:**
- `target` (`number`/`string`) — ID кормушки

**Возвращает:** `table` — объект кормушки с дополнительным полем `url` (прямая ссылка на RTMP-поток).

```lua
local info = meowAPI.getInfo(12345)
print(info.name)          -- Название кормушки
print(info.url)           -- RTMP-ссылка на трансляцию
print(info.catPresent)    -- true/false
```

---

### `meowAPI.getImg(target)`
Получает превью кормушки (JPEG).

**Параметры:**
- `target` (`table`) — объект кормушки, полученный из `meowAPI.getInfo()`

**Возвращает:** `string` — сырые байты JPEG-изображения.

```lua
local info = meowAPI.getInfo(12345)
local img = meowAPI.getImg(info)

local file = io.open("cat.jpg", "w+b")
file:write(img)
file:close()
```

---

## Пример использования

```lua
local meowAPI = require("meowAPI")

-- Получить случайную кормушку
local randomList = meowAPI.getRandom()
local target = randomList[1].id

-- Получить детальную информацию
local info = meowAPI.getInfo(target)

print("Кормушка:", info.name)
print("Температура:", info.deviceTemperatureCelsius, "°C")
print("Котик:", info.catPresent and "есть 🐱" or "нет")
print("Свет:", info.lightTurnedOn and "включён" or "выключен")
print("Зрителей:", info.viewers.local)
print("Корма:", info.stock.kibble)
print("Ссылка на трансляцию:", info.url)

-- Скачать превью
local img = meowAPI.getImg(info)
local file = io.open("preview.jpg", "w+b")
file:write(img)
file:close()
```

Полный пример с CLI-интерфейсом и выводом в VLC смотрите в [`example.lua`](example.lua).

---

## Поля объекта кормушки

| Поле | Тип | Описание |
|------|-----|----------|
| `id` | `number` | Уникальный ID кормушки |
| `name` | `string` | Название кормушки |
| `catPresent` | `boolean` | Есть ли котик |
| `lightTurnedOn` | `boolean` | Включён ли свет |
| `deviceTemperatureCelsius` | `number` | Температура (°C) |
| `todayFeedCount` | `number` | Кормлений сегодня |
| `subscribeCount` | `number` | Подписчиков |
| `todayShowCount` | `number` | Просмотров сегодня |
| `stock.kibble` | `number` | Остаток корма |
| `stock.snack` | `number` | Остаток снеков |
| `viewers.local` | `number` | Зрителей через meow.camera |
| `viewers.jiemao` | `number` | Зрителей через Jiemao |
| `viewers.purrrr` | `number` | Зрителей через Purrrr |
| `timeZone` | `string` | Часовой пояс |
| `images` | `table` | Массив ссылок на превью |
| `url` | `string` | RTMP-ссылка на трансляцию (только в `getInfo`) |
| `time` | `number` | Время выполнения запроса (сек) |

---

## Лицензия

Проект распространяется под лицензией [MIT](LICENSE).

---

## Star History

<a href="https://www.star-history.com/?repos=Davidka4444%2FMeowAPI&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=Davidka4444/MeowAPI&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=Davidka4444/MeowAPI&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=Davidka4444/MeowAPI&type=date&legend=top-left" />
 </picture>
</a>
