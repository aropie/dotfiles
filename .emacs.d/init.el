(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-begin-commands (quote (self-insert-command)))
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(company-tooltip-align-annotations t)
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(global-company-mode t)
 '(package-selected-packages
   (quote
    (avy ## eyebrowse general spaceline highlight-indent-guides smart-tabs-mode pdf-tools persp-mode markdown-mode adafruit-wisdom try magit diminish company rainbow-delimiters evil smex ido-vertical-mode org-bullets which-key use-package)))
 '(powerline-default-separator (quote wave))
 '(spaceline-highlight-face-func (quote spaceline-highlight-face-evil-state) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
