import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Themes
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce

import System.IO
import System.Posix.Env

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Prompt         as P

import XMonad.Layout.Tabbed
import XMonad.Layout.Cross
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
-- import XMonad.Layout.Gaps
import XMonad.Layout.WindowArranger
import XMonad.Layout.ToggleLayouts

import XMonad.Actions.CycleWS
import XMonad.Actions.PhysicalScreens

import XMonad.Config.Desktop

-- Custom application-desktops
myManageHook = composeAll
    [
      className =? "Firefox" --> doF (W.shift "www"),
      className =? "google-chrome" --> doF (W.shift "www"),
      className =? "slack" --> doF (W.shift "home")
    ]

myKeys =
    [
	-- Bindings
      ((mod4Mask, xK_p), spawn "dmenu_run -b -p 'launch' -fn 'Bitstream Vera Sans Mono-12' -nb '#12171d' -nf '#879ebb' -sb '#568396' -sf 'white'"),
      ((mod4Mask, xK_s), spawn "~/bin/lockscreen.sh"),
      ((mod4Mask, xK_u), spawn "~/bin/layout_switch.sh")
	-- Navigation
	, ((mod4Mask, xK_Down), nextWS)
	, ((mod4Mask, xK_Up), prevWS)
	, ((mod4Mask, xK_Right), onNextNeighbour W.view)
	, ((mod4Mask, xK_Left), onPrevNeighbour W.view)
       -- multimedia keys
       -- XF86AudioLowerVolume
       , ((0            , 0x1008ff11), spawn "amixer set Master 5%-")
       -- XF86AudioRaiseVolume
       , ((0            , 0x1008ff13), spawn "amixer set Master 5%+")
       -- XF86AudioMute
       , ((0            , 0x1008ff12), spawn "amixer set Master toggle")
       -- XF86MonBrightnessUp
       , ((0, 0x1008ff02), spawn "lux -a 15%")
       -- XF86MonBrightnessDown
       , ((0, 0x1008ff03), spawn "lux -s 15%")
	-- Home key
	-- , ((0, 0x1008ff18), windows $ W.greedyView)
       -- Struts
       , ((mod4Mask, xK_g), sendMessage ToggleStruts) -- make room for panel
       -- Tiles
    	, ((modCtrl, xK_r), sendMessage  Arrange)
        , ((modShCtrl, xK_r), sendMessage  DeArrange)
        , ((modCtrl, xK_Left),  sendMessage (MoveLeft      10))
        , ((modCtrl, xK_Right), sendMessage (MoveRight     10))
        , ((modCtrl, xK_Down),  sendMessage (MoveDown      10))
        , ((modCtrl, xK_Up),    sendMessage (MoveUp        10))
        , ((modShft, xK_Left ), sendMessage (IncreaseLeft  10))
        , ((modShft, xK_Right), sendMessage (IncreaseRight 10))
        , ((modShft, xK_Down ), sendMessage (IncreaseDown  10))
        , ((modShft, xK_Up   ), sendMessage (IncreaseUp    10))
        , ((modShCtrl, xK_Left ), sendMessage (DecreaseLeft  10))
        , ((modShCtrl, xK_Right), sendMessage (DecreaseRight 10))
        , ((modShCtrl, xK_Down ), sendMessage (DecreaseDown  10))
        , ((modShCtrl, xK_Up   ), sendMessage (DecreaseUp    10))
    ]
    where modShft     = mod4Mask .|. shiftMask
          modCtrl     = mod4Mask .|. controlMask
          modShCtrl     = mod4Mask .|. shiftMask .|. controlMask
          nilMask     = 0

myTabConfig = def { 
	inactiveColor = "#a3a3a3",
	activeColor = "#0a2727", 
	inactiveBorderColor = "#a3a3a3",
	inactiveTextColor = "#666666",
	activeBorderColor = "#0a2727",
	activeTextColor = "#eeeeee"
}

-- Layouts
tall = spacing 5 $ Tall 1 (3/100) (488/792)
full = noBorders Full
tb = noBorders $ tabbed shrinkText myTabConfig
sc = Cross (1/2) (1/100)
myLayoutHook = avoidStruts $ (tall ||| Mirror tall ||| tb  ||| sc) 

-- Startup
myStartupHook = do
	spawnOnce "setup_monitors"
	spawnOnce "urxvt"

main = do
    xmproc <- spawnPipe "xmobar $HOME/.xmonad/xmobar.hs"
    xmonad $ desktopConfig {
	focusFollowsMouse = False,
        -- basic conf
        modMask            = mod4Mask,
        terminal           = "urxvt",
        borderWidth        = 1,
        workspaces         = ["home","www","3", "4", "5", "6", "7", "8", "9"],
        -- colors
        normalBorderColor  = "#181512",
        focusedBorderColor = "#eddcd3",
        -- hooks
        manageHook = myManageHook <+> manageDocks,
        layoutHook = windowArrange $ myLayoutHook ||| full, 
	startupHook = myStartupHook,
        logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#04eed1" "" . shorten 100
			, ppVisible = wrap "<" ">"
			, ppCurrent = xmobarColor "#cc456c" "" . wrap "[" "]"
			, ppSep = " ~ "
			, ppHidden = xmobarColor "#989584" ""
			, ppOrder = \(ws:_:t:_) -> [ws,t]
                        }
        } `additionalKeys` myKeys
