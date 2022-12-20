-- core
import XMonad
import Data.Monoid
import System.Exit

-- window stack manipulation and map creation
import Data.Tree
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Maybe

-- system
import System.Exit
import System.IO

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar

-- layout
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutModifier(ModifiedLayout)

-- actions
import XMonad.Actions.CopyWindow
import XMonad.Actions.Submap
import XMonad.Actions.DynamicProjects

-- utils
import XMonad.Util.Run

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
-- COLOR SCHEMES

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
-- HOOKS

myStartupHook        = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "setxkbmap -option caps:escape"
    spawnOnce "picom --fade-in-step=1 --fade-out-step=1 --fade-delta=0 &"
    spawnOnce "xsetroot -cursor_name left_ptr"

myLayoutHook = tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 1/100

myEventHook = mempty

myManageHook = composeAll
    [ manageDocks
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Zoom"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]

---------------------------------------------------------------------------------------------------
-- WORKSPACES

myWorkspaces         = ["term", "web", "misc", "4", "5", "6", "7", "coms", "mail"]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..]
clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices


---------------------------------------------------------------------------------------------------
-- KEYS

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    concat $
    [
        [
          ((modm, xK_Return), spawn $ XMonad.terminal conf)
        , ((modm, xK_d), spawn "dmenu_run")
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
        , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 3")
        , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 3")
        -- volume
        , ((0, xF86XK_AudioMute), spawn "amixer set Master 'toggle'")
        , ((0, xF86XK_AudioRaiseVolume), spawn "pamixer -i 3")
        , ((0, xF86XK_AudioLowerVolume), spawn "pamixer -d 3")
        --lock screen
        , ((modm .|. controlMask, xK_l), spawn "slock")
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

----------------------------------------------------------------------------------------------------
-- MOUSE

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

main :: IO ()
main = do
    bar <- spawnPipe "xmobar -x 0 ~/.config/xmonad/xmobar.config"
    xmonad . docks . ewmh $ def
        { terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , focusedBorderColor = myFocusedBorderColor
        , normalBorderColor  = myNormalBorderColor
        , keys               = myKeys
        , layoutHook         = avoidStruts myLayoutHook
        , manageHook         = myManageHook
        , handleEventHook    = myEventHook
        , startupHook        = myStartupHook
        , logHook            = dynamicLogWithPP $ xmobarPP
            { ppOutput          = hPutStrLn bar
            , ppSep             = " | "
            , ppOrder           = \(ws : l : t : ex) -> [ws, l, t]
            }
        }


-- TODO:
{-

xmobar widgets such as: workspaces, discord, network and bluetooth
layout algorithm
keybinds?
display locker
lightDM
add type signatures


-}
