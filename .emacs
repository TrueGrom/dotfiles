;;; package --- .emacs

;;; Commentary:

;;; Code:

(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Inhibit startup/splash screen
(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t) ;; экран приветствия можно вызвать комбинацией C-h C-a

;; disable tool-bar
(tool-bar-mode -1)

(setq echo-keystrokes 0.1)

;; Scrolling settings
(setq scroll-step               1) ;; вверх-вниз по 1 строке
(setq scroll-margin            10) ;; сдвигать буфер верх/вниз когда курсор в 10 шагах от верхней/нижней границы
(setq scroll-conservatively 10000)

(delete-selection-mode t)

;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t)
(set-frame-font "Hack 1")
(setq font-lock-maximum-decoration t)

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)

;;  all icons
(require 'all-the-icons)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)


;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t) ;; автоматически обновлять список функций в буфере
(setq imenu-use-popup-menu nil) ;; диалоги Imenu только в минибуфере
(global-set-key (kbd "<f2>") 'imenu) ;; вызов Imenu на F2

;; Show-paren-mode settings
(show-paren-mode t) ;; включить выделение выражений между {},[],()
;;(setq show-paren-style 'expression) ;; выделить цветом выражения между {},[],()

;; Electric-modes settings
(electric-pair-mode    1) ;; автозакрытие {},[],() с переводом курсора внутрь скобок
(electric-indent-mode 1) ;; отключить индентацию  electric-indent-mod'ом
(electric-quote-mode 1)

(setq use-dialog-box     nil) ;; никаких графических диалогов и окон - все через минибуфер

;; Linum plugin
(require 'linum) ;; вызвать Linum
(line-number-mode   t) ;; показать номер строки в mode-line
(global-linum-mode  t) ;; показывать номера строк во всех буферах
(column-number-mode t) ;; показать номер столбца в mode-line
(setq linum-format " %d") ;; задаем формат нумерации строк

;;ssh config mode
(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"       . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'"      . ssh-config-mode))
(add-to-list 'auto-mode-alist '("known_hosts\\'"       . ssh-known-hosts-mode))
(add-to-list 'auto-mode-alist '("authorized_keys2?\\'" . ssh-authorized-keys-mode))
(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

;; Indent settings
(setq-default indent-tabs-mode nil) ;; отключить возможность ставить отступы TAB'ом
(setq-default tab-width          4)
(setq-default c-basic-offset     4)
(setq-default standart-indent    4) ;; стандартная ширина отступа - 4 пробельных символа
(setq-default lisp-body-indent   4) ;; сдвигать Lisp-выражения на 4 пробельных символа
(global-set-key (kbd "RET") 'newline-and-indent) ;; при нажатии Enter перевести каретку и сделать отступ
(setq lisp-indent-function  'common-lisp-indent-function)

(require 'calendar)
(setq calendar-week-start-day 1)

;; Disable backup/autosave files
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

;; Disable arrow keys
(global-unset-key    [up])
(global-unset-key  [down])
(global-unset-key  [left])
(global-unset-key [right])


;; Dired
(require 'dired)
(setq dired-recursive-deletes 'top)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; Theme
(load-theme 'darcula t)

;; Company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (add-to-list 'company-backends '(company-shell company-shell-env)))

(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
(company-quickhelp-mode)


;;edbi
(add-hook 'sql-mode-hook 'edbi-minor-mode)
(eval-after-load "sql"
    '(load-library "sql-indent"))


(add-hook 'after-init-hook #'global-flycheck-mode)

;; helm
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)

;; projectile
(require 'projectile)
(require 'helm-projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(helm-projectile-on)


;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(require 'editorconfig)
(editorconfig-mode 1)

(require 'which-key)
(which-key-mode)


(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-timer)
(global-set-key (kbd "M-g f") 'avy-goto-line)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (indium helm-slime slime slime-company smartparens markdown-mode elpy docker docker-compose-mode dockerfile-mode multi-compile helm-rg paredit racket-mode scheme-complete geiser rainbow-delimiters skewer-mode pipenv pyenv-mode py-yapf pyimport diff-hl cycle-quotes helm-gitignore highlight-thing darcula-theme org-jira sql-indent company-nginx nginx-mode avy exec-path-from-shell which-key python-mode py-autopep8 projectile-speedbar magit json-mode helm-projectile helm-company flycheck editorconfig company-statistics company-shell company-quickhelp company-edbi all-the-icons-dired)))
 '(realgud:pdb-command-name "python -m pdb"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Python
(require 'py-autopep8)
(setq py-autopep8-options '("--max-line-length=120"))
(add-hook 'python-mode-hook 'company-mode)
(elpy-enable)

(require 'diff-hl)
(global-diff-hl-mode)

(setq tramp-default-method "ssh")

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;scheme
(eval-after-load 'scheme
    '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; Docker
(require 'docker-compose-mode)
(require 'dockerfile-mode)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))


;;CL
(require 'cl)
(setq-default inferior-lisp-program "sbcl")
(require 'smartparens-config)
(smartparens-global-mode)
(require 'slime)
(require 'slime-autoloads)
(slime-setup '(slime-asdf
               slime-fancy
               slime-company
               slime-indentation))
(setq-default slime-net-coding-system 'utf-8-unix)
(setq-default lisp-body-indent 2)
(setq-default lisp-indent-function 'common-lisp-indent-function)


;;Python
(elpy-enable)

;;; .emacs ends here
