;; Thanks but no thanks
(setq inhibit-startup-message t)

(scroll-bar-mode -1)  ; Disable scrollbar
(tool-bar-mode -1)    ; Disable tool bar
(tooltip-mode -1)     ; Disabel tooltips
(set-fringe-mode 10)  ; Give some breathing room

(menu-bar-mode -1)    ; Disable menu bar

(setq visible-bell t)

;; Fonts
(set-face-attribute 'default nil :font "Source Code Pro" :height 115)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Theme
(load-theme 'tango-dark)

;; Initialize Package Sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; Ivy
(use-package ivy
 :diminish
 :bind (("C-s" . swiper)
        :map ivy-minibuffer-map
        ("TAB" . ivy-alt-done)
        ("C-l" . ivy-alt-done)
        ("C-j" . ivy-next-line)
        ("C-k" . ivy-previous-line)
        :map ivy-switch-buffer-map
        ("C-k" . ivy-previous-line)
        ("C-l" . ivy-done)
        ("C-d" . ivy-switch-buffer-kill)
        :map ivy-reverse-i-search-map
        ("C-k" . ivy-previous-line)
        ("C-d" . ivy-reverse-i-search-kill))
 :config
 (ivy-mode 1))

;; Counsel
(use-package counsel)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(counsel ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
