(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages"))
;; Don't show splash screen
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

(load-theme 'gruber-darker t)
(package-initialize)
(require 'evil)
(evil-mode 1)
