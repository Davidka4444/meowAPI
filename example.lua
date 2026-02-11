local colors = require("ansicolors")
local meowAPI = require("meowAPI")
math.randomseed(os.time() + os.clock() * 1000000)
math.random()
math.random()

function isArg(targetArg)
	for _, value in ipairs(arg) do
		if string.find(value, "--"..targetArg) then
		return string.gsub(value, "--"..targetArg.."=", "")
	end
end
return false
end

print(colors("%{bright magenta}Davidka's Meow Parser"))

local input = isArg("target")

if not input then
	io.write(colors("%{cyan underline}Введите цифровой ID цели (\"С\" - случайная, \"П\" - случайная из популярных): %{reset green}\n>"))
	input = io.read()
end

local input = string.gsub(input, "/", "")

if input == "с" or input == "С" then
	local random = meowAPI.getRandom()
	input = tostring(random[math.random(1, #random)].id)
	
elseif input == "п" or input == "П" then
	local featured = meowAPI.getFeatured()
	input = tostring(featured[math.random(1, #featured)].id)
end

local target = string.gsub(input, "#", "")

print(colors("%{bright black greenbg}Финальный URL:%{reset} https://api.meow.camera/"..target))
print(colors("%{blue}Загрузка..."))

local info = meowAPI.getInfo(target)

if info.status == "error" then
	error("Неверный ID цели")
end

if isArg("vlc") then
	os.execute('vlc --fullscreen "'..info.url..'" >/dev/null')
else
	print(colors("\n\n%{black redbg}————————————————————Информация————————————————————"))
	print(colors("%{black yellowbg}Кормушка:%{reset bright} "..info.name))
	print(colors("%{black yellowbg}Температура:%{reset bright} "..tostring(info.deviceTemperatureCelsius).."°C"))
	print(colors("%{black yellowbg}Кот:%{reset bright} "..(info.catPresent and "есть" or "нет")))
	print(colors("%{black yellowbg}Свет:%{reset bright} "..(info.lightTurnedOn and "включён" or "выключен")))
	print(colors("%{black yellowbg}Смотрит через сайт:%{reset bright} "..tostring(info.viewers["local"])))
	print(colors("%{black yellowbg}Смотрит через Jiemao:%{reset bright} "..tostring(info.viewers.jiemao)))
	print(colors("%{black yellowbg}Смотрит через Purrrr:%{reset bright} "..tostring(info.viewers.purrrr)))
	print(colors("%{black yellowbg}Кормлений:%{reset bright} "..tostring(info.todayFeedCount)))
	print(colors("%{black yellowbg}Добавлений в избранное:%{reset bright} "..tostring(info.subscribeCount)))
	print(colors("%{black yellowbg}Просмотров:%{reset bright} "..tostring(info.todayShowCount)))
	print(colors("%{black yellowbg}Корма:%{reset bright} "..tostring(info.stock.kibble)))
	print(colors("%{black yellowbg}Снеков:%{reset bright} "..tostring(info.stock.snack)))
	print(colors("%{black yellowbg}Картинка:%{reset bright} "..tostring(info.images[1])))
	print(colors("%{black yellowbg}Ссылка:%{reset bright} ".."https://meow.camera"..target))
	print(colors("%{black yellowbg}Ссылка на поток (можно подключиться через VLC):%{reset bright} "..info.url))
	print(colors("%{black yellowbg}Теоретическое местоположение:%{reset bright} "..string.gsub(tostring(info.timeZone), "/", " или ")))
	print(colors("%{black redbg}——————————————————————————————————————————————————"))
	
	if not isArg("noPic") then
		print(colors("%{blue}Загрузка картинки..."))
		local img = meowAPI.getImg(info)
		local file = io.open("cat.jpg", "w+b")
		file:write(img)
		file:close()
		os.execute("jp2a --colors cat.jpg")
	end
end