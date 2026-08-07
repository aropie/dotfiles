;; -*- lexical-binding: t -*-
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq straight-package--warning-displayed t)

(setq vc-follow-symlinks t)
;; Upstream org needs to be installed before anything else
;; to avoid problems with straight.el
;; https://www.reddit.com/r/emacs/comments/qcj33a/problem_and_workaround_with_orgmode_function/
(straight-use-package 'org)
(setq straight-use-package-by-default t)

;; Taken from https://emacs.stackexchange.com/a/84607
(defun my/ensure-lexical-binding-cookie()
  (when (derived-mode-p 'emacs-lisp-mode)
	(goto-char(point-min)) ;; beginning of tangled code
	(insert ";; -*- coding: utf-8; lexical-binding:t -*-")
	(newline)
	(newline)
	(let ((inhibit-message t))
	  (basic-save-buffer))))
(add-hook 'org-babel-post-tangle-hook #'my/ensure-lexical-binding-cookie)

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
