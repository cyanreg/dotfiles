(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(lorisan))
 '(custom-safe-themes
   '("1c502e5a8b9615342d64c1e2f80b39deadb10f3cbeb1660f254859483f9ac08f"
     "d04d71fa27398bb5c18bb0e83eafe9dea91b1af00ac0b35f30341d9938e90cb3"
     "70544543624ce5931b50dede8dd7d869f60255491bd7b269beaed3820ea29f21"
     "eeba6d1b62eaa649a65d97a280307d712a9d5cb5beb98d8e250515e8b20b105e"
     "db272a28fcccd3cf362a44de440dddc68c30d243a7e0832d73f05a29b7049002"
     "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"
     "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e"
     "615512c6cb8d153839bb8d4a86281450a863318b109484ef483341874bdac13f"
     "f7f89bfe1b18bdaf2223926fe171d5173bad65040b9d9f47bfa98d21426bd846"
     "e9b9599306480aac67081594be6d1e24be525e956a185be071c730e30859a46c"
     "ce0904225fb51ce10f117a504fae63f1a242adbe1d0c24718f715f9c046a8824"
     "30b15e40530f943449852afd52abc1488a801032fcfbaedcc1a43d01ff3ab8af"
     "514a00ea4ef98bc304101dc24ad91908d8a795d3c4548faa541c474c8e6c1c96"
     "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223"
     default))
 '(indent-tabs-mode nil)
 '(package-selected-packages
   '(## avy consult expand-region git-gutter-fringe julia-ts-mode magit
        markdown-mode multiple-cursors nasm-mode visual-fill-column
        yasnippet))
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
 '(tab-bar-tab-name-truncated-max 24))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Useful shortcuts
;;================
;; M-m : go to the first whitespace char on line
;; M-. : go to function def
;; M-/ : autocomplete
;; M-, : go back from the function def
;; C-c TAB : smart function def list jump
;; C-x n n : narrow (hide everything but region) look into using outline-minor-mode
;; C-x n w : restore narrowing
;; C-u C-space : jump back to previous whatever you were
;; C-u <num> <char> : duplicate <char> <num> of times
;; M-^ : move expression to prev line
;; C-x r s <char> : copy region to register
;; C-x r i <char> : copy register contents
;; C-= : expand region (select progressively larger region from cursor)
;; C-l : recenter screen onto cursor AND jump around occurences of the word under
;; C-x 2 RET C-x 2 RET C-x + : create 3 equal windows

;;LSP
;;

;;Magit
;; C-c C-c : accept commit message
;; C-c C-k : cancel commit when writing message

