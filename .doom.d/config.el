(setq +doom-dashboard-menu-sections
'(("Reload last session"
    :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
    :when (cond ((require 'persp-mode nil t)
                 (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                ((require 'desktop nil t)
                 (file-exists-p (desktop-full-file-name))))
    :face (:inherit (doom-dashboard-menu-title bold))
    :action doom/quickload-session)
    ("Open org-roam Daily"
    :icon (all-the-icons-octicon "squirrel" :face 'doom-dashboard-menu-title)
    :when (fboundp 'org-roam-dailies-find-today)
    :action org-roam-dailies-today)
    ("Open org-agenda"
    :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
    :when (fboundp 'org-agenda)
    :action org-agenda)
    ("Recently opened files"
    :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
    :action recentf-open-files)
    ("Open project"
    :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
    :action projectile-switch-project)
    ("Jump to bookmark"
    :icon (all-the-icons-octicon "bookmark" :face 'doom-dashboard-menu-title)
    :action bookmark-jump)
    ("Open documentation"
    :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
    :action doom/help)))

(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))
;; Make 'h' and 'l' go back and forward in dired. Much faster to navigate the directory structure!
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-chmod
  (kbd "O") 'dired-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory
  (kbd "% l") 'dired-downcase
  (kbd "% u") 'dired-upcase
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; If peep-dired is enabled, you will get image previews as you go up/down with 'j' and 'k'
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(setq doom-theme 'doom-old-hope)
(map! :leader
      :desc "Load new theme" "h t" #'counsel-load-theme)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(95 . 95))

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(map! :leader
      (:prefix ("e". "evaluate/EWW")
       :desc "Evaluate elisp in buffer" "b" #'eval-buffer
       :desc "Evaluate defun" "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region" "r" #'eval-region))

(setq browse-url-browser-function 'eww-browse-url)
(map! :leader
      :desc "Search web for text between BEG/END"
      "s w" #'eww-search-words
      (:prefix ("e" . "evaluate/EWW")
       :desc "Eww web browser" "w" #'eww
       :desc "Eww reload page" "R" #'eww-reload))

(setq doom-font (font-spec :family "UbuntuMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "Cantarell" :size 17)
      doom-big-font (font-spec :family "UbuntuMono Nerd Font" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic nil))

(custom-set-faces!
  '(font-lock-comment-face)
  '(font-lock-keyword-face))

(setq global-prettify-symbols-mode t)

(setq ivy-posframe-display-functions-alist
      '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-top-center)
        (nil                        . ivy-posframe-display))
      ivy-posframe-height-alist
      '((swiper . 20)
        (dmenu . 20)
        (t . 10)))
(ivy-posframe-mode 1) ; 1 enables posframe-mode, 0 disables it.

(map! :leader
      (:prefix ("v" . "Ivy")
       :desc "Ivy push view" "v p" #'ivy-push-view
       :desc "Ivy switch view" "v s" #'ivy-switch-view))

(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(xterm-mouse-mode 1)

(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil
        neo-window-width 25))
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree" "d n" #'neotree-dir)

(map! :leader
      (:prefix ("-" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/Org/agenda.org"))
       :desc "Edit doom config.org" "c" #'(lambda () (interactive) (find-file "~/.config/doom/config.org"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.config/doom/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.config/doom/packages.el"))))

(after! org
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (remove-hook 'org-mode-hook #'org-superstar-mode)
  (setq org-fontify-quote-and-verse-blocks nil
        org-fontify-whole-heading-line nil
        org-hide-leading-stars t
        org-startup-indented nil)
  (setq org-directory "~/Org/")
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
    '("~/Org/Tasks.org"
      "~/Org/Habits.org"
      "~/Org/Birthdays.org"))

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(use-package company-tabnine :ensure t)
(add-to-list 'company-backends 'company-tabnine)

(map! :leader
      :desc "quickrun" "q r" #'quickrun)



(setq shell-file-name "/bin/fish"
      vterm-max-scrollback 5000)
(setq eshell-aliases-file "~/.doom.d/eshell/aliases"
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))
(map! :leader
      :desc "Eshell" "e s" #'eshell
      :desc "Counsel eshell history" "e h" #'counsel-esh-history)

(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 1 t)) ; make this as low as needed
(add-hook 'better-jumper--window-configuration-hook 'prefer-horizontal-split)
(map! :leader
      :desc "Clone indirect buffer other window" "b c" #'clone-indirect-buffer-other-window)
