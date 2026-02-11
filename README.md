# meowAPI
![Баннер](https://github.com/Davidka4444/meowAPI/blob/main/banner.jpg?raw=true)
Библиотека для Lua, которая позволяет использовать API [meow.camera](https://meow.camera) 😺

Зависимости:
  
  [LuaSocket](https://github.com/lunarmodules/luasocket)
  
  [Cjson](https://github.com/mpx/lua-cjson)

Функции:

  `meowAPI.getRandom()` - Возвращает случайные кормушки в которых есть котики

  `meowAPI.getFeatured()` - Возвращает популярные кормушки

  `meowAPI.getInfo(target)` - Получает информацию о кормушке (target - цифровой ID кормушки)

  `meowAPI.getImg(target)` - Получает превью кормушки (target - информация о кормушке, полученная через `meowAPI.getInfo(target)`)



  [Пример скрипта](https://github.com/Davidka4444/meowAPI/blob/main/example.lua)
