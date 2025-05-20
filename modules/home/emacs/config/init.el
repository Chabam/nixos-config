(load-file "~/.emacs.d/chabam-light-theme.el")
(load-file "~/.emacs.d/chabam-dark-theme.el")

(defun disable-line-numbers ()
    (display-line-numbers-mode -1))

(use-package vertico
  :custom
  (vertico-count 10)
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :bind (("C-." . duplicate-line)
         ("C-M-i" . completion-at-point))

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

  (completion-styles '(basic substring partial-completion flex))
  (vc-follow-symlinks t)
  (tab-always-indent 'complete)
  (read-extended-command-predicate #'command-completion-default-include-p)
  :hook (prog-mode . (lambda () (setq show-trailing-whitespace t)))
  :config (require 'ansi-color)
  :init
  ;; Smooth scroll
  (pixel-scroll-precision-mode)
  (pixel-scroll-mode)

  ;; Hiding ui elements
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)

  ;; Showing line numbers
  (global-display-line-numbers-mode)
  (global-visual-line-mode)
  (column-number-mode)
  (setq-default display-line-numbers-type 'relative)
  (load-theme 'chabam-dark t)
  (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

  (setq-default standard-indent 4)
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil)
  (setq indent-line-function 'insert-tab)
  (setq default-frame-alist '((font . "Iosevka-12")))
  (set-frame-font "Iosevka 12" nil t)
  )

(use-package compile
  :hook (compilation-mode . disable-line-numbers)
  :init
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (tab-always-indent 'complete)
  (corfu-quit-no-match 'separator)
  (corfu-preselect-first f)
  :hook ((prog-mode shell-mode eshell-mode) . corfu-mode)
  :init
  (global-corfu-mode)
  )

(use-package orderless
 :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  (orderless-matching-styles '(orderless-initialism orderless-flex orderless-regexp))
  )

(use-package dired
  :commands (dired dired-jump)
  :hook (dired-mode . (lambda () (dired-hide-details-mode 1)))
  :init
  (setq dired-listing-switches "-aBhlv  --group-directories-first"))

(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package eglot
  :hook ((c++-mode nix-mode racket-mode python-mode) . eglot-ensure)
  )

(use-package multiple-cursors
    :bind ("C-S-c C-S-c" . 'mc/edit-lines)
          ("C-<" . 'mc/mark-previous-like-this)
          ("C->" . 'mc/mark-next-like-this)
          ("C-c C->" . 'mc/mark-all-like-this))

(use-package expand-region
  :bind ("C-=" . 'er/expand-region))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1)
  (sp-pair "(" ")" :unless nil)
  (sp-pair "[" "]" :unless nil)
  (sp-pair "{" "}" :unless nil)
  (sp-pair "\"" "\"" :unless nil)
  (sp-pair "'" "'" :unless nil)
  :bind ("C-c s r" . sp-rewrap-sexp)
        ("C-c s e" . sp-change-enclosing)
  :init
  (setq sp-autoinsert-pair nil))

(use-package visual-regexp
  :bind
    ("C-c r" . 'vr/replace)
    ("C-c q" . 'vr/query-replace)
    ("C-c m" . 'vr/mc-mark))

(use-package vterm
    :hook (vterm-mode . (lambda () (display-line-numbers-mode 0))))

;; Various modes
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package racket-mode
  :mode "\\.rkt\\'"
  :hook (racket-repl-mode . disable-line-numbers)
  )

(use-package direnv
  :config
  (direnv-mode))
