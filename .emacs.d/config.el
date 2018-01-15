
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(toggle-frame-fullscreen)

(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

(setq inhibit-startup-message t)

(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)
(display-time-mode t)

(setq backup-directory-alist '(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
kept-new-versions 6
kept-old-versions 2
version-control t)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'evil-relative-linum)

(global-hl-line-mode t)

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(use-package disable-mouse
  :ensure t
  :init
  (global-disable-mouse-mode t)
  :config
  (fset 'evil-mouse-drag-region 'ignore))

(setq org-src-window-setup 'current-window)
(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(use-package org-bullets
   :ensure t
   :config
   (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(use-package org-pomodoro
  :ensure t)

(when window-system (global-prettify-symbols-mode t))

;; (setq electric-pair-preserve balance nil)
;; (setq electric-pair-delete-adjacent-pairs nil)
 (electric-pair-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(show-paren-mode t)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode t)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

(use-package ido-yes-or-no
  :ensure t
  :init
  (ido-yes-or-no-mode t))

(use-package ido-grid-mode
  :ensure t
  :init
  (ido-grid-mode t))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10))))

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :delight)

(use-package rainbow-mode
  :ensure t
  :init (rainbow-mode t))

(use-package ace-window
  :ensure t)
(defvar aw-dispatch-alist
  '((?x aw-delete-window " Ace - Delete Window")
    (?s aw-swap-window " Ace - Swap Window")
    (?n aw-flip-window)
    (?c aw-split-window-fair " Ace - Split Fair Window")
    (?v aw-split-window-vert " Ace - Split Vert Window")
    (?h aw-split-window-horz " Ace - Split Horz Window")
    (?i delete-other-windows " Ace - Maximize Window")
    (?o delete-other-windows))
  "List of actions for `aw-dispatch-default'.")

(use-package evil-avy
  :ensure t
  :init (evil-avy-mode t))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package delight
  :ensure t
  :init
  (delight '((company-mode)
             (which-key-mode)
             (rainbow-mode)
             (evil-commentary-mode)
             (flycheck-mode)
             (undo-tree-mode))))

(use-package fancy-battery
  :ensure t
  :init
  (fancy-battery-mode t))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :delight)

(use-package undo-tree
  :ensure t
  :delight)

(use-package web-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-engine-detection t))

(use-package pdf-tools
  :ensure t)

(use-package evil
  :ensure t
  :init (evil-mode 1)
  :config
  (fset 'evil-mouse-drag-region 'ignore))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote wave))
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (spaceline-spacemacs-theme))

(setq evil-emacs-state-cursor '("red" bar))
(setq evil-normal-state-cursor '("orange" box))
(setq evil-visual-state-cursor '("gray" box))
(setq evil-insert-state-cursor '("green" bar))
(setq evil-replace-state-cursor '("red" hollow))
(setq evil-operator-state-cursor '("red" hollow))

(use-package evil-leader
  :ensure t
  :init
  (setq evil-leader/in-all-states 1)
  (global-evil-leader-mode)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   "<SPC>" 'avy-goto-char'
   "TAB" 'mode-line-other-buffer'
   "f" 'find-file
   "k" 'kill-this-buffer
   "w" 'save-buffer
   "b" 'ido-switch-buffer
   "c" 'config-visit
   "r" 'config-reload
   "o" 'ace-window
   "0" 'delete-window
   "1" 'delete-other-windows
   "2" 'split-window-vertically
   "3" 'split-window-horizontally))

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode t)
  :delight)

(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode t))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))
