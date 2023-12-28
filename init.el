(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(smart-mode-line-respectful gruber-darker))
 '(custom-safe-themes
   '("34d7d26fef32567167570f85eefcc774f187a81e913972b8037259c5753836dc"
     "e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7"
     "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223"
     "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"
     "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e"
     "bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6"
     default))
 '(indent-tabs-mode nil)
 '(package-selected-packages
   '(avy consult git-gutter-fringe gruber-darker-theme julia-ts-mode
         magit markdown-mode multiple-cursors nasm-mode
         smart-mode-line undo-tree visual-fill-column))
 '(tab-bar-auto-width t)
 '(tab-bar-auto-width-max '(300 24))
 '(tab-bar-close-button-show nil)
 '(tab-bar-close-last-tab-choice 'tab-bar-mode-disable)
 '(tab-bar-mode t)
 '(tab-bar-new-tab-choice "*scratch*")
 '(tab-bar-new-tab-to 'rightmost)
 '(tab-bar-select-tab-modifiers '(control))
 '(tab-bar-show 1)
 '(tab-bar-tab-hints t)
 '(tab-bar-tab-name-truncated-max 24)
 '(undo-tree-visualizer-diff t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Ido mode for quick file opening/buffer searching
;;================================================
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(global-set-key (kbd "C-c t") 'tab-bar-new-tab)
(global-set-key (kbd "C-c w") 'tab-bar-close-tab)

;;Tab bar mode
;;============
(tab-bar-mode t)

;;Undo tree
;;=========
(require 'undo-tree)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/cache")))
(global-undo-tree-mode)

;;Treesitter
;;==========
(require 'treesit)
(setq treesit-language-source-alist
 '((c "https://github.com/tree-sitter/tree-sitter-c")
   (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
   (bash "https://github.com/tree-sitter/tree-sitter-bash")
   (json "https://github.com/tree-sitter/tree-sitter-json")
   (html "https://github.com/tree-sitter/tree-sitter-html")
   (css "https://github.com/tree-sitter/tree-sitter-css")
   (rust "https://github.com/tree-sitter/tree-sitter-rust")
   (julia "https://github.com/tree-sitter/tree-sitter-julia")
   (python "https://github.com/tree-sitter/tree-sitter-python")))

;; M-x eval-buffer or M-: this to install all files
;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))

;;Custom styles
;;=============
(c-add-style "ffmpeg" ; for C-like languages only, as for C, c-ts-mode is used
             '("k&r"
               (c-basic-offset . 4)
               (indent-tabs-mode . nil)
               (show-trailing-whitespace . t)
               (c-offsets-alist
                (statement-cont . (c-lineup-assignments +)))))
(setq c-default-style "ffmpeg")

;;Coding hooks
;;============
(add-hook 'c-ts-mode-hook (lambda()
                            (setq c-ts-mode-indent-offset 4)
;                            (setq c-ts-mode-set-style 'k&r)
                            (setq c-ts-mode-indent-style 'k&r)
                            (display-fill-column-indicator-mode t)))
(add-hook 'c++-ts-mode-hook (lambda()
                              (setq c-ts-mode-indent-offset 4)
;                              (setq c-ts-mode-set-style 'k&r)
                              (setq c-ts-mode-indent-style 'k&r)
                              (display-fill-column-indicator-mode t)))
(add-hook 'c-or-c++-ts-mode-hook (lambda()
                                   (setq c-ts-mode-indent-offset 4)
;                                   (setq c-ts-mode-set-style 'k&r)
                                   (setq c-ts-mode-indent-style 'k&r)
                                   (display-fill-column-indicator-mode t)))
(add-hook 'rust-ts-mode-hook (lambda()
                               (display-fill-column-indicator-mode t)))
(add-hook 'python-ts-mode-hook (lambda()
                                 (display-fill-column-indicator-mode t)))
(add-hook 'julia-ts-mode-hook (lambda()
                                (display-fill-column-indicator-mode t)))

;;Remap modes
;;===========
(setq major-mode-remap-alist
 '((c++-mode . c++-ts-mode)
   (c-or-c++-mode . c-or-c++-ts-mode)
   (bash-mode . bash-ts-mode)
   (sh-mode . bash-ts-mode)
   (json-mode . json-ts-mode)
   (html-mode . html-ts-mode)
   (mhtml-mode . html-ts-mode)
   (css-mode . css-ts-mode)
   (rust-mode . rust-ts-mode)
   (python-mode . python-ts-mode)))

