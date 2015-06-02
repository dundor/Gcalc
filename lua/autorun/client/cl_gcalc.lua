// lua/autorun/client/cl_gcalc.lua 

function DrawCalc()
	-- print( "DrawCalc ran")
	local frame = vgui.Create( "DFrame" )
	-- frame:Center()
	frame:SetPos( (ScrW()/2)-57, (ScrH()/2)-100 )
	if closed then frame:SetPos( ClosePosX-115, ClosePosY-20 ) end 
	frame:SetSize( 115, 200 )
	frame:MakePopup()
	frame:ShowCloseButton( false )
	frame:SetTitle( "GCalc v0.03" )
	
	close_but = vgui.Create( "DButton", frame )
	close_but:SetPos( 95, 0 )
	close_but:SetSize( 20, 20 )
	close_but:SetText( "X" )
	close_but.DoClick = function()
		ClosePosX = gui.MouseX()
		ClosePosY = gui.MouseY()
		print( ClosePosX, ClosePosY )
		frame:Close()
		closed = true
	end

 	local txt_entry = vgui.Create( "DTextEntry", frame )
	txt_entry:SetSize( 95, 20 )
	txt_entry:SetPos( 10, 30 )
	txt_entry:SetEditable( false )
	function txt_entry:OnChange()
		print( txt_entry:GetFloat() )
	end  
	
	// number buttons
	local check = 0 
	local operation = ""
	local value2 = 0
	local value1 = 0
	local posx = 10
	local posy = 130
	txt_entry:SetValue( "0" )
	for i = 1, 9 do
		-- print( "Building button " .. i )
		local calc_but = vgui.Create( "DButton", frame )
		calc_but:SetSize( 20, 20 )
		calc_but:SetPos( posx, posy )
		calc_but:SetText( i )
		calc_but.DoClick = function()
			if check == 1 then check = 0 txt_entry:SetValue( 0 ) end
			num = txt_entry:GetValue()
			-- print( "value " .. value )
			-- print( "num " .. num )
			-- print( "i " .. i ) 
			-- num = num .. i
			-- value = value .. i
			-- print( value )
			if num == "0" then
				txt_entry:SetValue( i )
			else
				txt_entry:SetValue( num .. i )
			end
			-- print( "value 2 " .. value )
		end
		
		posx = posx + 25
		if posx > 75 then
			posx = 10
		end
		
		if i == 3 then 
			posy = 105
		elseif i == 6 then
			posy = 80
		end
	end
	
	local zero_but = vgui.Create( "DButton", frame )
	zero_but:SetSize( 45, 20 )
	zero_but:SetPos( 10, 155 )
	zero_but:SetText( 0 )
	zero_but.DoClick = function()
		if check == 1 then check = 0 txt_entry:SetValue( 0 ) end
		num = txt_entry:GetValue()
		-- print( "value " .. value )
		-- print( "num " .. num )
		-- print( "i " .. 0 ) 
		if num == "0" then
			txt_entry:SetValue( 0 )
		else
			txt_entry:SetValue( num .. 0 )
		end
	end
	
	// function buttons
	local clear_but = vgui.Create( "DButton", frame )
	clear_but:SetSize( 20, 20 )
	clear_but:SetPos( 10, 55 )
	clear_but:SetText( "C" )
	clear_but.DoClick = function()
		value = 0
		operation = ""
		value1 = 0
		value2 = 0 
		txt_entry:SetValue( 0 )
	end
	
	local plus_but = vgui.Create( "DButton", frame )
	plus_but:SetSize( 20, 45 )
	plus_but:SetPos( 85, 80 )
	plus_but:SetText( "+" )
	plus_but.DoClick = function()
		operation = "+"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local sub_but = vgui.Create( "DButton", frame )
	sub_but:SetSize( 20, 20 )
	sub_but:SetPos( 85, 55 )
	sub_but:SetText( "-" )
	sub_but.DoClick = function()
		operation = "-"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local div_but = vgui.Create( "DButton", frame )
	div_but:SetSize( 20, 20 )
	div_but:SetPos( 35, 55 )
	div_but:SetText( "÷" )
	div_but.DoClick = function()
		operation = "/"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local multi_but = vgui.Create( "DButton", frame )
	multi_but:SetSize( 20, 20 )
	multi_but:SetPos( 60, 55 )
	multi_but:SetText( "×" )
	multi_but.DoClick = function()
		operation = "*"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local dot_but = vgui.Create( "DButton", frame )
	dot_but:SetSize( 20, 20 )
	dot_but:SetPos( 60, 155 )
	dot_but:SetText( "." )
	dot_but.DoClick = function()
		num = txt_entry:GetValue()
		txt_entry:SetValue( num .. "." )
	end
	
	local equal_but = vgui.Create( "DButton", frame )
	equal_but:SetSize( 20, 45 )
	equal_but:SetPos( 85, 130 )
	equal_but:SetText( "=" )
	equal_but.DoClick = function()
		value2 = txt_entry:GetFloat()
		if operation == "+" then
			txt_entry:SetValue( value2 + value1 )
		elseif operation == "-" then
			txt_entry:SetValue( value1 - value2 )
		elseif operation == "/" then
			txt_entry:SetValue( value1 / value2 )
		elseif operation == "*" then
			txt_entry:SetValue( value1 * value2 )
		else
			txt_entry:SetValue( 0 )
		end
		check = 1
	end
	
end

hook.Add( "OnPlayerChat", "CreateKickerCom", function( ply, text, team )
	if ( string.sub( text, 1, 6 ) == "!gcalc" ) then
		-- print( "client side" )
		DrawCalc()
		return ""
	end
end )

-- print( "cl_gcalc ran" )
