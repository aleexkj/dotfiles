Config { font = "xft:DejaVu Sans Mono for Powerline:pixelsize=13"
       , bgColor = "#000000"
       , fgColor = "#c6dee0"
       , alpha = 220
       , overrideRedirect = True
       , position = Top
       , lowerOnStart = True 
       , persistent = True
	, commands = [ 
                     Run Com ".xmonad/widgets/battery" ["-s","-r"] "battery" 10
                    , Run Com ".xmonad/widgets/time" ["-s","-r"] "time" 10
                   -- , Run Cpu ["-t", "<total>%", "-L","3","-H","50","--normal","#657b83","--high","#657b83"] 10
                   -- , Run Memory ["-t", " / <usedratio>%","-L","3","-H","50","--normal","#657b83","--high","#657b83"] 10
                    , Run Com ".xmonad/widgets/connection" ["-s","-r"] "connection" 10
					, Run DynNetwork [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                             , "--Low"      , "1000"       -- units: kB/s
                             , "--High"     , "5000"       -- units: kB/s
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{ %battery% %connection% | <fc=#a5cbce>%time%</fc>"
       }