;;Force modes
;;===========
(add-to-list 'auto-mode-alist '("\\.c\\'"    . c-ts-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'"    . c-ts-mode))

(add-to-list 'auto-mode-alist '("\\.rs\\'"   . rust-mode))
(add-to-list 'auto-mode-alist '("\\.asm\\'"  . nasm-mode))
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.comp\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.mesh\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'"   . c-mode))

;;avy movement
;;============
(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(global-set-key (kbd "C-'") 'avy-goto-char-timer)
(setq avy-timeout-seconds 0.2)

;;window navigation
;;=================
(global-set-key (kbd "C-,") 'next-window-any-frame)
(global-set-key (kbd "C-.") 'previous-window-any-frame)

;;consult
;;=======
(setq lexical-binding t)
;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ;;("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 3. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  ;;;; 4. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 5. No project support
  ;; (setq consult-project-function nil)
)

;;git gutter
;;==========
(require 'git-gutter-fringe)
(define-fringe-bitmap 'git-gutter-fr:added    [#b11111110] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:modified [#b11111110] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:deleted  [#b11111110] nil nil '(center repeated))
(defun enable-git-gutter nil
 "enable git gutter if file is under git"
 (when (eq (vc-backend (buffer-file-name)) 'Git)
       (git-gutter-mode 1)))

;;prog mode
;;=========
(add-hook 'prog-mode-hook (lambda () (enable-git-gutter)))

;;Fountain mode
;;=============
(require 'fountain-mode)
(add-hook 'fountain-mode-hook 'variable-pitch-mode)
(add-hook 'fountain-mode-hook 'visual-line-mode)
(add-hook 'fountain-mode-hook 'visual-fill-column-mode)
(add-hook 'fountain-mode-hook (lambda () (setq fill-column 132)))

;;Org mode
;;========
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-fill-column-mode)
(add-hook 'org-mode-hook (lambda () (setq fill-column 132)))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (julia . t)
   (python . t)
   (emacs-lisp . t)
   (org . t)))

;;Multiple cursors
;;================
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "M-/") 'mc/mark-previous-like-this)
(global-set-key (kbd "M--") 'mc/mark-next-like-this)

;;Various settings
;;================
(setq-default tab-width 4)
(setq-default visual-fill-column-center-text t)        ;; Center text in fountain/org
(setq-default display-fill-column-indicator-column 80) ;; 80 column guideline
(setq column-number-mode t)                            ;; show column on modeline
(setq global-visual-line-mode t)                       ;; better wrapping
(setq initial-scratch-message nil)                     ;; hides stupid scratch msg
(setq-default show-trailing-whitespace t)              ;; obvs
(show-paren-mode t)                                    ;; highlight matching
(save-place-mode t)                                    ;; save file place
(global-superword-mode t)                              ;; words with _ are one-word
(menu-bar-mode -1)                                     ;; disable menubar
(tool-bar-mode -1)                                     ;; disable toolbar
(setq inhibit-startup-screen t)                        ;; no startup screen

(setq-default electric-indent-inhibit t)
(setq backward-delete-char-untabify-method 'hungry)

;;smart modeline
;;==============
(sml/setup)
(setq sml/theme 'respectful)
(add-to-list 'sml/replacer-regexp-list '("^~/projects/" ":P:") t)

;;Enable pixel scrolling (disable for now...)
;;======================
(pixel-scroll-precision-mode 0)

;;Fonts
;;=====
(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)

(set-face-attribute 'default nil :font "Iosevka (Lynne) Extended" :height efs/default-font-size)
(set-face-attribute 'fixed-pitch nil :font "Iosevka (Lynne) Extended" :height efs/default-font-size)
(set-face-attribute 'variable-pitch nil :font "Source Sans Pro" :height efs/default-variable-font-size :weight 'regular)

;;Line numbers
;;============
(require 'display-line-numbers)

(defcustom display-line-numbers-exempt-modes
  '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode fountain-mode)
  "Major modes on which to disable line numbers."
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "Turn on line numbers except for certain major modes.
   Exempt major modes are defined in `display-line-numbers-exempt-modes'."
  (unless (or (minibufferp)
              (member major-mode display-line-numbers-exempt-modes))
          (display-line-numbers-mode)))
(global-display-line-numbers-mode)

;;Bindings
;;========
(global-set-key (kbd "C-x p") 'toggle-truncate-lines)
(global-set-key (kbd "C->")   'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<")   'indent-rigidly-left-to-tab-stop)

;;Startup time
;;============
(defun efs/display-startup-time ()
    (message "Emacs loaded in %s with %d garbage collections."
        (format "%.2f seconds"
            (float-time (time-subtract after-init-time before-init-time)))
             gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;;Bikeshed spec mode
;;==================
(load "~/.emacs.d/bikeshed.el")
