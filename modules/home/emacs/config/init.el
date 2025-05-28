(load-file "~/.emacs.d/chabam-light-theme.el")
(load-file "~/.emacs.d/chabam-dark-theme.el")

(use-package vertico
  :custom
  (vertico-count 10)
  :init
  (vertico-mode))

(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package better-jumper
  :bind (("C-c C-n" . 'better-jumper-jump-forward)
         ("C-c C-p" . 'better-jumper-jump-backward))
  :config
  (setq better-jumper-context 'window
        better-jumper-new-window-behavior 'copy
        better-jumper-add-jump-behavior 'replace
        better-jumper-max-length 100)
  ;; Functions that should add a mark
  (dolist (cmd '(next-line previous-line
                  forward-paragraph backward-paragraph
                  beginning-of-defun end-of-defun
                  forward-word backward-word
                  scroll-up-command scroll-down-command
                  recenter-top-bottom move-to-window-line-top-bottom
                  goto-line))
    (advice-add cmd :before (lambda (&rest _) (better-jumper-set-jump))))
  :init (better-jumper-mode +1))

;; Emacs minibuffer configurations.
(use-package emacs
  :bind (("C-." . duplicate-line)
         ("M-o" . other-window))
  :custom
  (custom-file "~/.emacs.d/custom.el")
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))
  ;; Remove the bell
  (ring-bell-function 'ignore)
  ;; Remove splash screen
  (inhibit-startup-screen t)

  (text-mode-ispell-word-completion nil)

  (completion-styles '(basic substring partial-completion flex))
  (vc-follow-symlinks t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  :hook (((prog-mode text-mode) . (lambda () (setq show-trailing-whitespace t)
                                    (column-number-mode)
                                    (display-line-numbers-mode)))
         ((org-mode text-mode) . auto-fill-mode))
  :config (require 'ansi-color)
  :init

  ;; Putting files somewhere else
  (require 'no-littering)
  (no-littering-theme-backups)
  (let ((dir (no-littering-expand-var-file-name "lock-files/")))
    (make-directory dir t)
    (setq lock-file-name-transforms `((".*" ,dir t))))
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))

  ;; Smooth scroll
  (pixel-scroll-precision-mode)
  (pixel-scroll-mode)

  ;; Hiding ui elements
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)

  (windmove-default-keybindings)
  (setq indent-line-function 'insert-tab
        default-frame-alist '((font . "Iosevka-12")
                              (width . 100)
                              (height . 40)))
  (setq whitespace-style '(face indentation tabs tab-mark spaces space-mark
                                newline newline-mark trailing))
  (setq-default standard-indent 4
                tab-width 4
                indent-tabs-mode nil
                display-line-numbers-type 'relative)
  (set-frame-font "Iosevka 12" nil t)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka"))

(use-package compile
  :init
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter))

(use-package flymake
  :config (setq flymake-indicator-type 'margins))

(use-package corfu
  :custom
  ;; Autocomplete settings
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.2)
  (corfu-quit-no-match 'separator)
  (corfu-quit-at-boundary t)
  (corfu-preview-current nil)

  (corfu-cycle t)
  (corfu-popupinfo-delay 0.5)
  (corfu-left-margin-width 0)
  (corfu-right-margin-width 0)
  :bind (:map corfu-map
              ("RET" . nil)
              ("TAB" . nil)
              ([remap previous-line] . nil)
              ([remap next-line] . nil)
              ("C-j" . corfu-insert))
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package org-mode
  :mode "\\.org\\'"
  :init
  (require 'org-tempo))

(use-package orderless
 :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (completion-matching-styles '(orderless-regexp)))

(use-package dired
  :commands (dired dired-jump)
  :hook (dired-mode . (lambda () (dired-hide-details-mode 1)))
  :custom
  (dired-listing-switches "-aBhlv  --group-directories-first")
  (dired-dwim-target t))

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  (setq-default treesit-font-lock-level 4))

(use-package magit
  :commands (magit-status))

(use-package diff-hl
  :hook ((dired-mode . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :init
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))

(use-package eglot
  :hook ((c++-mode nix-mode python-mode org-mode cmake-mode) . eglot-ensure)
  :bind (("C-x C-a" . eglot-code-actions)
         ("C-x C-r" . eglot-rename))
  :config
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
  (add-to-list 'eglot-server-programs
               '(org-mode . ("ltex-ls-plus" "--server-type" "TcpSocket" "--port" :autoport)))
  (setq-default eglot-workspace-configuration
                '((:ltex . (:language "fr"
                            :completionEnabled t
                            :disabledRules (:fr ["FRENCH_WHITESPACE"]))))))

(use-package expand-region
  :bind ("C-=" . 'er/expand-region))

(use-package vundo)

(use-package embrace
  :hook ((org-mode . embrace-org-mode-hook)
         (LaTeX-mode . embrace-LaTeX-mode-hook))
  :bind ("C-c s" . embrace-commander))

(use-package vterm
    :hook (vterm-mode . (lambda () (display-line-numbers-mode 0))))

(use-package auto-dark
  :init (auto-dark-mode)
  :custom (auto-dark-themes '((chabam-dark) (chabam-light))))

;; Various modes
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package racket-mode
  :mode "\\.rkt\\'"
  :bind (:map racket-mode-map
              ("C-c C-p" . nil))
  :hook ((racket-mode . (lambda ()
                          (direnv-update-environment)
                          (racket-xp-mode)))))

(use-package direnv
  :config
  (direnv-mode))
