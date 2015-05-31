// lua/autorun/server/sv_gcalc.lua

util.AddNetworkString( "gcalc" )
print( "sv_gcalc ran" )
function GcalcCom( ply, txt, pub )
	if string.sub( string.lower( txt ), 1 , 6 ) == "!gcalc" then 
		print( "If ran" )
 		net.Start( "gcalc" )
 		net.Send( ply )
 		return ""
	end
end
hook.Add("PlayerSay", "GcalcCom", GcalcCom )