;;Maintenance
;;============
;; Compile all existing packages:
;; (native-compile-async "~/.emacs.d/elpa" 'recursively)

;;Theme
;;=====
(load "~/.emacs.d/lorisan-theme.el")

;;Undo
;;====
(global-set-key (kbd "C-/") #'undo-only)
(global-set-key (kbd "M-o") #'undo-redo)
(global-set-key (kbd "M-p") #'undo)

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

;;Region expansion
;;================
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;project stuff
;;=============
;(require 'etags)

;;Session management
;;==================
(require 'desktop)

(defvar my-desktop-session-dir "~/.emacs.d/sessions/")

(defvar my-desktop-session-name-hist nil
   "Desktop session name history")

(defun my-desktop-save (&optional name)
   "Save desktop with a name."
   (interactive)
   (unless name
      (setq name (my-desktop-get-session-name "Save session as: ")))
   (make-directory (concat my-desktop-session-dir name) t)
   (desktop-save (concat my-desktop-session-dir name) t))

(defun my-desktop-read (&optional name)
   "Read desktop with a name."
   (interactive)
   (unless name
      (setq name (my-desktop-get-session-name "Load session: ")))
   (desktop-read (concat my-desktop-session-dir name)))

(defun my-desktop-get-session-name (prompt)
   (completing-read prompt (and (file-exists-p my-desktop-session-dir)
                                (directory-files my-desktop-session-dir))
                    nil nil nil my-desktop-session-name-hist))

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

;;Yas
;;===
(add-to-list 'load-path "~/.emacs.d/snippets")
(require 'yasnippet)

;;LSP
;;===
(with-eval-after-load 'eglot
  (setq eglot-sync-connect 0)
  (setq eglot-autoshutdown t)
  (setq eglot-extend-to-xref t)
  (setq eglot-ignored-server-capabilities '(:inlayHintProvider
;                                            :documentLinkProvider
;                                            :colorProvider
;                                            :executeCommandProvider
;                                            :codeLensProvider
;                                            :hoverProvider
;                                            :foldingRangeProvider
                                            :documentFormattingProvider
                                            :documentRangeFormattingProvider
                                            :documentOnTypeFormattingProvider))
  (add-to-list 'eglot-server-programs
    '((c-ts-mode c++-ts-mode c-or-c++-ts-mode)
      .("clangd-18"
          "-j=3"
          "--compile-commands-dir=./build"
;          "--inlay-hints"
          "--log=verbose"
          "--malloc-trim"
          "--background-index"
          "--clang-tidy"
          "--all-scopes-completion"
          "--completion-style=detailed"
          "--rename-file-limit=0"
          "--limit-references=0"
          "--limit-results=0"
          "--pch-storage=memory"
          "--function-arg-placeholders"
          "--header-insertion=never"
          "--header-insertion-decorators=false"))))

;;Custom styles
;;=============
;(c-add-style "ffmpeg" ; for C-like languages only, as for C, c-ts-mode is used
;             '("k&r"
;               (c-basic-offset . 4)
;               (indent-tabs-mode . nil)
;               (show-trailing-whitespace . t)
;               (c-offsets-alist
;                (statement-cont . (c-lineup-assignments +)))))
;(setq c-default-style "ffmpeg")

;;Coding hooks
;;============
(setq treesit-font-lock-level 3)

(add-hook 'c-ts-mode-hook (lambda()
                            (setq c-ts-mode-indent-offset 4)
;                            (setq c-tlls-mode-set-style 'k&r)
                            (setq c-ts-mode-indent-style 'k&r)
                            (eglot-ensure)
                            (display-fill-column-indicator-mode t)))
(add-hook 'c++-ts-mode-hook (lambda()
                              (setq c-ts-mode-indent-offset 4)
;                              (setq c-ts-mode-set-style 'k&r)
                              (setq c-ts-mode-indent-style 'k&r)
                              (eglot-ensure)
                              (display-fill-column-indicator-mode t)))
(add-hook 'c-or-c++-ts-mode-hook (lambda()
                                   (setq c-ts-mode-indent-offset 4)
;                                   (setq c-ts-mode-set-style 'k&r)
                                   (setq c-ts-mode-indent-style 'k&r)
                                   (eglot-ensure)
                                   (display-fill-column-indicator-mode t)))
(add-hook 'rust-ts-mode-hook (lambda()
                               (display-fill-column-indicator-mode t)))
(add-hook 'python-ts-mode-hook (lambda()
;                                 (etags-regen-mode t)
;                                 (xref-etags-mode t)
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

;;Bikeshed spec mode
;;==================
(load "~/.emacs.d/bikeshed.el")
(require 'bikeshed)

;;avy movement
;;============
(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(global-set-key (kbd "C-'") 'avy-goto-char-timer)
(setq avy-timeout-seconds 0.2)

;;window navigation
;;=================
(global-set-key (kbd "C-,") 'previous-window-any-frame)
(global-set-key (kbd "C-.") 'next-window-any-frame)

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

;;ido jump to symbol
;;==================
(defun ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
    (require 'imenu nil t))
  (cond
   ((not symbol-list)
    (let ((ido-mode ido-mode)
          (ido-enable-flex-matching
           (if (boundp 'ido-enable-flex-matching)
               ido-enable-flex-matching t))
          name-and-pos symbol-names position)
      (unless ido-mode
        (ido-mode 1)
        (setq ido-enable-flex-matching t))
      (while (progn
               (imenu--cleanup)
               (setq imenu--index-alist nil)
               (ido-goto-symbol (imenu--make-index-alist))
               (setq selected-symbol
                     (ido-completing-read "Symbol? " symbol-names))
               (string= (car imenu--rescan-item) selected-symbol)))
      (unless (and (boundp 'mark-active) mark-active)
        (push-mark nil t nil))
      (setq position (cdr (assoc selected-symbol name-and-pos)))
      (cond
       ((overlayp position)
        (goto-char (overlay-start position)))
       (t
        (goto-char position)))))
   ((listp symbol-list)
    (dolist (symbol symbol-list)
      (let (name position)
        (cond
         ((and (listp symbol) (imenu--subalist-p symbol))
          (ido-goto-symbol symbol))
         ((listp symbol)
          (setq name (car symbol))
          (setq position (cdr symbol)))
         ((stringp symbol)
          (setq name symbol)
          (setq position
                (get-text-property 1 'org-imenu-marker symbol))))
        (unless (or (null position) (null name)
                    (string= (car imenu--rescan-item) name))
          (add-to-list 'symbol-names name)
          (add-to-list 'name-and-pos (cons name position))))))))

(global-set-key (kbd "C-c TAB") 'ido-goto-symbol)

;;git gutter
;;==========
(require 'git-gutter-fringe)
(define-fringe-bitmap 'git-gutter-fr:added    [#b00011111] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:modified [#b00011111] nil nil '(center repeated))
(define-fringe-bitmap 'git-gutter-fr:deleted  [#b00011111] nil nil '(center repeated))
(defun enable-git-gutter nil
  "enable git gutter if file is under git"
  (when (eq (vc-backend (buffer-file-name)) 'Git)
        (git-gutter-mode 1)))

;;prog mode
;;=========
(defun turn-on-trailing-whitespace ()
  "Turn on trailing whitespaces only where it makes sense."
  (unless (memq major-mode '(shell-mode eshell-mode)) (setq show-trailing-whitespace t)))

(add-hook 'prog-mode-hook
  (lambda ()
    (yas-minor-mode)
    (turn-on-trailing-whitespace)
    (enable-git-gutter)))

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
(global-set-key (kbd "M-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-<down>") 'mc/mark-next-like-this)

;;Various settings
;;================
(require 'uniquify)
(setq package-native-compile t)

(fset 'yes-or-no-p 'y-or-n-p)
(setq undo-limit 48000000)
(setq undo-strong-limit 64000000)
(setq undo-outer-limit 64000000)
(scroll-bar-mode -1)
(setq-default tab-width 4)
(setq-default visual-fill-column-center-text t)        ;; Center text in fountain/org
(setq-default display-fill-column-indicator-column 80) ;; 80 column guideline
(setq column-number-mode t)                            ;; show column on modeline
(setq global-visual-line-mode t)                       ;; better wrapping
(setq initial-scratch-message nil)                     ;; hides stupid scratch msg
(show-paren-mode t)                                    ;; highlight matching
(setq blink-matching-paren nil)                        ;; only when offscreen, pointless and buggy
(save-place-mode t)                                    ;; save file place
;(global-superword-mode t)                              ;; words with _ are one-word
(menu-bar-mode -1)                                     ;; disable menubar
(tool-bar-mode -1)                                     ;; disable toolbar
(setq inhibit-startup-screen t)                        ;; no startup screen

;(setq-default electric-indent-inhibit t)
(setq backward-delete-char-untabify-method 'hungry)

;;Enable pixel scrolling (disable for now...)
;;======================
(pixel-scroll-precision-mode 0)

;;Fonts
;;=====
(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 280)

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

;;Functions
;;=========
(defun list-active-modes ()
  "Give a message of which minor modes are enabled in the current buffer."
  (interactive)
  (let ((active-modes))
    (mapc (lambda (mode) (condition-case nil
                             (if (and (symbolp mode) (symbol-value mode))
                                 (add-to-list 'active-modes mode))
                           (error nil) ))
          minor-mode-list)
    (message "Active modes are %s" active-modes)))

;;Startup time
;;============
(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
    (format "%.2f seconds"
            (float-time (time-subtract after-init-time before-init-time)))
             gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)
