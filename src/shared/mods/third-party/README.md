# Third-Party extensions
this is just how to setup your third party extension for distribution, the code you do yourself ofc like a regular module you can use Rue's official modules as an example 
## What you need
this should be in your module
```lua
	__RUE_INFO = {
		Creator = "Rue",
		Project = "Rue Project",
		Name = "Styler",
		Version = 1.0,
		Link = "https://github.com/f0nee/Rue/main/src/shared/mods/official/rue-project@styler/",
		Description = [[
			No need for a bunch of .instance in your code, use Styler!
			Styler is indeed limited right now so for now if we dont support anything you want then use object.instance
		]]
	},
```
## How to format your module
folder name: project-name@name-version<br/>
example: rue-project@styler-1.0<br/>
module name should just be "module" so our systems can find your module
## How a user can install your module (AUTOMATED VERSION, FOR MARKETPLACE VERSION LOOK BELOW THIS SECTION)
supply this command line for command bar (NOT TESTED):
```lua
local FOLDER_NAME = "rue-project@styler-1.0"
local RAW_CODE_LINK = "https://raw.githubusercontent.com/f0nee/Rue/refs/heads/main/src/shared/mods/official/rue-project%40styler/module.luau"
game.HttpEnabled = true
local Module = Instance.new("ModuleScript")
Module.Name = "module"
Module.Source = game:GetService("HttpService"):GetAsync(RAW_CODE_LINK)
local Folder = Instance.new("Folder")
Folder.Name = FOLDER_NAME
Folder.Parent = game.ReplicatedStorage.mods["third-party"]
Module.Parent = Folder
```
## How a user can install your module
Follow how to format your module then save the folder as a rbxm then you can distribute the package.<br/>
Devforum or Marketplace :D
## This can be improved
if you wanna rewrite this go ahead i suck :D