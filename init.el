;;disable modes
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq-default indent-tabs-mode nil)
;;Set other modes
(global-auto-revert-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
;; disable bell function
(setq ring-bell-function 'ignore)
(setq mac-command-modifier 'meta)

;; disable splash screen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(face-font-family-alternatives
   (quote
    (("Monospace" "courier" "fixed")
     ("courier" "CMU Typewriter Text" "fixed")
     ("Sans Serif" "helv" "helvetica" "arial" "fixed")
     ("helv" "helvetica" "arial" "fixed"))))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (company-anaconda feature-mode auto-virtualenv haskell-mode markdown-mode lua-mode company flycheck bundler rspec rvm robe rinari flx-ido web-mode projectile-rails projectile anzu ess lua tuareg use-package haml-mode pianobar names csv-mode yasnippet yaml-mode ruby-tools ruby-end rspec-mode realgud magit json-mode hi2 guru-mode ghci-completion flymake flycheck-hdevtools f ensime company-inf-ruby browse-kill-ring+ autopair aggressive-indent ac-inf-ruby ac-haskell-process))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-symbol-face ((t (:foreground "blue")))))
;;Include files
(add-to-list 'load-path "~/.emacs-includes")





;;Tab size
(setq-default tab-width 2)
(require 'package)

;;Load autoinstalled packages(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.milkbox.net/packages/")))
(package-initialize)
(unless package-archive-contents
 	(package-refresh-contents))

(unless (package-installed-p 'use-package)
	(package-install 'use-package))

(eval-when-compile
	(require 'use-package))
(setq use-package-always-ensure t)


;;manually-set variables
(global-set-key [insert] 'compile)
;;goto line
(global-set-key "\C-l" 'goto-line)
;;go one fram backward
(global-set-key (kbd "C-x x") '(lambda () "frame-back one" (interactive) (other-window -1)))

(use-package diminish)
(use-package magit
	:init
	(global-set-key (kbd "C-x g") 'magit-status))


;;flycheck
(use-package flycheck
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode))
;; from https://github.com/Wilfred/flycheck-pyflakes/
(add-to-list 'flycheck-disabled-checkers 'python-flake8)
(add-to-list 'flycheck-disabled-checkers 'python-pylint)
(flycheck-define-checker python-pyflakes
  "A Python syntax and style checker using the pyflakes utility.
See URL `http://pypi.python.org/pypi/pyflakes'."
  :command ("pyflakes" source-inplace)
  :error-patterns
  ((error line-start (file-name) ":" line ":" (message) line-end))
  :modes python-mode anaconda-mode)

(add-to-list 'flycheck-checkers 'python-pyflakes)

;;Company-mode - autocompletion
(use-package company
	:init
	(add-hook 'after-init-hook 'global-company-mode)
  :config
	(push 'company-robe company-backends)
  (add-to-list 'company-backends 'company-anaconda)
	:diminish company-mode)

;;org-mode settings
(use-package org
	:init
	(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
	(add-hook 'org-mode-hook 'visual-line-mode)
	(global-set-key "\C-cl" 'org-store-link)
	(global-set-key "\C-ca" 'org-agenda)
	(global-font-lock-mode 1))

;;visual line mode in text mode
(add-hook 'text-mode-hook 'visual-line-mode)

;;lua-mode
(use-package lua-mode
	:init
	(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
	(add-to-list 'interpreter-mode-alist '("lua" . lua-mode)))

;;ido-mode
(use-package ido
	:init
	(setq ido-enable-flex-matching t)
	(setq ido-use-faces nil)
	(setq ido-everywhere t)
	(ido-mode 1)
	(setq ido-auto-merge-work-directories-length -1)) ;; disable auto-merge
;;flx-mode for better string matching
(use-package flx-ido
	:init
	(flx-ido-mode 1))
(add-hook 'latex-mode-hook 'flyspell-mode)

;;Markdown mode
(use-package markdown-mode
	:init
	(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
	(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
	(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;;Yaml mode
(use-package yaml-mode)
;;guru-mode
(use-package guru-mode
	:init
	(guru-global-mode +1)
	:diminish guru-mode)

;;Aggressive-indent-mode instead of electric-indent-mode.  Will indent blocks automatically.
(use-package aggressive-indent
	:init
	(global-aggressive-indent-mode 1)
	(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
	(add-to-list 'aggressive-indent-excluded-modes 'ess-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'python-mode)
	:diminish aggressive-indent-mode)

;;Haskell
(use-package haskell-mode
	:init
	(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
	(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
	(add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
	(add-hook 'haskell-interactive-mode-hook 'ac-haskell-process-setup)
	
	:config
	;;indent/dedent region
	(define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
	(define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
	(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

;;Python
(use-package anaconda-mode
  :init
  (add-hook 'python-mode-hook 'anaconda-mode))
(use-package auto-virtualenv
	:init
	(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
	(add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv))

;;pianobar
(use-package pianobar
	:init
	(setq pianobar-username "")
	(setq pianobar-password "")
	(setq pianobar-station "18")
	(autoload 'pianobar "pianobar" nil t)
	:config
	(global-set-key (kbd "C-x p p") 'pianobar-play-or-pause)
	(global-set-key (kbd "C-x p n") 'pianobar-next-song)
	(global-set-key (kbd "C-x p s") 'pianobar-change-station)
	(global-set-key (kbd "C-x p l") 'pianobar-love-current-song)
	(global-set-key (kbd "C-x p b") 'pianobar-ban-current-song))

;;ess-mode for statistics
(use-package ess
	:init
	(require 'ess-site))
;;Anzu - show count of matches
(use-package anzu
	:init
	(global-anzu-mode +1)
	;;(global-set-key (kbd "M-%") 'anzu-query-replace)
	;;(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
	:diminish anzu-mode
	)
(use-package projectile
	:init
	(projectile-global-mode)
  :diminish projectile-mode)
(use-package bundler)
;;next set of packages are for rails
(use-package projectile-rails
	:init
	(add-hook 'projectile-mode-hook 'projectile-rails-on)
	:config
	(define-key projectile-rails-command-map (kbd "A") (lambda() (interactive) (shell-command "bundle exec rake test")))
	)
(lambda() (shell-command "bundle exec rake test"))

(use-package rspec-mode
	:init
	(add-to-list 'auto-mode-alist '("\\.erb\\'" . rspec-mode))
	:diminish rspec-mode)

(use-package web-mode
	:mode
	("\\.phtml\\'" . web-mode)
	("\\.tpl\\.php\\'" . web-mode)
	("\\.[agj]sp\\'" . web-mode)
	("\\.as[cp]x\\'" . web-mode)
	("\\.erb\\'" . web-mode)
	("\\.html?\\'" . web-mode)
	("\\.mustache\\'" . web-mode)
	("\\.djhtml\\'" . web-mode))

(use-package json-mode)

(use-package rvm
	:init
	(rvm-use-default)
	:diminish rvm-mode)
(use-package robe
	:init
	(add-hook 'ruby-mode-hook 'robe-mode)
	:diminish robe-mode)

(use-package feature-mode
  :mode
  ("\.feature$" . feature-mode))

  (setq inf-ruby-default-implementation "pry")
  ;;Custom elisp functions
  ;;show the matching parenthesis
  (show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression);;highlight whole expression
  ;;Show offscreen parens in minibuffer
(defadvice show-paren-function 
		(after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
				 (matching-text (and cb
														 (char-equal (char-syntax cb) ?\) )
														 (blink-matching-open))))
    (when matching-text (message matching-text))))




;;Ruby
;;#{} automatic completion in strings - from http://blog.senny.ch/blog/2012/10/06/emacs-tidbits-for-ruby-developers/
(setq ruby-insert-encoding-magic-comment nil)
(defun senny-ruby-interpolate ()
  "In a double quoted string, interpolate."
  (interactive)
  (insert "#")
  (when (and
         (looking-back "\".*")
         (looking-at ".*\""))
    (insert "{}")
    (backward-char 1)))

(eval-after-load 'ruby-mode
	'(progn
		 (define-key ruby-mode-map (kbd "#") 'senny-ruby-interpolate)))


;;(setq ruby-indent-tabs-mode t)
(use-package ruby-end)
;;Electric pair mode
(electric-pair-mode t)

(add-hook 'ruby-mode-hook 
					(lambda () 
						(ruby-end-mode 1)
						(diminish 'ruby-end-mode)
						(ruby-tools-mode 1)
						(diminish 'ruby-tools-mode)))


;;Move backups to temp directory.  Who needs that crap, anyway?
;;Note that the temp directory is set to keep them for 30 days, 
;;so it's not entirely stupid.
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;Enable universal copy-paste(to system clipboard).
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-selection-value)

;;flips two windows from horizontal split to vertical split
(defun rotate-windows ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

;;flips what's in two buffers with each other.
(defun flip-windows ()
  "Flip your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(defun run_python_tests ()
  "Run unittest via shell command."
  (interactive)
  (async-shell-command "python -m unittest discover"))

(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "C-c t") 'run_python_tests)))
;; (defun run-tests ()
;;   "Run tests and display result in modeline"
;;   (interactive)
;;   (if (async-shell-command "make test")
;;       "OK"
;;     "error"))
;;TODO: add a modeline for running tests.  Current bug: how to find project root and run there?
;;(add-to-list 'mode-line-misc-info (eval (run-tests)))

;;Sticky-buffer-mode
;; https://gist.github.com/ShingoFukuyama/8797743
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2007-05/msg00975.html
(defvar sticky-buffer-previous-header-line-format)
(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
  (if sticky-buffer-mode
      (progn
        (set (make-local-variable 'sticky-buffer-previous-header-line-format)
             header-line-format)
        (set-window-dedicated-p (selected-window) sticky-buffer-mode))
    (set-window-dedicated-p (selected-window) sticky-buffer-mode)
    (setq header-line-format sticky-buffer-previous-header-line-format)))
