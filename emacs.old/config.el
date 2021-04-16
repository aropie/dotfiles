(setq user-emacs-directory "~/.cache/emacs/")
(if (not (file-directory-p user-emacs-directory))
    (make-directory user-emacs-directory t))
(setq auto-save-list-file-prefix user-emacs-directory)
(setq package-user-dir "~/.cache/emacs/elpa")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             '("elpa" . "https://elpa.gnu.org/packages"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)

(defvar better-gc-cons-threshold 67108864 ; 64mb
  "The default value to use for `gc-cons-threshold'.
If you experience freezing, decrease this. If you experience stuttering, increase this.")

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold better-gc-cons-threshold)
	    (setq file-name-handler-alist file-name-handler-alist-original)
	    (makunbound 'file-name-handler-alist-original)))

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (if (boundp 'after-focus-change-function)
		(add-function :after after-focus-change-function
			      (lambda ()
				(unless (frame-focus-state)
				  (garbage-collect))))
	      (add-hook 'after-focus-change-function 'garbage-collect))
	    (defun gc-minibuffer-setup-hook ()
	      (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

      ;; Avoid garbage collect when using minibuffer
	    (defun gc-minibuffer-exit-hook ()
	      (garbage-collect)
	      (setq gc-cons-threshold better-gc-cons-threshold))

	    (add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
	    (add-hook 'minibuffer-exit-hook #'gc-minibuffer-exit-hook)))

(setq-default indent-tabs-mode nil)

(put 'narrow-to-region 'disabled nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq custom-file null-device)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

(setq inhibit-startup-message t)

(setq backup-directory-alist '(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
kept-new-versions 6
kept-old-versions 2
version-control t)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; Make ediff split horizontally instead of vertically
(setq ediff-split-window-function 'split-window-horizontally)

(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))

(setq cursor-in-non-selected-windows nil)

(setq help-window-select t)

(set-face-attribute 'default nil :height 100)

(global-auto-revert-mode t)
(setq auto-revert-use-notify nil)

(fset 'yes-or-no-p 'y-or-n-p)

(server-mode t)

(use-package general
  :ensure t
  :config
  (general-create-definer my-leader
    ;; :prefix my-leader
    :states '(normal insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC")
  (general-create-definer my-local-leader
    ;; prefix local-leader
    :states '(normal insert emacs)
    :prefix "SPC m"
    :non-normal-prefix "M-SPC m")
    (my-local-leader
      "m" '(helm-semantic-or-imenu :which-key "Imenu")))

(use-package persp-mode
  :ensure t
  :custom
  (persp-autokill-buffer-on-remove t)
  (persp-nil-hidden t)
  :config
  (persp-mode t)
  (my-leader
  :infix "TAB"
  "" '(:ignore t :which-key "Persp")
  "TAB" '(persp-switch :which-key "Switch persp")
  "k" '(persp-kill :which-key "Kill persp")
  "r" '(persp-rename get-current-persp :which-key "Rename persp")
  "a" '(persp-add-buffer buffer-name :which-key "Add buffer to persp")))

(with-eval-after-load "persp-mode"
  (add-hook 'persp-before-switch-functions
            #'(lambda (new-persp-name w-or-f)
                (let ((cur-persp-name (safe-persp-name (get-current-persp))))
                  (when (member cur-persp-name persp-names-cache)
                    (setq persp-names-cache
                          (cons cur-persp-name
                                (delete cur-persp-name persp-names-cache)))))))

  (add-hook 'persp-renamed-functions
            #'(lambda (persp old-name new-name)
                (setq persp-names-cache
                      (cons new-name (delete old-name persp-names-cache)))))

  (add-hook 'persp-before-kill-functions
            #'(lambda (persp)
                (setq persp-names-cache
                      (delete (safe-persp-name persp) persp-names-cache))))

  (add-hook 'persp-created-functions
            #'(lambda (persp phash)
                (when (and (eq phash *persp-hash*)
                           (not (member (safe-persp-name persp)
                                        persp-names-cache)))
                  (setq persp-names-cache
                        (cons (safe-persp-name persp) persp-names-cache))))))

(add-to-list 'persp-created-functions
	     '(lambda (persp phash)
		(persp-add-buffer (get-buffer-create "*scratch*") persp)))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("M-y" . helm-show-kill-ring))
  :custom
  (helm-split-window-in-side-p t)
  (helm-move-to-line-cycle-in-source t)
  (helm-ff-search-library-in-sexp t)
  (helm-scroll-amount 8)
  (helm-ff-file-name-history-use-recentf t)
  (helm-echo-input-in-header-line t)
  (helm-autoresize-min-height 0)
  (helm-autoresize-max-height 20)
  (helm-M-x-fuzzy-match t)
  (helm-semantic-fuzzy-match t)
  (helm-imenu-fuzzy-match t)
  :config
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (helm-mode t))

(defun get-scratch-buffer nil
       "create a scratch buffer"
       (interactive)
       (switch-to-buffer (get-buffer-create "*scratch*"))
       (lisp-interaction-mode))

(my-leader
  :infix "f"
  "" '(:ignore t :which-key "File")
  "f" '(helm-find-files :which-key "Find file")
  "s" '(save-buffer :which-key "Save file")
  "u" '(:ignore t :which-key "Sudo find file (TBD)")
  "U" '(:ignore t :which-key "Sudo this file (TBD)")
  "R" '(:ignore t :which-key "Rename/move this file (TBD)"))

(my-leader
:infix "b"
"" '(:ignore t :which-key "Buffer")
"b" '(persp-switch-to-buffer :which-key "Switch to workspace buffer")
"B" '(switch-to-buffer :which-key "Switch to buffer")
"i" '(ibuffer :which-key "ibuffer")
"k" '(kill-this-buffer :which-key "Kill buffer")
"r" '(revert-buffer :which-key "Revert buffer")
"n" '(next-buffer :which-key "Next buffer")
"p" '(previous-buffer :which-key "Previous buffer")
"e" '(set-buffer-file-coding-system :which-key "Set buffer coding system"))
(my-leader
"," '(persp-switch-to-buffer :which-key "Switch to workspace buffer"))

(my-leader
:infix "t"
"" '(:ignore t :which-key "Toggle")
"l" '(global-linum-mode :which-key "Line numbers")
"r" '(read-only-mode :which-key "Read only mode")
"w" '(whitespace-mode :which-key "Whitespace mode")
"t" '(org-pomodoro :which-key "Pomodoro timer")
"p" '(presentation-mode :which-key "Presentation mode"))

(my-leader
:infix "o"
"" '(:ignore t :which-key "Open")
"d" '(dired-jump :which-key "Dired")
"s" '(get-scratch-buffer :which-key "Scratch"))

(my-leader
  :infix "h"
  "" '(:ignore t :which-key "Help")
  "a" '(apropos-command :which-key "Apropos")
  "k" '(describe-key :which-key "Key")
  "f" '(describe-function :which-key "Function")
  "m" '(describe-mode :which-key "Mode")
  "b" '(describe-bindings :which-key "Bindings")
  "v" '(describe-variable :which-key "Variable"))

(defun aropie/emacs-config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(defun aropie/i3-config-visit ()
  (interactive)
  (find-file "~/.config/i3/config"))
(defun aropie/keybindings-config-visit ()
  (interactive)
  (find-file "~/.config/sxhkd/sxhkdrc"))
(defun aropie/zsh-config-visit ()
  (interactive)
  (find-file "~/.zshrc"))
(defun aropie/xinit-config-visit ()
  (interactive)
  (find-file "~/.xinitrc"))
(defun aropie/emacs-config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(my-leader
  :infix "c"
  "" '(:ignore t :which-key "Config")
  "e" '(aropie/emacs-config-visit :which-key "emacs")
  "i" '(aropie/i3-config-visit :which-key "i3")
  "z" '(aropie/zsh-config-visit :which-key "zsh")
  "k" '(aropie/keybindings-config-visit :which-key "keybindings")
  "x" '(aropie/xinit-config-visit :which-key "xinitrc")
  "r" '(aropie/emacs-config-reload :which-key "Reload emacs config"))

(use-package pdf-tools
  :ensure t
  :defer t
  :custom
  (pdf-view-display-size 'fit-page)
  :config
  (pdf-tools-install))

(defun set-no-process-query-on-exit ()
  (let ((proc (get-buffer-process (current-buffer))))
    (when (processp proc)
      (set-process-query-on-exit-flag proc nil))))

(add-hook 'term-exec-hook 'set-no-process-query-on-exit)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :init
  (setq which-key-idle-delay 1)
  (which-key-mode)
  :delight)

(use-package delight
  :ensure t)

(use-package undo-tree
  :ensure t
  :delight)

(use-package hydra
  :ensure t)

(use-package projectile
  :ensure t
  :custom
  (projectile-indexing-method 'alien)
  (projectile-enable-caching t)
  (projectile-completion-system 'helm)
  :config
  (add-to-list 'projectile-globally-ignored-directories ".venv")
  (projectile-mode t)
  (my-leader
  :infix "p"
  "" '(:ignore t :which-key "Project")
  "f" '(projectile-find-file :which-key "Find file")
  "F" '(projectile-find-file-other-window :which-key "Find file (other window)")
  "b" '(projectile-switch-to-buffer :which-key "Switch to buffer")
  "B" '(projectile-switch-to-buffer-other-window :which-key "Switch to buffer (other window)")
  "k" '(projectile-kill-buffers :which-key "Kill all project buffers")
  "p" '(projectile-switch-project :which-key "Switch to project")
  "t" '(projectile-toggle-between-implementation-and-test :which-key "Toggle between test and implementation")
  "T" '(projectile-test-project :which-key "Run project's tests")
  "a" '(projectile-add-known-project :which-key "Add bookmark to project")
  "r" '(projectile-replace :which-key "Replace in project")
  "c" '(projectile-invalidate-cache :which-key "Clear project's cache")
  "s" '(projectile-grep :which-key "Search in project")))

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package verb
  :ensure t
  :defer t
  :config

  (my-leader
    :infix "v"
    "" '(:ignore t :which-key "Verb")
    "v" '(verb-send-request-on-point :which-key "Send request on point")
    "h" '(verb-toggle-show-headers :which-key "Toggle headers")
    "r" '(verb-re-send-request :which-key "Re-send previous request")
    "e" '(verb-export-request-on-point :which-key "Export request")))

(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
	      ("/" . dired-narrow-fuzzy)))

(use-package lsp-mode
  :ensure t
  :custom
  (lsp-prefer-capf t)
  :hook ((python-mode . lsp)
         (go-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode
  :ensure t
  :config
  (lsp-ui-doc-mode nil))
(use-package helm-lsp :commands helm-lsp-workspace-symbol :ensure t)

(use-package presentation
  :ensure t)

(use-package company
  :ensure t
  :delight
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company--dabbrev-code-everywhere t)
  (company-dabbrev-downcase nil)
  (company-dabbrev-ignore-case t)
  (company-tooltip-align-annotations t)
  (company-frontends
   '(company-tng-frontend
     company-pseudo-tooltip-frontend
     company-echo-metadata-frontend))
  (global-company-mode t)
  :config
  (company-tng-configure-default))

(use-package company-jedi
  :ensure t
  :after (company)
  :config
  (add-to-list 'company-backends 'company-jedi))

(use-package company-go
  :ensure t
  :after company
  :config
  (add-hook 'go-mode-hook
	    (lambda ()
	      (add-to-list 'company-backends 'company-go))))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (add-to-list 'evil-collection-key-blacklist "SPC")
  (evil-collection-init '(dired magit help log-view pdf)))

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode t)
  :delight)

(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode t))

(use-package evil-args
  :ensure t
  :config
  ;; bind evil-args text objects
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

  ;; bind evil-forward/backward-args
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg))

(use-package evil-exchange
:ensure t
:config
(evil-exchange-install))

(use-package evil-mc
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'evil-mc-mode)
  (add-hook 'text-mode-hook 'evil-mc-mode))

(electric-pair-mode 1)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :delight)

(use-package smart-tabs-mode
  :ensure t
  :init
  (smart-tabs-insinuate 'c 'javascript 'ruby))

(use-package yasnippet
  :ensure t
  :custom
  yas-triggers-in-field t
  :config
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package paredit
  :ensure t)

(global-set-key (kbd "M--") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(use-package spacemacs-common
    :ensure spacemacs-theme
    :config (load-theme 'spacemacs-dark t))

(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode)
      :custom
      (doom-modeline-buffer-file-name-style 'truncate-with-project)
      :config
      (set-face-attribute 'doom-modeline-evil-normal-state nil :foreground "skyblue2")
      (set-face-attribute 'doom-modeline-evil-insert-state nil :foreground "green"))

(use-package all-the-icons
  :ensure t)

(setq evil-emacs-state-cursor '("red" bar))
(setq evil-normal-state-cursor '("skyblue2" box))
(setq evil-visual-state-cursor '("gray" box))
(setq evil-insert-state-cursor '("green" bar))
(setq evil-replace-state-cursor '("red" hollow))
(setq evil-operator-state-cursor '("red" hollow))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(show-paren-mode t)

(use-package highlight-indent-guides
  :ensure t
  :delight
  :config
  (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-method 'character)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(global-hl-line-mode t)

(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-mode))

(setq prettify-symbols-unprettify-at-point 'right-edge)
(setq inhibit-compacting-font-caches t)

(add-hook 'prog-mode-hook
	  (lambda ()
	    (push '("!=" . ?≠) prettify-symbols-alist)
	    (push '("<=" . ?≤) prettify-symbols-alist)
	    (push '(">=" . ?≥) prettify-symbols-alist)
	    (push '("=>" . ?⇒) prettify-symbols-alist)))

(add-hook 'python-mode-hook
	  (lambda ()
	    (push '("def"    . ?ƒ) prettify-symbols-alist)
	    (push '("sum"    . ?Σ) prettify-symbols-alist)
	    (push '("**2"    . ?²) prettify-symbols-alist)
	    (push '("**3"    . ?³) prettify-symbols-alist)
	    (push '("None"   . ?∅) prettify-symbols-alist)
	    (push '("in"     . ?∈) prettify-symbols-alist)
	    (push '("not in" . ?∉) prettify-symbols-alist)
	    (push '("return" . ?➡) prettify-symbols-alist)
	    (prettify-symbols-mode t)))

(setq vc-follow-symlinks t)

(use-package avy
  :ensure t
  :custom
  (avy-background t)
  (avy-all-windows t)
  :config
  (defun aropie/avy-jump-to-char-in-one-window()
    (interactive)
    (setq current-prefix-arg '(4)) ; C-u
    (call-interactively 'avy-goto-char))

  (general-define-key
   :keymaps 'override
   "C-;" 'aropie/avy-jump-to-char-in-one-window
   "C-:" 'avy-goto-line)

  (my-leader
  "SPC" '(aropie/avy-jump-to-char-in-one-window :which-key "Jump to char"))

  (my-leader
    :infix "j"
    "" '(:ignore t :which-key "Jump")
    "w" '(avy-goto-subword-1 :which-key "Jump to word")
    "l" '(avy-goto-line :which-key "Jump to line")
    "c" '(avy-goto-char :which-key "Jump to char")
    "m" '(:ignore t :which-key "Move...")
    "ml" '(avy-move-line :which-key "Move line")
    "mr" '(avy-move-region :which-key "Move region")
    "y" '(:ignore t :which-key "Yank...")
    "yl" '(avy-copy-line :which-key "Yank line")
    "yr" '(avy-copy-region :which-key "Yank region")
    "k" '(:ignore t :which-key "Kill...")
    "kr" '(avy-kill-region :which-key "Kill region between lines")
    "kl" '(avy-kill-whole-line :which-key "Kill line")))

(use-package ace-window
  :ensure t
  :custom
  (aw-scope 'frame)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(defhydra hydra-window-resize (:color pink)
  "Resize window"
  ("k" evil-window-increase-height "up")
  ("j" evil-window-decrease-height "down")
  ("h" evil-window-decrease-width "left")
  ("l" evil-window-increase-width "right")
  ("=" balance-windows "balance")
  ("o" ace-window "change window")
  ("q" nil "quit" :color blue))

(general-define-key
    :states '(normal insert emacs)
    :keymaps 'override
    "C-w C-w" 'ace-window)
(my-leader
:infix "w"
    "" '(:ignore t :which-key "Windows")
    "w" '(ace-window :which-key "Change window")
    "s" '(ace-swap-window :which-key "Swap windows")
    "o" '(delete-other-windows :which-key "Delete other windows")
    "x" '(ace-delete-window :which-key "Delete window")
    "h" '(split-window-vertically :which-key "Split window horizontally")
    "v" '(split-window-horizontally :which-key "Split window vertically")
    "r" '(hydra-window-resize/body :which-key "Resize windows"))

(use-package dumb-jump
  :ensure t
  :custom
  (dumb-jump-use-visible-window nil)
  :config
  (my-leader
    :infix "d"
    "" '(:ignore t :which-key "Definition")
    "j" '(dumb-jump-go :which-key "Jump to definition")
    "o" '(dumb-jump-go-other-window :which-key "Jump to definition on the other window")
    "l" '(dumb-jump-quick-look :which-key "Look at definition on tooltip")
    "b" '(dumb-jump-back :which-key "Jump back to previous-to-jump position")))

(use-package evil-snipe
  :ensure t
  :config
  ;; Evil-snipe conflicts with Magit
  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
  (evil-snipe-mode t)
  (evil-snipe-override-mode t))

(use-package magit
  :ensure t
  :config)

(use-package git-timemachine
  :after hydra
  :ensure t
  :config
  (defhydra hydra-timemachine (:color pink)
    "Time machine"
    ("n" git-timemachine-show-next-revision "next")
    ("p" git-timemachine-show-previous-revision "previous")
    ("c" git-timemachine-show-current-revision "current")
    ("b" git-timemachine-blame "blame")
    ("s" git-timemachine-switch-branch "switch branch")
    ("q" (kill-matching-buffers "timemachine" t t) "quit" :color blue))

  (add-hook 'git-timemachine-mode-hook
	    (lambda () (hydra-timemachine/body))))

(my-leader
  :infix "g"
  "" '(:ignore t :which-key "Git")
  "g" '(magit-status :which-key "Status")
  "m" '(magit-dispatch-popup :which-key "Menu")
  "c" '(magit-clone :which-key "Clone")
  "b" '(magit-branch :which-key "Branch")
  "B" '(magit-blame :which-key "Blame")
  "l" '(magit-log :which-key "Log")
  "F" '(magit-pull :which-key "Pull")
  "t" '(git-timemachine :which-key "Travel through time"))

(setq org-src-window-setup 'current-window)
(setq org-log-done t)
(setq org-enforce-todo-dependencies t)
(setq org-hide-emphasis-markers t)

(setq org-agenda-files '("~/Org/work.org"))

(use-package org-bullets
   :ensure t
   :config
   (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(use-package org-pomodoro
  :ensure t
  :config
  (setq org-pomodoro-ticking-sound-p t)
  (setq org-pomodoro-ticking-sound-states '(:pomodoro)))

(use-package ox-twbs
  :ensure t)

(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/org/refile.org")

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
				 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

(use-package go-mode
  :ensure t)

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
  (add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
  :config
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-quoting t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-engine-detection t)
  (setq web-mode-enable-css-colorization t))

(setq python-shell-interpreter "python3")

(use-package py-isort
  :ensure t
  :after python
  :config
  (setq py-isort-options '("--profile black"))
  :hook ((before-save . py-isort-before-save)))

(use-package sphinx-doc
  :ensure t
  :custom
  (flycheck-python-flake8-executable "flake8")
  :config
  (add-hook 'python-mode-hook (lambda ()
				(require 'sphinx-doc)
				(sphinx-doc-mode t)))
  (my-local-leader
    :states 'normal
    :keymaps 'python-mode-map
    "d" '(sphinx-doc :which-key "Generate doc")))

(use-package blacken
  :config
  (add-hook 'python-mode-hook 'blacken-mode))

(use-package slime
  :ensure t
  :config
(progn
     (setq slime-lisp-implementations
	   '((sbcl ("/usr/bin/sbcl"))
	     (ecl ("/usr/bin/ecl"))
	     (clisp ("/usr/bin/clisp"))))
     (slime-setup '(
		    slime-asdf
		    slime-autodoc
		    slime-editing-commands
		    slime-fancy-inspector
		    slime-fontifying-fu
		    slime-fuzzy
		    slime-indentation
		    slime-mdot-fu
		    slime-package-fu
		    slime-references
		    slime-repl
		    slime-sbcl-exts
		    slime-scratch
		    slime-xref-browser
		    ))
     (slime-autodoc-mode)
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function
  'slime-fuzzy-complete-symbol)))

(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  (add-hook 'clojure-mode-hook 'subword-mode)

  ;; syntax hilighting for midje
  (add-hook 'clojure-mode-hook
            (lambda ()
              (setq inferior-lisp-program "lein repl")
              (font-lock-add-keywords
               nil
               '(("(\\(facts?\\)"
                  (1 font-lock-keyword-face))
                 ("(\\(background?\\)"
                  (1 font-lock-keyword-face))))
              (define-clojure-indent (fact 1))
              (define-clojure-indent (facts 1))
              (rainbow-delimiters-mode t))))

(use-package clojure-mode-extra-font-locking
  :ensure t)

(use-package cider
  :ensure t
  :custom
  ;; go right to the REPL buffer when it's finished connecting
  (cider-repl-pop-to-buffer-on-connect t)
  ;; When there's a cider error, show its buffer and switch to it
  (cider-show-error-buffer t)
  (cider-auto-select-error-buffer t)
  ;; Where to store the cider history.
  (cider-repl-history-file "~/.cache/emacs/cider-history")
  ;; Wrap when navigating history.
  (cider-repl-wrap-history t)
  :config
  (add-hook 'cider-repl-mode-hook 'paredit-mode))

(use-package nyan-mode
  :ensure t
  :init
  (nyan-mode)
  (nyan-start-animation))

(use-package fireplace
  :ensure t
  :disabled
  :init
  (run-with-idle-timer 600 t 'fireplace ()))
