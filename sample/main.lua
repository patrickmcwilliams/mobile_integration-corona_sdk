-- Project: Tealium
--
-- Date: 5/12/15
--
-- Version: 1.1
--
-- File name: main.lua
--
-- Code type: SDK Test code
--
-- Author: Corona Labs
-- Modified by: Patrick McWilliams
--
-- Demonstrates: Tealium TMS
--
-- File dependencies: none
--
-- Target devices: iOS, Android
--
--
-- Comments: 
--
--		This sample demonstrates the use of TealiumIQ in Corona. It is a
--		modified flurry example.
--		To use it, you must first create an account with Tealium IQ.
--
--		Build your app for device and install it. When you run it, a view 
--      event will automatically get triggered.
--		If you press a button a link event will be triggered.
--
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- Supports Graphics 2.0
---------------------------------------------------------------------------------------

local widget = require( "widget" )

-- Tealium IQ code
local tealiumAccount = "tealium" -- modify to you settings
local tealiumProfile = "mobile"  -- modify to you settings
local tealiumTarget = "dev"      -- modify to you settings

local tealiumData = {}
local webView = native.newWebView( 0, 0, 1, 1 )

local function tealiumAddData( key, value )
	tealiumData[key] = value
end

local function tealiumRemoveData( keyToRemove )
	local i = 0
	local element = nil
	for key, value in pairs(tealiumData) do
		i = i + 1
		if (key == keyToRemove) then
			element = i
		end
	end
	if (element ~= nil) then
		table.remove(tealiumData, element)
	end
end

function string.urlEncode( str )
   if ( str ) then
      str = string.gsub( str, "\n", "\r\n" )
      str = string.gsub( str, "([^%w ])",
         function (c) return string.format( "%%%02X", string.byte(c) ) end )
      str = string.gsub( str, " ", "+" )
   end
   return str
end

local function tealiumGetData( )
	local dataString = "?"
	for key, value in pairs(tealiumData) do
		dataString = dataString..key:urlEncode()..'='..value:urlEncode()..'&'
	end
	return dataString
end



local function tealiumView( dataAsQueryString )
	local request = 'https://tags.tiqcdn.com/utag/'..tealiumAccount..'/'..tealiumProfile..'/'..tealiumTarget..'/mobile.html?platform=corona&call_type=view&'
	request = request..dataAsQueryString
	print( request )
	webView:request( request )
end

local function tealiumLink( dataAsQueryString )
	local request = 'https://tags.tiqcdn.com/utag/'..tealiumAccount..'/'..tealiumProfile..'/'..tealiumTarget..'/mobile.html?platform=corona&call_type=link&'
	request = request..dataAsQueryString
	print( request )
	webView:request( request )
end
-- END Tealium Code


-- Call view tracking
tealiumAddData('event','page loaded')
local data = tealiumGetData()
tealiumView('') -- call view for page load

local buttonRelease1 = function( event )
	-- Call event tracking 
	tealiumAddData('event','button1 pressed')
	local data = tealiumGetData()
	tealiumLink(data)
	-- When button 1 is pressed, it logs an event called "event1"
	
end

local buttonRelease2 = function( event )
	-- Call event tracking 
	tealiumAddData('event','button2 pressed')
	local data = tealiumGetData()
	tealiumLink(data)
	-- When button 2 is pressed, it logs an event called "event2"
	
end

local buttonRelease3 = function( event )
	-- Call event tracking 
	tealiumAddData('event','button3 pressed')
	local data = tealiumGetData()
	tealiumLink(data)
	-- When button 3 is pressed, it logs an event called "event3"
	
end

-- Create buttons for each event
local button1 = widget.newButton
{
	left = 10,
	top = 40,
	defaultFile = "buttonBlue.png",
	overFile = "buttonBlueOver.png",
	label = "Log Event 1",
	labelColor = 
	{ 
		default = { 1, 1, 1 }, 
		over = { 1, 0, 0 } 
	},
	fontSize = 20,
	font = native.systemFontBold,
	onRelease = buttonRelease1
}

local button2 = widget.newButton
{
	left = 10,
	top = button1.y + 42, 
	defaultFile = "buttonBlue.png",
	overFile = "buttonBlueOver.png",
	label = "Log Event 2",
	labelColor = 
	{ 
		default = { 1, 1, 1 }, 
		over = { 1, 0, 0 } 
	},
	fontSize = 20,
	font = native.systemFontBold,
	onRelease = buttonRelease2
}

local button3 = widget.newButton
{
	left = 10,
	top = button2.y + 42, 
	defaultFile = "buttonBlue.png",
	overFile = "buttonBlueOver.png",
	label = "Log Event 3",
	labelColor = 
	{ 
		default = { 1, 1, 1 }, 
		over = { 1, 0, 0 } 
	},
	fontSize = 20,
	font = native.systemFontBold,
	onRelease = buttonRelease3
}
