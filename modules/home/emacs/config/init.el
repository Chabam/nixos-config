(load-file "~/.emacs.d/chabam-light-theme.el")
(load-file "~/.emacs.d/chabam-dark-theme.el")

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
  :custom
  (custom-file "~/.emacs.d/custom.el")
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  (backup-directory-alist '(("." . "~/.emacs.d/backups")))
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
  :hook (prog-mode . (lambda () (setq show-trailing-whitespace t)))
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
  (set-face-attribute 'default nil :height 110 :family "IosevkaTerm Nerd Font")
  (load-theme 'chabam-dark t)

  (setq-default standard-indent 4)
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil)
  (setq indent-line-function 'insert-tab)
  )

(use-package orderless
 :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

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

;; Various modes
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package direnv
  :config
  (direnv-mode))
