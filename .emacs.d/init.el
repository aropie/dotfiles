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
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (which-key web-mode use-package try spacemacs-theme spaceline smex relative-line-numbers rainbow-mode rainbow-delimiters racket-mode pretty-mode pdf-tools ox-twbs org-pomodoro org-bullets nyan-mode mode-icons markdown-mode magit indent-guide ido-yes-or-no ido-grid-mode haskell-mode flycheck fireplace fancy-battery evil-surround evil-org evil-nerd-commenter evil-leader evil-easymotion evil-commentary evil-avy emms disable-mouse delight dashboard company-quickhelp company-jedi auto-complete aggressive-indent adafruit-wisdom ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
