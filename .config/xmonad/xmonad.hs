{-# LANGUAGE TypeApplications #-}

-- core
import XMonad
import Data.Monoid
import System.Exit

-- window stack manipulation and map creation
import Data.Tree
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Maybe (fromJust)

-- system
import System.Exit (exitSuccess)
import System.IO (hPutStrLn)

-- hooks
import XMonad.Hooks.ManageDocks(avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.DynamicLog(dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops

-- layout
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutModifier(ModifiedLayout)

-- actions
import XMonad.Actions.CopyWindow(copy, kill1, copyToAll, killAllOtherCopies)
import XMonad.Actions.Submap(submap)

-- utils
import XMonad.Util.Run (spawnPipe)

--import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

-- keys
import Graphics.X11.ExtraTypes.XF86

-- prompts
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Window
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell
import XMonad.Prompt.FuzzyMatch


---------------------------------------------------------------------------------------------------
data Colorscheme = Colorscheme
                 { black :: String
                 , white :: String
                 , gray :: String
                 , yellow :: String
                 , orange :: String
                 , red :: String
                 , purple :: String
                 , blue :: String
                 , cyan :: String
                 , green :: String
                 }

myGruvbox :: Colorscheme
myGruvbox = Colorscheme
          { black   = "#282828"
          , white   = "#ebdbb2"
          , gray    = "#928374"
          , yellow  = "#fabd2f"
          , orange  = "#fe8019"
          , red     = "#fb4934"
          , purple  = "#d3869b"
          , blue    = "#83a598"
          , cyan    = "#8ec07c"
          , green   = "#b8bb26"
          }


---------------------------------------------------------------------------------------------------
-- USER VARIABLES


myModMask            = mod4Mask                          :: KeyMask
myFocusFollowsMouse  = False                             :: Bool
myClickJustFocuses   = True                              :: Bool
myBorderWidth        = 1                                 :: Dimension
myWindowGap          = 1                                 :: Integer
myColor              = undefined                         :: Colorscheme
myNormalBorderColor  = "#dddddd"                         :: String
myFocusedBorderColor = "#ff0000"                         :: String
myTerminal           = "kitty"                           :: String
myFilemanager        = "pcmanfm"                         :: String
myBrowser            = "firefox"                         :: String
myMail               = "thunderbird"                     :: String
myFont               = "Iosevka Term Nerd Font Complete" :: String

---------------------------------------------------------------------------------------------------
-- XMOBAR


---------------------------------------------------------------------------------------------------
-- LOG HOOKS

myLogHook            = return ()
myStartupHook        = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "xmodmap -e \"keycode 66 = Escape\""
    spawnOnce "picom --fade-in-step=1 --fade-out-step=1 --fade-delta=0 &"
myEventHook          = mempty


---------------------------------------------------------------------------------------------------

myWorkspaces         = map show [1 .. 9]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..]
clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    concat $
    [
        [
          ((modm, xK_Return), spawn $ XMonad.terminal conf)
        , ((modm, xK_d), spawn "dmenu_run")
        , ((modm, xK_p), spawn "gmrun")
        , ((modm, xK_q), kill)
        , ((modm, xK_space), sendMessage NextLayout)
        , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
        , ((modm, xK_n), refresh)
        , ((modm, xK_Tab), windows W.focusDown)
        , ((modm, xK_j), windows W.focusDown)
        , ((modm, xK_k), windows W.focusUp  )
        , ((modm, xK_m), windows W.focusMaster  )
        , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
        , ((modm .|. shiftMask, xK_j), windows W.swapDown  )
        , ((modm .|. shiftMask, xK_k), windows W.swapUp    )
        , ((modm, xK_h), sendMessage Shrink)
        , ((modm, xK_l), sendMessage Expand)
        , ((modm, xK_t), withFocused $ windows . W.sink)
        , ((modm, xK_comma), sendMessage (IncMasterN 1))
        , ((modm, xK_period), sendMessage (IncMasterN (-1)))
        , ((modm .|. shiftMask, xK_c), spawn "xmonad --recompile; xmonad --restart")
        -- brightness
        , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
        , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")
        -- volume
        , ((0, xF86XK_AudioMute), spawn "amixer set Master 'toggle'")
        , ((0, xF86XK_AudioRaiseVolume), spawn "pamixer -i 5")
        , ((0, xF86XK_AudioLowerVolume), spawn "pamixer -d 5")
        ]
    ,
        -- change workspaces
        [((m .|. modm, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
   ,
        -- move windows to workspaces
        [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

myLayout = tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 1/100

myManageHook = composeAll
    [ manageDocks
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Zoom"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]


myConfig = def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

main :: IO ()
main = do
  xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmonad/xmobar.config"
  xmonad $ docks $ ewmh def
        { terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , focusedBorderColor = myFocusedBorderColor
        , normalBorderColor  = myNormalBorderColor
        , keys               = myKeys
        , layoutHook         = avoidStruts myLayout
        , manageHook         = myManageHook
        , handleEventHook    = myEventHook
        , startupHook        = myStartupHook
        , logHook            = dynamicLogWithPP $ xmobarPP
                                                { ppCurrent         = xmobarColor (green myColor) "" . wrap "[" "]",
                                                  ppVisible         = xmobarColor (white myColor) "" . wrap "" "" . clickable,
                                                  ppHidden          = xmobarColor (yellow myColor) "" . wrap "" "" . clickable,
                                                  ppHiddenNoWindows = xmobarColor (white myColor) "" . clickable,
                                                  ppSep             = " | ",
                                                  ppTitle           = xmobarColor (white myColor) "" . shorten 60,
                                                  ppLayout          = xmobarColor  (white myColor) "",
                                                  ppOutput          = \x -> hPutStrLn xmproc0 x,
                                                  --ppExtras          = [windowCount],
                                                  ppOrder           = \(ws : l : t : ex) -> [ws, l, t]
                                                }
        }
