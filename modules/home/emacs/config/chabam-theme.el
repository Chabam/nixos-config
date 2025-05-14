(require 'autothemer)
	;; Base 16 dark values
	;; base00: "#161616"
	;; base01: "#262626"
	;; base02: "#393939"
	;; base03: "#525252"
	;; base04: "#dde1e6"
	;; base05: "#f2f4f8"
	;; base06: "#ffffff"
	;; base07: "#08bdba"
	;; base08: "#3ddbd9"
	;; base09: "#78a9ff"
	;; base0A: "#ee5396"
	;; base0B: "#33b1ff"
	;; base0C: "#ff7eb6"
	;; base0D: "#42be65"
	;; base0E: "#be95ff"
	;; base0F: "#82cfff"
	;; base0F: "#37474F"

(autothemer-deftheme
 chabam "A theme remninescent of IBM's carbon theme"

 ((((class color) (min-colors #xFFFFFF)))

 (chabam-foreground     "#FFFFFF")
 (chabam-background     "#161616")
 (chabam-dark-bg        "#000000")
 (chabam-dark-grey      "#262626")
 (chabam-grey           "#393939")
 (chabam-light-grey     "#525252")
 (chabam-pink           "#FF74B8")
 (chabam-light-pink     "#FF4297")
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
 )

 ;; Customize faces
 ((default                      (:foreground chabam-foreground :background chabam-background))
  (region                       (:background chabam-blue-bg))
  (match                        (:background chabam-purple-bg))
  (font-lock-comment-face       (:foreground chabam-light-grey))
  (font-lock-string-face        (:foreground chabam-green))
  (font-lock-type-face          (:foreground chabam-blue))
  (font-lock-function-name-face (:foreground chabam-light-blue))
  (font-lock-variable-name-face (:foreground chabam-light-blue))
  (font-lock-keyword-face       (:foreground chabam-purple))
  (font-lock-constant-face      (:foreground chabam-dark-turquoise))
  (font-lock-preprocessor-face  (:foreground chabam-light-pink))
  (mode-line                    (:foreground chabam-foreground :background chabam-electric-blue))
  (mode-line-inactive           (:foreground chabam-light-grey :background chabam-dark-bg))
  ))

(provide-theme 'chabam)
