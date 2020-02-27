
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; author: Jooho Yoon
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; server-client
;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'server)
(server-start)
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; install packages
;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(setq-default package-list '(auto-complete elpy epl fill-column-indicator helm highlight-symbol monokai-theme neotree))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; on/off each mode
;;;;;;;;;;;;;;;;;;;;;;;;;;
(delete-selection-mode t)
(global-linum-mode 1)
(menu-bar-mode 0)
(prefer-coding-system 'utf-8)
(recentf-mode 1)
(show-paren-mode 1)
(which-function-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setq(-default)
;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default auto-fill-mode 1)
(setq-default coding-system-for-read 'utf-8)
(setq-default coding-system-for-write 'utf-8)
(setq-default column-number-mode t)
(setq-default c-default-style "java")
(setq-default c-basic-offset 4)
(setq-default default-tab-width 4)
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default linum-format "%d ")
(setq-default make-backup-files nil)
(setq-default scroll-step 1)
(setq-default standard-indent 4)
(setq-default package-check-signature nil)
(setq elpy-rpc-python-command "python3")
(setq js-indent-level 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; user-defined function
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; comment-dwim-line
(defun comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

;;;;;;;;;;;;;;;;;;;;;;;
;; global-set-key
;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c C-c") 'comment-dwim-line)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f2>") 'goto-line)
(global-set-key (kbd "C-x m") 'recentf-open-files)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

;;;;;;;;;;;;;;;;;;;;;;;
;; add-to-list
;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'". c++-mode))

;;;;;;;;;;;;;;;;;;;;;;;
;; package-specific
;;;;;;;;;;;;;;;;;;;;;;;

;; elpy
(elpy-enable)

;;
;; helm
;;
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c h o") 'helm-occur)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)
(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)
(helm-mode 1)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; highlight-symbol
(require 'highlight-symbol)
(global-set-key [(f3)] 'highlight-symbol-at-point)

;; fill-column-inidicator
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook 'fci-mode)

;; neotree
(require 'neotree)
(global-set-key [f1] 'neotree-toggle)

;; theme
(load-theme 'monokai t)

;; python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; golang
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 4)))
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
