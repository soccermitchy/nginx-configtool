local template_dir = '/opt/nginx-cfgtool/templates'
local templates={}
local lfs=require'lfs'
local Menu = require'menu'
print'Loading templates'
for file in lfs.dir(template_dir) do
	if lfs.attributes(template_dir..'/'..file).mode=='file' then
		templates[file]=io.open(template_dir..'/'..file):read'*a'
		print('Loaded: '..file)
	end
end
local function prompt(text)
	print('+'..string.rep('-',#text)..'+')
	print('|'..text..'|')
	print('+'..string.rep('-',#text)..'+')
	io.write('> ')
	return io.read'*l'
end
local function template_func(name)
	local template_name=name
	return function()
		print('Using template '..template_name)
		local vars={}
		local data=templates[template_name]
		for var_name in data:gmatch("%${(.-)}") do
			if not vars[var_name] then
				vars[var_name]=prompt("Enter the value for variable "..var_name)
			end
			data=data:gsub("%${"..var_name.."}",vars[var_name])
		end
		print'-----------------------------'
		print'Resulting data'
		print(data)
	end
end
local main_menu=Menu:new()
main_menu:setTitle('Main Menu')
main_menu:addItem("Use a template",function()
	local template_menu=Menu:new()
	template_menu:setTitle("Templates")
	for k,v in pairs(templates) do
		template_menu:addItem(k,template_func(k))
	end
	template_menu:display()
end)
main_menu:addItem("Quit",function() os.exit() end)
main_menu:display()