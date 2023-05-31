{-# LANGUAGE ImportQualifiedPost #-}

-- core
import Data.Monoid
import XMonad

-- window stack manipulation and map creation
import Data.Map qualified as M
import Data.Maybe
import Data.Tree
import XMonad.StackSet qualified as W

-- system
import System.Exit
import System.IO

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.WindowSwallowing

-- layout
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts

-- actions
import XMonad.Actions.CopyWindow
import XMonad.Actions.DynamicProjects
import XMonad.Actions.SpawnOn
import XMonad.Actions.Submap

-- utils
import XMonad.Util.Run

-- import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

-- keys
import Graphics.X11.ExtraTypes.XF86

-- prompts
import XMonad.Layout.Decoration (Decoration, DefaultShrinker)
import XMonad.Layout.Simplest (Simplest)
import XMonad.Layout.TwoPane
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Prompt.Window

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

myGruber :: Colorscheme
myGruber =
    Colorscheme
        { black = "#1c1c1c"
        , white = "#e4e4e4"
        , gray = "#626262"
        , yellow = "#ffd700"
        , orange = "#ffa500"
        , red = "#ff5f5f"
        , purple = "#afafd7"
        , blue = "#87afd7"
        , cyan = "#afd7af"
        , green = "#87d75f"
        }

myGruvbox :: Colorscheme
myGruvbox =
    Colorscheme
        { black = "#282828"
        , white = "#ebdbb2"
        , gray = "#928374"
        , yellow = "#fabd2f"
        , orange = "#fe8019"
        , red = "#fb4934"
        , purple = "#d3869b"
        , blue = "#83a598"
        , cyan = "#8ec07c"
        , green = "#b8bb26"
        }

---------------------------------------------------------------------------------------------------
-- USER VARIABLES

myModMask = mod4Mask :: KeyMask
myFocusFollowsMouse = False :: Bool
myClickJustFocuses = False :: Bool
myBorderWidth = 2 :: Dimension
myGaps = 6 :: Integer
myColor = myGruber :: Colorscheme
myNormalBorderColor = "#000000" :: String
myFocusedBorderColor = "#FFFFFF" :: String
myTerminal = "kitty" :: String
myFilemanager = "pcmanfm" :: String
myBrowser = "firefox" :: String
myMail = "thunderbird" :: String
myFont = "xft:Iosevka Term Nerd Font:size=11:SemiBold:antialias=true" :: String

---------------------------------------------------------------------------------------------------
-- HOOKS

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "polybar &"
    spawnOnce "kmonad ~/.config/kmonad/keyboard.kbd &"
    spawnOnce "picom --fade-in-step=1 --fade-out-step=1 --fade-delta=0 &"
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "mullvad connect"
    spawnOn "8" "/usr/bin/discord"
    spawnOn "9" "/usr/bin/thunderbird"

myEventHook :: Event -> X All
myEventHook = swallowEventHook (className =? myTerminal) (return True)

myManageHook :: ManageHook
myManageHook =
    composeAll
        [ manageDocks
        , className =? "MPlayer" --> doFloat
        , className =? "Gimp" --> doFloat
        , className =? "Zoom" --> doFloat
        , className =? "Blueberry.py" --> doFloat
        , className =? "nm-connection-editor" --> doFloat
        , className =? "Nm-connection-editor" --> doFloat
        , className =? "discord" --> doShift "8"
        , className =? "thunderbird" --> doShift "9"
        , resource =? "desktop_window" --> doIgnore
        , resource =? "kdesktop" --> doIgnore
        ]
        <+> insertPosition Below Newer

---------------------------------------------------------------------------------------------------
-- SCRATCHPAD

-- nothing yet

---------------------------------------------------------------------------------------------------
-- LAYOUTS

mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border 0 i 0 i) True (Border i 0 i 0) True

full :: ModifiedLayout Rename (ModifiedLayout Spacing Full) a
full = renamed [Replace "Full"] . mySpacing myGaps $ Full

threeCols :: ModifiedLayout Rename (ModifiedLayout Spacing ThreeCol) a
threeCols = renamed [Replace "Column"] $ mySpacing myGaps $ ThreeCol 1 (3 / 100) (1 / 2)

tall :: ModifiedLayout Rename (ModifiedLayout Spacing ResizableTall) a
tall = renamed [Replace "Tall"] . mySpacing myGaps $ ResizableTall 1 (3 / 100) (1 / 2) []

wide :: ModifiedLayout Rename (ModifiedLayout Spacing (Mirror Tall)) a
wide = renamed [Replace "Wide"] . mySpacing myGaps $ Mirror (Tall 1 (3 / 100) (1 / 2))

grid :: ModifiedLayout Rename (ModifiedLayout Spacing Grid) a
grid = renamed [Replace "Grid"] . mySpacing myGaps $ Grid

tabs :: ModifiedLayout Rename (ModifiedLayout Spacing (ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest)) Window
tabs = renamed [Replace "Tabbed"] . mySpacing myGaps $ tabbed shrinkText myTabConfig

