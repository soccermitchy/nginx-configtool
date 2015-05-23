--- @author Mitchell Monahan
-- @copyright 2015 Mitchell Monahan
local class = require'middleclass'
local Menu = class("menu")

--- Called when a new menu is created
-- Defaults to no items
-- Defaults to a title of 'Undefined'
-- Called automatically when you do Menu:new()
function Menu:initialize()
	self.items={}
	self.title = 'Undefined'
end

--- Set the title for the menu
-- @param title The name of the menu
-- @usage menu:setTitle("Test Menu")
function Menu:setTitle(title)
	self.title=title
end

--- Add an item to the menu
-- @param name The name of the item, as displayed to the user
-- @param callback_func A function that will be called when the user selects the item
-- @usage menu:addItem("Select Me!",function() print'hi' end
function Menu:addItem(name,callback_func)
	table.insert(self.items,{name=name,callback=callback_func})
	return #self.items
end

--- Display the menu
-- @usage menu:display()
function Menu:display()
	print(self.title)
	print(string.rep('-',15))
	for k,v in ipairs(self.items) do
		print(("[%s] %s"):format(tostring(k),tostring(v)))
	end
	while true do
		print(string.rep('-',15))
		print("Please select which item you would like by typing it's number.")
		io.write('> ')
		n=io.read'*l'
		if self.items[tonumber(n)] do
			return self.items[tonumber(n)].callback()
		end
	end
end
return Menu