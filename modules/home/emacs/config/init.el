(setq custom-file "~/.emacs.d/custom.el")

;; Removing the bell
(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil :height 110 :family "IosevkaTerm Nerd Font")

;; Basic UI config
;;; Scroll bars
(scroll-bar-mode 0)
(pixel-scroll-precision-mode)
(pixel-scroll-mode)

(tool-bar-mode 0)
(menu-bar-mode 0)
(setq inhibit-startup-screen t)

;; Line numbers
(global-display-line-numbers-mode)
(global-visual-line-mode)

;; Ido mode
(ido-mode)
(setq ido-mode-everywhere t
      ido-mode-flex-matching t)

;; Hide backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Dired
(setq dired-listing-switches "-aBhlv  --group-directories-first")

(load-theme 'ef-dark t)
(load-file "~/.emacs.d/chabam-theme.el")
(load-file custom-file)
