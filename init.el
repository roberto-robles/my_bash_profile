(require 'cl)

(setq ;;custom-file ;;(expand-file-name "~/.emacs.d/custom.el")
      ns-use-srgb-colorspace t
      ring-bell-function 'ignore
      inhibit-startup-message t
      initial-scratch-message nil
      indent-tabs-mode nil
      make-backup-files nil
      use-dialog-box nil
      message-log-max nil
      mac-command-modifier 'meta
      ido-use-filename-at-point 'guess
      even-window-heights nil)
      
;;(load-file (expand-file-name "~/.emacs.d/custom.el"))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar packages '(better-defaults
                   company
                   zenburn-theme
                   paredit
                   autopair
                   clojure-mode
                   smex
                   cider
                   smart-tab
                   less-css-mode
                   exec-path-from-shell))

(dolist (p packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'better-defaults)
(require 'smart-tab)
(require 'company)

(load-theme 'zenburn t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay nil)
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(package-selected-packages
   (quote
    (exec-path-from-shell less-css-mode smart-tab cider smex clojure-mode autopair paredit zenburn-theme company better-defaults)))
 '(smart-tab-completion-functions-alist
   (quote
    ((emacs-lisp-mode . company-complete)
     (text-mode . dabbrev-completion)
     (clojure-mode . company-complete)
     (cider-repl-mode . company-complete)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-echo-common ((t (:foreground "#cc9393"))))
 '(company-preview ((t (:background "#4f4f4f" :foreground "#f0dfaf"))))
 '(company-preview-common ((t (:inherit company-preview :background "#3f3f3f" :foreground "#7f9f7f"))))
 '(company-preview-search ((t (:inherit company-preview :background "#4f4f4f"))))
 '(company-scrollbar-bg ((t (:inherit company-tooltip :background "#3f3f3f"))))
 '(company-scrollbar-fg ((t (:background "#3f3f3f"))))
 '(company-template-field ((t (:background "#f0dfaf" :foreground "#3f3f3f"))))
 '(company-tooltip ((t (:background "#4f4f4f" :foreground "#f0dfaf"))))
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "#8c5353"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :background "#5f5f5f" :foreground "#F0DFAF"))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :background "#5f5f5f" :foreground "#f0dfaf"))))
 '(company-tooltip-mouse ((t (:inherit highlight :background "#4f4f4f"))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "#7f9f7f" :foreground "#3f3f3f")))))

(set-default 'tab-width 2)
(set-default 'c-basic-offset 2)

;;; clojure
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq cider-repl-use-clojure-font-lock nil)
(setq inferior-lisp-command "lein repl"
      cider-repl-popup-stacktraces t)
(setq nrepl-hide-special-buffers t)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;;; lisp
(add-hook 'lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'slime-repl-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)
(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

;; less
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)
(show-paren-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(set-face-attribute 'default nil :family "Ubuntu Mono")
(set-face-attribute 'default nil :height 140)
(add-to-list 'default-frame-alist '(left   . 0))
(add-to-list 'default-frame-alist '(top    . 0))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width  . 80))

(require 'icomplete)

(setq default-directory (shell-command-to-string "echo -n $HOME"))

(global-smart-tab-mode)
(global-company-mode)
(autopair-global-mode)

(when (memq window-system '(mac ns))
  (require 'exec-path-from-shell)
  (add-to-list 'exec-path-from-shell-variables "JAVA_HOME")
  (exec-path-from-shell-initialize))

(define-key company-active-map (kbd "\C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "\C-p") 'company-select-previous-or-abort)

;; Global modifiers and actions
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'alt)

;;   maintain page up/down
(global-set-key [(hyper up)] 'scroll-down) 
(global-set-key [(hyper down)] 'scroll-up)

;;   buffer navigation
(global-set-key [(meta up)] 'other-window)
(global-set-key [(meta down)] 'prior-window)
(global-set-key [(meta left)] 'other-frame)
(global-set-key [(meta right)] 'prior-frame)

(defun prior-window ()
  (interactive)
  (other-window -1))

(defun prior-frame ()
  (interactive)
  (other-frame -1))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; My Project setup with magit
(eshell)
;;(magit-status)
