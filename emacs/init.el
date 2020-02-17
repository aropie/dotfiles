;; Many modes store their cache files in =~/.emacs.d=. I prefer to keep
;; those files in =~/.cache/emacs=
(setq user-emacs-directory "~/.cache/emacs/")
(if (not (file-directory-p user-emacs-directory))
    (make-directory user-emacs-directory t))
(setq auto-save-list-file-prefix user-emacs-directory)
(setq package-user-dir "~/.cache/emacs/elpa")

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
