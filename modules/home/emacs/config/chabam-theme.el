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

 (chabam-foreground "#FFFFFF")
 (chabam-background "#161616"))

 ;; Customize faces
 ((default (:foreground chabam-foreground :background chabam-background))))

(provide-theme 'chabam)