myLayout = avoidStruts $ smartBorders myDefaultLayout
  where
    myDefaultLayout = fullTog tall ||| fullTog threeCols ||| tabs
      where
        fullTog l = toggleLayouts full l

myTabConfig :: Theme
myTabConfig = def{fontName = myFont}

---------------------------------------------------------------------------------------------------
-- WORKSPACES

myWorkspaces :: [String]
myWorkspaces = map show [1 .. 9]

myWorkspaceIndices :: M.Map String Int
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..]

clickable :: String -> String
clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

---------------------------------------------------------------------------------------------------
-- KEYS

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig{XMonad.modMask = modm}) =
    M.fromList $
        concat
            [
                [ -- spawns
                  ((modm, xK_Return), spawn $ XMonad.terminal conf)
                , ((modm, xK_d), spawn "dmenu_run")
                , ((modm, xK_o), spawn myFilemanager)
                , ((modm, xK_b), spawn myBrowser)
                , -- windows
                  ((modm, xK_q), kill)
                , ((modm, xK_s), sendMessage NextLayout)
                , ((modm, xK_f), sendMessage (Toggle "Full"))
                , ((modm .|. shiftMask, xK_s), setLayout $ XMonad.layoutHook conf)
                , ((modm, xK_n), refresh)
                , ((modm, xK_Tab), windows W.focusDown)
                , ((modm, xK_j), windows W.focusDown)
                , ((modm, xK_k), windows W.focusUp)
                , ((modm, xK_m), windows W.focusMaster)
                , ((modm .|. shiftMask, xK_j), windows W.swapDown)
                , ((modm .|. shiftMask, xK_k), windows W.swapUp)
                , ((modm, xK_h), sendMessage Shrink)
                , ((modm, xK_l), sendMessage Expand)
                , ((modm, xK_t), withFocused $ windows . W.sink)
                , ((modm, xK_comma), sendMessage (IncMasterN 1))
                , ((modm, xK_period), sendMessage (IncMasterN (-1)))
                , ((modm .|. shiftMask, xK_c), spawn "xmonad --recompile && xmonad --restart")
                , -- brightness
                  ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 3")
                , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 3")
                , -- volume
                  ((0, xF86XK_AudioMute), spawn "amixer set Master 'toggle'")
                , ((0, xF86XK_AudioRaiseVolume), spawn "pamixer -i 3")
                , ((0, xF86XK_AudioLowerVolume), spawn "pamixer -d 3")
                , -- lock screen
                  ((modm .|. controlMask, xK_l), spawn "i3lock -i ~/Pictures/watercity_locked.png")
                , -- screenshots
                  ((0, xK_Print), spawn "flameshot gui")
                , ((0 .|. shiftMask, xK_Print), spawn "flameshot screen -p ~/Pictures/screenshots")
                , ((0 .|. controlMask, xK_Print), spawn "flameshot full -p ~/Pictures/screenshots")
                ]
            , -- change workspaces
              [ ((m .|. modm, k), windows $ f i)
              | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
              , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
              ]
            , -- move windows to workspaces
              [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
              | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..]
              , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
              ]
            ]

----------------------------------------------------------------------------------------------------
-- MOUSE

myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig{XMonad.modMask = modm}) =
    M.fromList
        [
            ( (modm, button1)
            , \w ->
                focus w
                    >> mouseMoveWindow w
                    >> windows W.shiftMaster
            )
        , ((modm, button2), \w -> focus w >> windows W.shiftMaster)
        ,
            ( (modm, button3)
            , \w ->
                focus w
                    >> mouseResizeWindow w
                    >> windows W.shiftMaster
            )
        ]

----------------------------------------------------------------------------------------------------
-- MAIN

main :: IO ()
main = do
    bar <- spawnPipe "polybar" -- "xmobar -x 0 ~/.config/xmonad/xmobar.config"
    xmonad . docks . ewmh $
        def
            { terminal = myTerminal
            , focusFollowsMouse = myFocusFollowsMouse
            , clickJustFocuses = myClickJustFocuses
            , borderWidth = myBorderWidth
            , modMask = myModMask
            , workspaces = myWorkspaces
            , focusedBorderColor = myFocusedBorderColor
            , normalBorderColor = myNormalBorderColor
            , keys = myKeys
            , layoutHook = avoidStruts myLayout
            , manageHook = myManageHook
            , handleEventHook = myEventHook
            , startupHook = myStartupHook
            , logHook =
                dynamicLogWithPP $
                    xmobarPP
                        { ppCurrent = xmobarColor (green myColor) "" . wrap "[" "]"
                        , ppVisible = xmobarColor (white myColor) "" . wrap "" "" . clickable
                        , ppHidden = xmobarColor (yellow myColor) "" . wrap "" "" . clickable
                        , ppHiddenNoWindows = xmobarColor (white myColor) "" . clickable
                        , ppSep = " | "
                        , ppTitle = xmobarColor (white myColor) "" . shorten 60
                        , ppLayout = xmobarColor (white myColor) ""
                        , -- , ppOutput = hPutStrLn bar
                          ppOrder = \(ws : l : t : ex) -> [ws, l, t]
                        }
            }
