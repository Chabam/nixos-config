(deftheme chabam-dark
  "My custom inspired by Oxocarbon dark mode")

(let (
      (chabam-foreground     "#FFFFFF")
      (chabam-background     "#161616")
      (chabam-dark-bg        "#000000")
      (chabam-dark-grey      "#262626")
      (chabam-grey           "#393939")
      (chabam-light-grey     "#525252")
      (chabam-light-pink     "#FF74B8")
      (chabam-pink           "#FF4297")
      (chabam-green          "#00C15A")
      (chabam-blue           "#00B4FF")
      (chabam-light-blue     "#66D1FF")
      (chabam-turquoise      "#00dfdb")
      (chabam-dark-turquoise "#00c1bb")
      (chabam-purple         "#C693FF")
      (chabam-blue-bg        "#1d293f")
      (chabam-purple-bg      "#554272")
      (chabam-orange         "#FF6300")
      (chabam-electric-blue  "#0064ff")
      (chabam-red            "#990000"))

  (custom-theme-set-variables
   'chabam-dark
   '(frame-background mode (quote dark)))


  (custom-theme-set-faces
   'chabam-dark
   ;; Generic styling
   `(default                            ((t (:foreground ,chabam-foreground :background ,chabam-background))))
   `(highlight                          ((t (:background ,chabam-purple-bg))))
   `(region                             ((t (:background ,chabam-blue-bg))))
   `(match                              ((t (:background ,chabam-purple-bg))))
   `(mode-line                          ((t (:foreground ,chabam-foreground :background ,chabam-electric-blue))))
   `(mode-line-inactive                 ((t (:foreground ,chabam-light-grey :background ,chabam-dark-bg))))
   `(line-number                        ((t (:foreground ,chabam-light-grey))))
   `(border                             ((t (:foreground ,chabam-dark-bg))))
   `(vertical-border                    ((t (:foreground ,chabam-dark-bg))))
   `(cursor                             ((t (:background ,chabam-pink))))
   `(fringe                             ((t (:background ,chabam-background))))
   `(minibuffer-prompt                  ((t (:foreground ,chabam-purple))))
   `(lazy-highlight                     ((t (:background ,chabam-blue-bg))))
   `(isearch                            ((t (:background ,chabam-purple-bg))))
   `(isearch-fail                       ((t (:background ,chabam-red))))
   `(query-replace                      ((t (:background ,chabam-blue-bg))))
   `(secondary-selection                ((t (:background ,chabam-blue-bg))))
   `(show-paren-match                   ((t (:foreground ,chabam-pink :bold t))))
   `(show-paren-mismatch                ((t (:foreground ,chabam-red :bold t))))
   `(button                             ((t (:foreground ,chabam-blue :underline t))))

   ;; Help styling
   `(help-key-binding                   ((t (:foreground ,chabam-dark-turquoise :background ,chabam-dark-bg, :bold t))))
   `(trailing-whitespace                ((t (:background ,chabam-red))))
   `(link                               ((t (:foreground ,chabam-light-blue :underline t))))
   `(visited-link                       ((t (:foreground ,chabam-purple :underline t))))
   `(eldoc-highlight-function-argument  ((t (:background ,chabam-purple-bg :bold t))))

   ;; Programming syntax styling
   `(font-lock-builtin-face             ((t (:foreground ,chabam-purple))))
   `(font-lock-comment-face             ((t (:foreground ,chabam-light-grey))))
   `(font-lock-string-face              ((t (:foreground ,chabam-green))))
   `(font-lock-type-face                ((t (:foreground ,chabam-blue))))
   `(font-lock-function-name-face       ((t (:foreground ,chabam-light-blue))))
   `(font-lock-variable-name-face       ((t (:foreground ,chabam-light-blue))))
   `(font-lock-keyword-face             ((t (:foreground ,chabam-purple))))
   `(font-lock-constant-face            ((t (:foreground ,chabam-dark-turquoise))))
   `(font-lock-preprocessor-face        ((t (:foreground ,chabam-light-pink))))
   ;; 1st party styling
   `(dired-header                       ((t (:foreground ,chabam-blue))))
   `(dired-directory                    ((t (:foreground ,chabam-dark-turquoise))))
   `(dired-symlink                      ((t (:foreground ,chabam-light-pink))))
   `(apropos-symbol                     ((t (:foreground ,chabam-pink))))

   ;; 3rd party styling
   `(vertico-current                    ((t (:background ,chabam-dark-grey))))
   `(completions-common-part            ((t (:foreground ,chabam-light-pink))))
   `(orderless-match-face-0             ((t (:foreground ,chabam-light-pink))))
   `(git-gutter:added                   ((t (:foreground ,chabam-green))))
   `(git-gutter:removed                 ((t (:foreground ,chabam-red))))
   `(git-gutter:modified                ((t (:foreground ,chabam-light-blue))))
   ))

(provide-theme 'chabam-dark)
