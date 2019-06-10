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
(setq initial-scratch-message "")

;;conservative scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

;;use cmd as meta as well
(setq mac-command-key-is-meta t)

;;semantic mode is from CEDET - more advanced code tools
(semantic-mode 1)

;;Spellchecking in latex mode
(add-hook 'latex-mode-hook 'flyspell-mode)

;;speed up tramp
(setq tramp-default-method "ssh")


;;set font to Hack, if it exists
(set-frame-font "Hack-12" nil t)

;; disable splash screen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-anaconda company-robe company-bbdb company-nxml company-css company-eclim company-semantic company-cmake company-xcode company-clang company-capf company-files
                      (company-dabbrev-code company-gtags company-etags company-keywords)
                      company-oddmuse company-dabbrev)))
 '(face-font-family-alternatives
   (quote
    (("Monospace" "courier" "fixed")
     ("courier" "CMU Typewriter Text" "fixed")
     ("Sans Serif" "helv" "helvetica" "arial" "fixed")
     ("helv" "helvetica" "arial" "fixed"))))
 '(inhibit-startup-screen t)
 '(ledger-clear-whole-transactions t)
 '(ledger-reports
   (quote
    (("reg" "ledger [[ledger-mode-flags]] -f /Users/deus-mac/Documents/finances/ledger/ledger-2019.dat reg not Equity")
     ("balr" "ledger --real")
     ("bal" "ledger [[ledger-mode-flags]] -f /Users/deus-mac/Documents/finances/ledger/ledger-2019.dat bal not Equity")
     ("balance" "ledger -f ledger-2019.dat")
     ("currentbalance" "ledger ")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)"))))
 '(org-capture-templates
   (quote
    (("t" "todo list" entry
      (file "~/org/todo.org")
      "* TODO (%(org-read-date)): %^{task}" :immediate-finish t)
     ("n" "Take a note" plain
      (file "~/org/notes.org")
      "%(org-read-date): %^{note}" :immediate-finish t)
     ("l" "insert item into ledger" plain
      (file "~/Documents/finances/ledger/ledger-2019.dat")
      "%(org-read-date) %^{Payee}
	%^{Account|Expenses:Eating Out|Expenses:Groceries}  %^{Currency|NIS }%^{Amount}
	%^{Payer|Assets:BHP Checking|Assets:Cash}" :empty-lines 1))))
 '(package-selected-packages
   (quote
    (pdf-tools ledger-mode chruby exec-path-from-shell stripe-buffer nand2tetris-assembler nand2tetris ruby-additional mpdel company-ghc ghc intero omnisharp csharp-mode arduino-mode realgud-byebug realgud-pry go-mode zerodark-theme hc-zenburn-theme yas-global-mode yas-mode yasnippet-snippets diminish feature-mode auto-virtualenv anaconda-mode haskell-mode markdown-mode lua-mode company flycheck ini-mode bundler rspec robe rinari flx-ido web-mode projectile-rails anzu ess lua tuareg use-package haml-mode pianobar names csv-mode yasnippet yaml-mode ruby-tools ruby-end rspec-mode realgud magit json-mode hi2 guru-mode ghci-completion flymake flycheck-hdevtools f ensime company-inf-ruby browse-kill-ring+ autopair aggressive-indent ac-inf-ruby ac-haskell-process))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-symbol-face ((t (:foreground "blue")))))
;;Tab size
(setq-default tab-width 2)
(require 'package)

;;Load autoinstalled packages(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa-stable.milkbox.net/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
	(package-install 'use-package))

(eval-when-compile
	(require 'use-package))
(setq use-package-always-ensure t)
(setq use-package-always-defer t)
;;dark high-contrast theme
(use-package hc-zenburn-theme
  :init
  (load-theme 'hc-zenburn t))

;;manually-set variables
(global-set-key [insert] 'compile)
;;goto line
(global-set-key "\C-l" 'goto-line)
;;go one fram backward
(global-set-key (kbd "C-x x") '(lambda () "frame-back one" (interactive) (other-window -1)))
;; cycle through amounts of spacing - from http://pragmaticemacs.com/emacs/cycle-spacing/
(global-set-key (kbd "M-SPC") 'cycle-spacing)

(setq nxml-sexp-element-flag t)
(use-package diminish)

(use-package magit
  :bind
	("C-x g" . magit-status)
  )

(diminish 'autocomplete-mode)
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
  :defer 0)

;;flycheck
(use-package flycheck
  :config
  (global-flycheck-mode t)
  ;; from https://github.com/Wilfred/flycheck-pyflakes/
  (add-to-list 'flycheck-disabled-checkers 'python-flake8)
  (add-to-list 'flycheck-disabled-checkers 'python-pylint)
  (add-to-list 'flycheck-disabled-checkers 'emacs-list-checkdoc)
  (flycheck-define-checker python-pyflakes
  "A Python syntax and style checker using the pyflakes utility.
See URL `http://pypi.python.org/pypi/pyflakes'."
  :command ("pyflakes" source-inplace)
  :error-patterns
  ((error line-start (file-name) ":" line ":" (message) line-end))
  :modes python-mode anaconda-mode)
  (add-to-list 'flycheck-checkers 'python-pyflakes))



;;Company-mode - autocompletion
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
	:config
  (push 'company-robe company-backends)
  (add-to-list 'company-backends 'company-anaconda)
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0)
	:diminish company-mode)

;;realgud better debugging
(use-package realgud
  :defer 0)
(use-package realgud-pry
  :after realgud)
(use-package realgud-byebug
  :after realgud)

;;org-mode settings
(use-package org
	:config
	(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
	(add-hook 'org-mode-hook 'visual-line-mode)
  (global-font-lock-mode 1)
  (setq org-startup-indented 1)
  :diminish org-indent-mode
  :bind
	("C-c l" . org-store-link)
	("C-c a" . org-agenda)
  ("C-c c" . org-capture))

;;visual line mode in text mode
(add-hook 'text-mode-hook 'visual-line-mode)

;;lua-mode
(use-package lua-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
	(add-to-list 'interpreter-mode-alist '("lua" . lua-mode)))

;;ido-mode
(use-package ido
  :init
  (ido-mode 1)
	:config
	(setq ido-enable-flex-matching t)
	(setq ido-use-faces nil)
	(setq ido-everywhere t)
	(setq ido-auto-merge-work-directories-length -1)) ;; disable auto-merge
;;flx-mode for better string matching
(use-package flx-ido
	:config
	(flx-ido-mode 1))

;;Markdown mode
(use-package markdown-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
	(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
	(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (setq markdown-command "pandoc -s"))

;;Yaml mode
(use-package yaml-mode)
;;guru-mode
(use-package guru-mode
	:init
	(guru-global-mode +1)
	:diminish guru-mode)

;;Aggressive-indent-mode instead of electric-indent-mode.  Will indent blocks automatically.
(use-package aggressive-indent
	:config
	(global-aggressive-indent-mode 1)
	(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
	(add-to-list 'aggressive-indent-excluded-modes 'ess-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'python-mode)
	:diminish aggressive-indent-mode)

;;Haskell
(use-package haskell-mode
	:config
	(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
	(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
	;;indent/dedent region
	(define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
	(define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
	(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(use-package intero
  :diminish intero-mode
  :hook (haskell-mode . intero-global-mode))
(use-package ghc
  :config
  :hook (haskell-mode . ghc-comp-init))
(use-package company-ghc
  :after ghc)
;;Python
(use-package anaconda-mode
  :config
  (add-hook 'python-mode-hook 'anaconda-mode))
(use-package auto-virtualenv
	:config
	(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
	(add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv))

;;pianobar
(use-package pianobar
	:config
	(setq pianobar-username "scrappydoo1891@gmail.com")
	(setq pianobar-password "")
	(setq pianobar-station "18")
	(global-set-key (kbd "C-x p p") 'pianobar-play-or-pause)
	(global-set-key (kbd "C-x p n") 'pianobar-next-song)
	(global-set-key (kbd "C-x p s") 'pianobar-change-station)
	(global-set-key (kbd "C-x p l") 'pianobar-love-current-song)
	(global-set-key (kbd "C-x p b") 'pianobar-ban-current-song))

;;ess-mode for statistics
(use-package ess
	:config
	(require 'ess-site))
;;Anzu - show count of matches
(use-package anzu
	:config
	(global-anzu-mode 1)
	;;(global-set-key (kbd "M-%") 'anzu-query-replace)
	;;(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)
	:diminish anzu-mode
	)
(use-package projectile
  :defer 0
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
	(projectile-mode)
  :diminish projectile-mode)
(use-package bundler)
;;next set of packages are for rails
(use-package projectile-rails
	:config
	(add-hook 'projectile-mode-hook 'projectile-rails-on)
	(define-key projectile-rails-command-map (kbd "A") (lambda() (interactive) (shell-command "bundle exec rake test")))
	)
(lambda() (shell-command "bundle exec rake test"))

(use-package rspec-mode
	:diminish rspec-mode)

(use-package web-mode
  :defer 0
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

;;ruby stuff
(use-package chruby
  :hook ruby-mode
  :config
  (chruby "2.5.3"))
(use-package robe
	:config
	(add-hook 'ruby-mode-hook 'robe-mode)
	:diminish robe-mode)

(use-package feature-mode
  :mode
  ("\.feature$" . feature-mode))

;; .ini files
(use-package ini-mode
	:diminish ini-mode)

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :diminish yas-mode)

(use-package yasnippet-snippets)

(use-package csharp-mode)
(use-package omnisharp
  :after company
  :config
  (add-hook 'csharp-mode-hook 'omnisharp-mode)
  (add-to-list 'company-backends 'company-omnisharp))

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

;;http://wikemacs.org/wiki/Shell#Shell_completion_with_a_nice_menu_.C3.A0_la_zsh
(add-hook 'shell-mode-hook #'company-mode)


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

(add-to-list 'auto-mode-alist '("\\.god$" . ruby-mode))

;;(setq ruby-indent-tabs-mode t)
(use-package ruby-end)
;;Electric pair mode
;;https://github.com/daedreth/UncleDavesEmacs
(setq electric-pair-pairs '((?\` . ?\`)))
(electric-pair-mode t)

(add-hook 'ruby-mode-hook 
					(lambda () 
						(ruby-end-mode 1)
						(diminish 'ruby-end-mode)))
(add-hook 'ruby-mode-hook 'hs-minor-mode)


(use-package arduino-mode
  :mode "\\.ino$")

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

(use-package go-mode
  :hook (before-save . gofmt-before-save))
(put 'downcase-region 'disabled nil)

(use-package nand2tetris
  :config
  (setq nand2tetris-core-base-dir "~/code/nand2tetris")
  (add-hook 'nand2tetris-mode 'company-mode)
  (add-hook 'nand2tetris-mode 'company-nand2tetris)
  :mode
  ("\.*\\.hdl" . 'nand2tetris-mode))
(use-package nand2tetris-assembler)

(use-package stripe-buffer
  :defer 0
  :config
  (add-hook 'dired-mode-hook 'turn-on-stripe-buffer-mode)
  (add-hook 'org-mode-hook 'turn-on-stripe-table-mode))

;;https://superuser.com/questions/576447/enable-hideshow-for-more-modes-e-g-ruby
(use-package hideshow
  :diminish hs-minor-mode
  :config
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do" "{" "["))
                 ,(rx (or "}" "]" "end"))
                 ,(rx (or "#" "=begin"))
                 ruby-forward-sexp nil))
  (global-set-key (kbd "C-c h") 'hs-hide-block)
  (global-set-key (kbd "C-c s") 'hs-show-block))

;;ledger mode for accounting.
;;Accounts are stored in Documents/finances/ledger/ledger-xxxx.dat
(use-package ledger-mode
  :mode ("\\.dat\\'"
         "\\.ledger\\'")
  :custom (ledger-clear-whole-transactions t))
