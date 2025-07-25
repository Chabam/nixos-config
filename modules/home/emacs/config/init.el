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
  :bind (("M-<right>" . 'better-jumper-jump-forward)
         ("M-<left>" . 'better-jumper-jump-backward))
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

(defun chbm-set-fonts ()
  "Set fonts for frame and after theme"
  (when (display-graphic-p)
    (set-face-attribute 'default nil :family "Iosevka" :height 120)
    (set-face-attribute 'fixed-pitch nil :family "Iosevka")
    (set-face-attribute 'variable-pitch nil :family "Iosevka")))

(use-package emacs
  :bind (("C-." . duplicate-line)
         ("M-o" . other-window)
         ("S-M-<up>" . windmove-swap-states-up)
         ("S-M-<down>" . windmove-swap-states-down)
         ("S-M-<left>" . windmove-swap-states-left)
         ("S-M-<right>" . windmove-swap-states-right))
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
  (unless (file-exists-p custom-file)
    (write-region "" nil custom-file))

  ;; Smooth scroll
  (pixel-scroll-precision-mode)
  (pixel-scroll-mode)

  ;; Hiding ui elements
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)

  (windmove-default-keybindings)
  (winner-mode)
  (setq indent-line-function 'insert-tab
        tab-always-indent 'complete
        tab-bar-close-button-show nil
        tab-bar-new-button-show nil
        tab-bar-show 1
        default-frame-alist '((font . "Iosevka-12")
                              (width . 100)
                              (height . 40)
                              (vertical-scroll-bars . nil)))
  (setq whitespace-style '(face indentation tabs tab-mark spaces space-mark
                                newline newline-mark trailing))
  (setq-default standard-indent 4
                tab-width 4
                indent-tabs-mode nil)
  ;; Trying to properly set fonts
  (chbm-set-fonts)
  (advice-add 'load-theme :after #'chbm-set-fonts)
  (add-hook 'after-make-frame-functions
            (lambda (f) (with-selected-frame f (chbm-set-fonts))))
  )

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
              ("RET" . nil))

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package org-mode
  :mode "\\.org\\'"
  :init
  (require 'org-tempo))

(use-package orderless
  :custom
  (completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
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

(use-package c-ts-mode
  :bind ("C-c o" . ff-find-other-file)
  :preface
  (defun chbm-indent-style()
    "Override the built-in BSD indentation style with some additional rules"
    `(
      ((node-is ")") parent-bol 0)
      ((node-is "(") parent-bol 0)
      ((node-is "}") parent-bol 0)
      ((node-is "{") parent-bol 0)
      ((n-p-gp nil nil "namespace_definition") grand-parent 0)
      ((node-is "access_specifier") parent-bol 2)
      ((node-is "field_initializer_list") parent-bol 4)
      ((node-is "field_initializer") (nth-sibling 1) 0)
      ((parent-is "compound_statement") parent-bol c-ts-mode-indent-offset)
      ((node-is "compound_statement") parent-bol 0)
      ((parent-is "parameter_list") parent-bol 4)
      ((parent-is "argument_list") parent-bol 4)

      ,@(alist-get 'bsd (c-ts-mode--indent-styles 'cpp))))
  :init
  (setq-default c-ts-mode-indent-offset 4)
  (setq-default c-ts-mode-indent-style #'chbm-indent-style))

(use-package magit
  :commands (magit-status))

(use-package diff-hl
  :hook ((dired-mode . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :init
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))

(use-package eglot
  :hook ((c++-ts-mode nix-mode python-ts-mode org-mode LaTeX-mode cmake-ts-mode) . eglot-ensure)
  :bind (("C-x C-a" . eglot-code-actions)
         ("C-x C-r" . eglot-rename))
  :config
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
  (add-to-list 'eglot-server-programs
               '((org-mode (LaTeX-mode :language-id "latex")) . ("ltex-ls-plus" "--server-type" "TcpSocket" "--port" :autoport)))
  (setq-default eglot-workspace-configuration
                '((:ltex . (:language "fr"
                            :completionEnabled t
                            :latex (:environments (:lstlisting "ignore")
                                    :commands (:\\lstset{} "ignore"
                                               :\\lstdefinelanguage{}{} "ignore"
                                               :\\lstinputlisting{} "ignore"))
                            :disabledRules (:fr ["FRENCH_WHITESPACE"]))))))

(use-package eglot-inactive-regions
  :custom
  (eglot-inactive-regions-style 'darken-foreground)
  (eglot-inactive-regions-opacity 0.4)
  :config
  (eglot-inactive-regions-mode 1))


(use-package expand-region
  :bind ("C-=" . 'er/expand-region))

(use-package vundo)

(use-package embrace
  :hook ((org-mode . embrace-org-mode-hook)
         (LaTeX-mode . embrace-LaTeX-mode-hook))
  :bind ("C-c s" . embrace-commander))

(use-package vterm)

(use-package auto-dark
  :init (auto-dark-mode)
  :hook ((auto-dark-dark-mode . chbm-set-fonts)
         (auto-dark-light-mode . chbm-set-fonts))
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

(use-package auctex
  :init
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default Tex-master nil))

(use-package haskell-mode
  :mode "\\.hs\\'")

(use-package tramp
  :config
  (setopt tramp-verbose 1)
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))
