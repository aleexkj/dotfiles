import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Posix.Env

import qualified XMonad.StackSet as W
import qualified Data.Map as M
--import qualified System.IO.UTF8        as U
import qualified XMonad.Actions.Search as S
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Prompt         as P

import XMonad.Layout.WindowNavigation
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Layout.MosaicAlt
import XMonad.Layout.Combo
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Cross

import XMonad.Layout.PerWorkspace

import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

myManageHook = composeAll
    [
      className =? "Firefox"          --> doF (W.shift "www"),
      className =? "Google-chrome" --> doF (W.shift "www")
    ]

mySpacing = ModifySpacing (\n -> n+1)

myKeys =
    [
      ((mod4Mask, xK_p), spawn "dmenu_run"),
      ((mod4Mask, xK_a), windows (W.view "home")),
      ((mod4Mask, xK_o), windows (W.view "code")),
      ((mod4Mask, xK_f), windows (W.view "www")),
      ((0, xK_Print), spawn "scrot -s"),
      ((mod4Mask, xK_i), spawn "to_cip"),
      ((mod4Mask, xK_s), spawn "~/lockscreen.sh")
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
       -- Gaps
       , ((mod4Mask, xK_g), sendMessage $ ToggleGap U) -- toggle top gap
       -- spacing
       -- , ((mod4Mask, xK_a), incSpacing 1)
    ]
    where modMask     = mod1Mask
          modShft     = modMask .|. shiftMask
          modCtrl     = modMask .|. controlMask
          modShCr     = modMask .|. shiftMask .|. controlMask
          modMod2     = mod2Mask
          modM1Cr     = modMask .|. mod2Mask .|. controlMask
          search      = SM.submap $ searchMap $ S.promptSearch P.defaultXPConfig
          nilMask     = 0
          jstShft     = shiftMask
          searchMap m = M.fromList $
              [ ((nilMask, xK_g), m S.google),
                ((nilMask, xK_w), m S.wikipedia),
                ((nilMask, xK_i), m S.imdb)
              ]

myTabConfig = defaultTheme { inactiveColor = "#050505", activeColor = "#050505",  inactiveBorderColor = "#050505", inactiveTextColor = "#666666", activeBorderColor = "#050505", activeTextColor = "#eeeeee"}

main = do
    putEnv "BROWSER=w3"
    xmproc <- spawnPipe "xmobar $HOME/.xmonad/xmobar.hs"
    xmonad $ defaultConfig {
        -- basic conf
        modMask            = mod4Mask,
        terminal           = "urxvt",
        borderWidth        = 1,
        workspaces         = ["home","www","code", "code+", "music", "6", "7", "8", "9"],
        -- colors
        normalBorderColor  = "#002b36",
        focusedBorderColor = "#657b83",
        -- hooks
        manageHook = myManageHook <+> manageDocks,
       -- layoutHook = avoidStruts $ layoutHook defaultConfig,
        layoutHook      = smartSpacing 2 $ gaps [(U, 20)] $ windowNavigation $ smartBorders $ (avoidStruts (tall ||| Mirror tall ||| noBorders (tabbed shrinkText myTabConfig) ||| noBorders Full ||| onWorkspace "WWW" (tabbed shrinkText myTabConfig) tall)) ||| simpleCross,
        logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "gray" "" . shorten 100
                        }
        } `additionalKeys` myKeys
        where
          tall  = Tall 1 (3/100) (488/792)
          -- mosaic  = MosaicAlt M.empty
          -- combo   = combineTwo (TwoPane 0.03 (3/10)) (mosaic) (Full)
