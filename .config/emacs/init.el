(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Don't show splash screen
(setq inhibit-startup-message t)

;; Smex or meta
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-x") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-C M-x") 'execute-extended-command)

;; Disable lame shit
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Ido mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Line numbers :)
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

;; Initialize packages
(package-initialize)

(load-theme 'gruber-darker t)

;; vimmy
(require 'evil)
(evil-mode 1)
