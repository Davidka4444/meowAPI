# meowAPI
![Баннер](https://github.com/Davidka4444/meowAPI/blob/main/banner.jpg?raw=true)
Библиотека для Lua, которая позволяет использовать API [meow.camera](https://meow.camera "Сайт meow.camera") 😺

Зависимости:
 * [LuaSocket](https://github.com/lunarmodules/luasocket)
 * [Cjson](https://github.com/mpx/lua-cjson)

## Функции
| Функция       | Информация         |
| ------------- |:------------------:|
| `meowAPI.getRandom()`      | Возвращает случайные кормушки в которых есть котики                                                       |
| `meowAPI.getFeatured()`    | Возвращает популярные кормушки                                                                            |
| `meowAPI.getInfo(target)`  | Получает информацию о кормушке (target - цифровой ID кормушки)                                            |
| `meowAPI.getImg(target)`   | Получает превью кормушки (target - информация о кормушке, полученная в `meowAPI.getInfo(target)`)         |

### [Пример скрипта](https://github.com/Davidka4444/meowAPI/blob/main/example.lua "(клик)")

## Star History

<a href="https://www.star-history.com/?repos=Davidka4444%2FMeowAPI&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=Davidka4444/MeowAPI&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=Davidka4444/MeowAPI&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=Davidka4444/MeowAPI&type=date&legend=top-left" />
 </picture>
</a>
