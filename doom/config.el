;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(+workspace/restore-last-session)
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Org/")
(after! org
  (setq org-agenda-files (list "~/Org/work" "~/Org/personal"))
  (setq org-log-done t)
  (setq org-enforce-todo-dependencies t)
  (setq org-hide-emphasis-markers t)
  (setq org-startup-folded t))
(setq org-todo-keywords '((sequence "TODO" "DONE")))

;;
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

(setq py-isort-options '("--profile=black"))

(add-hook! python-mode
  (add-hook 'before-save-hook 'py-isort-before-save))


(setq! company-idle-delay 0.0)
(setq! company-tooltip-idle-delay 0.0)
(setq! company-show-numbers t)
(setq! company-dabbrev-downcase t)
(setq! company-dabbrev-ignore-case t)


(setq! highlight-indent-guides-responsive 'top)

;; I like being able to see my wallpaper. Call me a romantic if you will
(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))

(nyan-mode)
(nyan-start-animation)

;; LSP breaks my autoformaters, so it's disabled for that
(setq +format-with-lsp nil)

(setq company-idle-delay 0.1)
(setq company-tooltip-idle-delay 0.1)

(global-auto-revert-mode t)
;; This make working with parenthesis doable when using multiple cursors
(add-to-list 'evil-mc-incompatible-minor-modes 'smartparens-mode)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
