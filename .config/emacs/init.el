(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Don't show splash screen
(setq inhibit-startup-message t)

;; Smex or meta
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-x") 'smex-major-mode-commands)
;; (global-set-key (kbd "C-c C-C M-x") 'execute-extended-command)

;; Disable lame shit
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Ido mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Line numbers
(setq display-line-numbers-type 'relative) (global-display-line-numbers-mode)

;; Set keybind to frog jump buffer 
;; This does not work
;;(global-set-key (kbd "C-x b") (frog-jump-buffer))

;; Change size of entire emacs, zooms everything by 20%
(set-face-attribute 'default nil
		    :family "Julia Mono"
		    :height 130)

(use-package switch-window
  :ensure t
  :bind
  ;; default C-x o is other-window
  ;; default C-x C-o is delete-blank-lines
  (("C-x o" . switch-window)
   ("C-x C-o" . switch-window))
  :config
  (setq switch-window-multiple-frames t)
  (setq switch-window-shortcut-style 'qwerty)
  ;; when Emacs is run as client, the first shortcut does not appear
  ;; "x" acts as a dummy; remove first entry if not running server
  (setq switch-window-qwerty-shortcuts '("x" "a" "s" "d" "f" "j" "k" "l" ";" "w" "e" "r" "u" "i" "o" "q" "t" "y" "p"))
  (setq switch-window-increase 3))

;; Initialize packages
(package-initialize)

(load-theme 'gruber-darker t)
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(smex frog-jump-buffer switchy-window switch-window gruber-darker-theme evil ayu-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
