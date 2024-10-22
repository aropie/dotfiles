;; -*- lexical-binding: t -*-
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq vc-follow-symlinks t)
;; Upstream org needs to be installed before anything else
;; to avoid problems with straight.el
;; https://www.reddit.com/r/emacs/comments/qcj33a/problem_and_workaround_with_orgmode_function/
(straight-use-package 'org)
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
