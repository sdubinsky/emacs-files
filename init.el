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

;;move windows with shift-arrow
;;https://stackoverflow.com/questions/16607791/emacs-move-around-split-windows-in-a-specified-direction
(windmove-default-keybindings)

;;scratch buffer default mode - https://emacs.stackexchange.com/questions/53875/change-scratch-buffer-to-org-mode-by-default
(setq initial-major-mode 'org-mode)
;;sort dired by numbers, not sure what all the switches do
(setq dired-listing-switches "-1aGh1vl")
(prefer-coding-system 'utf-8)
(put 'narrow-to-region 'disabled nil)
;; set large file warning threshold higher
(setq large-file-warning-threshold 900000000)

;;native scrolling - https://emacs.stackexchange.com/questions/26988/set-scroll-amount-for-mouse-wheel-in-emacs
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;;I don't really want to accidentally suspend emacs a lot
;;If this comes up a lot in terminal, redefine the key instead
;;from https://www.gnu.org/software/emacs/manual/html_node/emacs/Disabling.html#Disabling
(global-set-key (kbd "C-z") nil)

;;this is just obnoxious
(global-set-key (kbd "C-v") nil)
(global-set-key (kbd "M-v") nil)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
;;conservative scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

;;use cmd as meta as well
(setq mac-command-key-is-meta t)

;;Spellchecking in latex mode
(add-hook 'latex-mode-hook 'flyspell-mode)

;;speed up tramp
(setq tramp-default-method "ssh")

;;set font to Hack, if it exists
(add-to-list 'default-frame-alist '(font . "Hack-12"))
(setq my-ledger-file "~/Documents/finances/ledger/ledger-2021.dat")
(load "~/emacs-files/locals.el")

;;Load autoinstalled packages(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; disable splash screen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   '(company-robe company-bbdb company-nxml company-css company-semantic company-cmake company-clang company-capf company-files
                  (company-dabbrev-code company-keywords)
                  company-oddmuse company-dabbrev))
 '(doc-view-continuous t)
 '(face-font-family-alternatives
   '(("Monospace" "courier" "fixed")
     ("courier" "CMU Typewriter Text" "fixed")
     ("Sans Serif" "helv" "helvetica" "arial" "fixed")
     ("helv" "helvetica" "arial" "fixed")))
 '(inhibit-startup-screen t)
 '(org-agenda-files '("~/org notes and todos/todo.org"))
 '(org-capture-templates
   '(("t" "todo list" entry
      (file "~/org notes and todos/todo.org")
      "* TODO (%(org-read-date)) NEMO-%^{ticket id}: %^{summary}" :prepend t :immediate-finish t)
     ("n" "Take a note" item
      (file "~/org/notes.org")
      "%(org-read-date): %^{note}" :prepend t :immediate-finish t)
     ("l" "insert item into ledger" plain
      (file my-ledger-file)
      "%(org-read-date) %^{Payee}
	%^{Account|Expenses:Groceries|Expenses:Eating Out|Expenses:Transportation:Gas|Expenses:Electronica|Expenses:Apartment:Household Needs|Expenses:Basic Necessities|Expenses:Medical|Expenses:Entertainment|Expenses:Fencing Database:Hosting|Expenses:Fencing:Membership|Expenses:Fencing:Lessons|Accounts:Bankroll|Accounts:Poker|Accounts:BHP Credit|Assets:BHP Checking|Assets:Cash|Assets:Ally Checking|Expenses:Tzedaka}  %^{Currency|NIS |$}%^{Amount}
	%^{Payer|Accounts:BHP Credit|Assets:BHP Checking|Assets:Cash|Assets:Ally Checking|Accounts:Credit Cards:Discover|Accounts:Bankroll|Accounts:Poker|Income:Tutoring|Income:Salary|Accounts:Bankroll}" :empty-lines 1)))
 '(package-selected-packages
   '(coffee-mode slim-mode expand-region list-utils htmlize poetry company-org-roam dumb-jump company-tabnine doom-modeline all-the-icons god-mode undo-tree ripgrep forge python-mode dockerfile-mode dired-narrow semantic-mode gnu-elpa-keyring-update csv rainbow-delimiters projectile restclient pdf-tools ledger-mode chruby exec-path-from-shell stripe-buffer nand2tetris-assembler nand2tetris ruby-additional mpdel company-ghc ghc omnisharp csharp-mode arduino-mode realgud-byebug realgud-pry go-mode zerodark-theme hc-zenburn-theme yas-global-mode yas-mode yasnippet-snippets diminish feature-mode auto-virtualenv anaconda-mode markdown-mode lua-mode company flycheck ini-mode bundler rspec robe rinari flx-ido web-mode projectile-rails anzu ess lua tuareg use-package haml-mode pianobar names csv-mode yasnippet yaml-mode ruby-tools ruby-end rspec-mode realgud magit json-mode hi2 guru-mode ghci-completion flymake flycheck-hdevtools f ensime company-inf-ruby browse-kill-ring+ autopair aggressive-indent ac-inf-ruby ac-haskell-process))
 '(pyvenv-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-symbol-face ((t (:foreground "blue")))))
;;Tab size
(setq-default tab-width 2)
(require 'package)

(eval-when-compile
	(require 'use-package))
(setq use-package-always-ensure t)
(setq use-package-always-defer t)

;;system packages - from the use-package readme
(use-package use-package-ensure-system-package)

;;dark high-contrast theme
(use-package hc-zenburn-theme
  :init
  (load-theme 'hc-zenburn t))

;; doom modeline.  Don't forget to run (all-the-icons-install-fonts)
(use-package all-the-icons)
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-unicode-fallback nil)
  (setq doom-modeline-buffer-encoding nil))

;;manually-set variables
(global-set-key [insert] 'realgud:pry)
;;goto line
(global-set-key "\C-l" 'goto-line)
;;go one fram backward
(global-set-key (kbd "C-x x") '(lambda () "frame-back one" (interactive) (other-window -1)))
;; cycle through amounts of spacing - from http://pragmaticemacs.com/emacs/cycle-spacing/
(global-set-key (kbd "M-SPC") 'cycle-spacing)

;;calculate miles per gallon
(defun mpg (old new liters)
  "Calculate MPG."
  (interactive "nold mileage: \nnnew mileage: \nnliters: ")
  (insert (format ";;%.2f liters\n;;%.2f MPG.\n;;ODO: %d" liters (* (/ (- new old) liters) 2.352) new)))

(setq nxml-sexp-element-flag t)
(use-package diminish)

(use-package magit
  :bind
	("C-x g" . magit-status)
  )
(use-package forge
  :after magit
  )

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize)
  :defer 0)

(use-package sql
  :ensure nil
  :config
  (sql-set-product 'postgres))

;;flycheck
(use-package flycheck
  :defer 0
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
  :modes python-mode)
  (add-to-list 'flycheck-checkers 'python-pyflakes))

;;org-roam autocomplete
(use-package company-org-roam
  :config
  (add-to-list 'company-org-roam 'company-backends))


;;Company-mode - autocompletion
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
	:config
  (setq company-dabbrev-downcase nil)
  (setq company-idle-delay 0)
  (setq company-require-match nil)
	:diminish company-mode)

;;advice https://framagit.org/steckerhalter/steckemacs.el/blob/master/steckemacs.el
(use-package advice
  :ensure nil
  :config
  (defadvice kill-buffer (around kill-buffer-around-advice activate)
    "Bury scratch instead of killing it"
    (let ((buffer-to-kill (ad-get-arg 0)))
      (if (equal buffer-to-kill "*scratch*")
          (bury-buffer)
        ad-do-it))))

;;undo-tree-mode better undoing and redoing
(use-package undo-tree
  :bind (("C-c z" . undo-tree-visualize))
  :config
  (global-undo-tree-mode t))

;;realgud better debugging
(use-package realgud
  :defer 0
  :config
  (put 'realgud:pdb-command-name 'safe-local-variable #'stringp)
  (setq realgud:pdb-command-name "python"))
(use-package realgud-pry
  :hook ruby-mode)


;;org-mode settings
(use-package org
	:config
	(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
	(add-hook 'org-mode-hook 'visual-line-mode)
  (global-font-lock-mode 1)
  (setq org-startup-indented 1)
  (setq org-return-follows-link 1)
  (setq org-directory "~/org notes and todos")
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

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
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

;;Aggressive-indent-mode instead of electric-indent-mode.  Will indent blocks automatically.
(use-package aggressive-indent
	:config
	(global-aggressive-indent-mode 1)
	(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
	(add-to-list 'aggressive-indent-excluded-modes 'ess-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'python-mode)
	:diminish aggressive-indent-mode)

;;god mode - no more holding down the control key.
(use-package god-mode
  :bind ("C-c g" . god-local-mode)
  (:map god-local-mode-map
        ("z" . repeat)
        ("i" . god-local-mode)))

;;Haskell
(use-package haskell-tng-mode
  :ensure nil
  :load-path "/home/deus-ex/.emacs.d/haskell-tng.el/"
  :mode ((rx ".hs" eos) . haskell-tng-mode)

  :config
  (require 'haskell-tng-extra)
  (require 'haskell-tng-extra-abbrev)
  (require 'haskell-tng-extra-hideshow)
  (require 'haskell-tng-extra-company)
  (require 'haskell-tng-extra-projectile)
  (require 'haskell-tng-extra-yasnippet)
  ;; (require 'haskell-tng-extra-cabal-mode)
  (require 'haskell-tng-extra-stack)

  :bind
  (:map
   haskell-tng-mode-map
   ("RET" . haskell-tng-newline)
   ("C-c c" . haskell-tng-compile)
   ("C-c e" . next-error)))

;;Python
(use-package auto-virtualenv
	:config
	(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
  (add-hook 'projectile-after-switch-project-hook (lambda () (exec-path-from-shell-copy-env "PATH")))
	(add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv))
(use-package pyvenv
  :diminish t
  :hook (python-mode . pyvenv-mode))
(use-package poetry
  :config
  (poetry-tracking-mode t))

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
  (projectile-register-project-type 'sinatra '("Gemfile")
                                    :run "bundle exec ruby config.ru"
                                    :test "bundle exec rake test"
                                    :test-dir "test"
                                    :test-prefix "test_")
	(projectile-mode)
  (put 'projectile-project-test-cmd 'safe-local-variable #'stringp)
  (setq projectile-switch-project-action #'projectile-dired)
  :diminish projectile-mode)

(use-package ripgrep
  :ensure-system-package (rg . ripgrep))

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
  :config
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-quoting t)
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
  :hook ruby-mode)
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
						(diminish 'ruby-end-mode)
            (chruby-use-corresponding)))
(add-hook 'ruby-mode-hook 'hs-minor-mode)


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

(use-package stripe-buffer
  :defer 0
  :config
  (add-hook 'dired-mode-hook 'turn-on-stripe-buffer-mode)
  (add-hook 'org-mode-hook 'turn-on-stripe-table-mode))

;;https://superuser.com/questions/576447/enable-hideshow-for-more-modes-e-g-ruby
(use-package hideshow
  :diminish hs-minor-mode
  :hook (prog-mode . hs-minor-mode)
  :config
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do" "{" "["))
                 ,(rx (or "}" "]" "end"))
                 ,(rx (or "#" "=begin"))
                 ruby-forward-sexp nil))
  (global-set-key (kbd "C-c h") 'hs-toggle-hiding))

;;ledger mode for accounting.
;;Accounts are stored in Documents/finances/ledger/ledger-xxxx.dat
(use-package ledger-mode
  :mode ("\\.dat\\'"
         "\\.ledger\\'")
  :config
  (setq ledger-reports
        `(("bal" ,(concat "%(binary) [[ledger-mode-flags]] -f " my-ledger-file " bal not Equity -E --current"))
     ("reg" ,(concat "%(binary) [[ledger-mode-flags]] -f " my-ledger-file " reg not Equity -S -date --current"))
     ("balr" ,(concat "%(binary) [[ledger-mode-flags]] -f " my-ledger-file " bal not Equity -E --real --current"))
     ("salary" ,(concat "%(binary) [[ledger-mode-flags]] -f " my-ledger-file " reg 'BHP Checking' --limit 'payee=~/Colabo/' -S date --current -b 'this month'"))
     ("payee" "%(binary) -f %(my-ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(my-ledger-file) reg %(account)")))
  
  :custom (ledger-clear-whole-transactions t))

(use-package restclient
  :mode ("\\.http\\'" . restclient-mode))

(use-package csv
  :mode ("\\.csv\\'" . csv-mode))

;;semantic mode is from CEDET - more advanced code tools
(use-package semantic
  :defer 0
  :bind
  (("C-c ." . semantic-complete-jump))
  :config
  (setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                    global-semanticdb-minor-mode
                                    global-semantic-highlight-func-mode
                                    global-semantic-idle-local-symbol-highlight-mode
                                    ))
  (add-hook 'prog-mode-hook #'semantic-mode))


;;from http://pragmaticemacs.com/emacs/dynamically-filter-directory-listing-with-dired-narrow/
(use-package dired-narrow
  :demand
  :bind
  (:map dired-mode-map ("/" . dired-narrow-regexp)))

(use-package dockerfile-mode)

(use-package arm-mode
  :load-path "elpa/arm-mode/"
  :mode ("\\.s\\'"))

;;Org-roam, for zettelkasten
(use-package org-roam
  :diminish org-roam
      :hook
      (after-init . org-roam-mode)
      :config
      (setq org-roam-link-title-format "R:%s")
      (setq org-roam-completion-system 'ido)
      (setq org-roam-capture-templates 
            '(("d" "default" plain (function org-roam-capture--get-point)
               "#+ROAM_TAGS: %?"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+TITLE: ${title}\n"
               :unnarrowed t)))
      :custom
      (org-roam-directory "~/org notes and todos/roam")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n j" . org-roam-jump-to-index)
               ("C-c n b" . org-roam-switch-to-buffer)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))))

;;dump-jump, go to definition.  Better than tags
(use-package dumb-jump
  :defer 0
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package htmlize
  :config
  (setq htmlize-output-type 'inline-css))

(use-package css-mode
  :ensure nil
  :config
  (setq css-indent-offset 2))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package slim-mode
  :bind
  ("C-c TAB" . (lambda ()
                 (interactive)
                 (goto-char (region-beginning))
                 (slim-reindent-region-by 2))))

(use-package coffee-mode)
