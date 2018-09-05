;; setup evil
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; setup package
(require 'package)
(setq package-list '(helm-projectile vue-mode mmm-mode company robe enh-ruby-mode rspec-mode flycheck helm magit seti-theme projectile))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("MELPA Stable" . "http://stable.melpa.org/packages/") t)

(unless package--initialized (package-initialize t))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; UI
(setq ring-bell-function 'ignore)
(menu-bar-mode 1)
(tool-bar-mode -1)
(setq inhibit-startup-screen 1)
(global-linum-mode)
(set-face-foreground 'linum "#AAAAAA")
(setq dired-use-ls-dired nil)

;; Setup theme
(load-theme 'seti t)

;; Set default font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 150
                    :weight 'normal
                    :width 'normal)

;; Setup projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Setup magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; Helm
(require 'helm)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)

;; Flycheck
(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

;; Generated settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm-projectile vue-mode mmm-mode company robe enh-ruby-mode rspec-mode flycheck helm magit seti-theme projectile))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Setup autocomplete
(add-hook 'after-init-hook 'global-company-mode)

;; Setup Ruby
(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
(add-hook 'ruby-mode-hook 'robe-mode)
(eval-after-load 'company
  '(push 'company-robe company-backends))
(add-hook 'robe-mode-hook 'ac-robe-setup)

;; Helm projectile
(require 'helm-projectile)
(helm-projectile-on)
