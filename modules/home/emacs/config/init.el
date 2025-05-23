(load-file "~/.emacs.d/chabam-light-theme.el")
(load-file "~/.emacs.d/chabam-dark-theme.el")

(defun disable-line-numbers ()
    (display-line-numbers-mode -1))

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

;; Emacs minibuffer configurations.
(use-package emacs
  :bind (("C-." . duplicate-line)
         ("M-o" . other-window)
         ("C-S-j" . join-line))
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
  :hook ((prog-mode . (lambda () (setq show-trailing-whitespace t)))
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

  ;; Showing line numbers
  (global-display-line-numbers-mode)
  (global-visual-line-mode)
  (column-number-mode)
  (windmove-default-keybindings)
  (setq indent-line-function 'insert-tab
        default-frame-alist '((font . "Iosevka-12")
                              (width . 100)
                              (height . 40)))
  (setq-default standard-indent 4
                tab-width 4
                indent-tabs-mode nil
                display-line-numbers-type 'relative)
  (set-frame-font "Iosevka 12" nil t)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka"))

(use-package compile
  :hook (compilation-mode . disable-line-numbers)
  :init
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter))

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
  (completion-matching-styles '(orderless-regexp))
  )

(use-package dired
  :commands (dired dired-jump)
  :hook (dired-mode . (lambda () (dired-hide-details-mode 1)))
  :custom
  (dired-listing-switches "-aBhlv  --group-directories-first")
  (dired-dwim-target t))

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package magit
  :commands (magit-status))

(use-package diff-hl
  :hook (dired-mode . diff-hl-dired-mode)
  :config
  (global-diff-hl-mode))

(use-package eglot
  :hook ((c++-mode nix-mode python-mode org-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(org-mode . ("ltex-ls-plus" "--server-type" "TcpSocket" "--port" :autoport)))
  (setq-default eglot-workspace-configuration
                '((:ltex . (:language "auto"
                            :completionEnabled t
                            :disabledRules (:fr ["FRENCH_WHITESPACE"]))))))

(use-package expand-region
  :bind ("C-=" . 'er/expand-region))

(use-package vundo)

(use-package embrace
  :hook ((org-mode . embrace-org-mode-hook)
         (tex-mode . embrace-tex-mode-hook))
  :bind ("C-'" . embrace-commander)
  )

(use-package visual-regexp
  :bind
    ("C-c r" . 'vr/replace)
    ("C-c q" . 'vr/query-replace))

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
  :hook ((racket-mode . (lambda ()
                          (direnv-update-environment)
                          (racket-xp-mode)))
         (racket-repl-mode . disable-line-numbers))
  )

(use-package direnv
  :config
  (direnv-mode))
