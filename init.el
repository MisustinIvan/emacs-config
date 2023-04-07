;; use-package ;;

(require 'package)
(setq package-archives '(
             ("melpa" . "https://melpa.org/packages/")
             ("org" . "https://orgmode.org/elpa/")
             ("elpa" . "https://elpa.gnu.org/packages/")))

;;(package-refresh-contents)
(unless package-archive-contents
  (package-initialize))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; qol gui stuff ;;

(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 32)

(setq-default
 display-line-numbers 'relative
 display-line-numbers-current-absolute t)

;; disable the line numbers in term mode

(dolist (mode '(
        term-mode-hook
        eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; set font ;;
(set-face-attribute 'default nil :font "Iosevka Nerd Font Mono" :height 200)

;; tabs ;;

(setq-default tab-always-indend nil)
(setq-default tab-width 4)
(setq tab-width 4)

;; scrolling ;;

(setq scroll-margin 5)
(setq scroll-step 1)

;; make <ESC> close prompts ;;

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; zoom in and out ;;

(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)

;; indent rigidly ;;
;; (i dont know if i will ever need this) ;;

(global-set-key (kbd "C-<tab>") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "<backtab>") 'indent-rigidly-left-to-tab-stop)

;; which key ;;

(use-package which-key
  :init (which-key-mode 1)
  :diminish (which-key-mode)
  :config
  (setq which-key-idle-delay 0.5))

;; ivy ;;

(use-package ivy
  :diminish
  :bind (
   ("C-s" . swiper)
   :map ivy-minibuffer-map
   ("TAB" . ivy-alt-done)  
   ("C-;" . ivy-alt-done)
   ("C-k" . ivy-next-line)
   ("C-l" . ivy-previous-line)
   :map ivy-switch-buffer-map
   ("C-l" . ivy-previous-line)
   ("C-;" . ivy-done)
   ("C-d" . ivy-switch-buffer-kill)
   :map ivy-reverse-i-search-map
   ("C-l" . ivy-previous-line)
   ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; counsel ;;

(use-package counsel)

;; dont start searches with ^ ;;
(setq ivy-initial-inputs-alist nil)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x b") 'counsel-ibuffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; themes ;;

(use-package gruber-darker-theme)
(load-theme 'gruber-darker t)

;; rainbow delimiters ;;

(use-package rainbow-delimiters)
(rainbow-delimiters-mode)

;; helpful ;;

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful.command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; flycheck ;;

(use-package flycheck)

;; modeline customization ;;

(column-number-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#e4e4ef" :background "#181818" :box (:line-width 2 :color "#e4e4e")))))
 '(mode-line-buffer-id ((t (:foreground "#ffdd33" :background "#181818"))))
 '(mode-line-buffer-id-inactive ((t (:foreground "#ffdd33" :background "#181818"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "#e4e4ef" :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#181818" :box (:line-width 2 :color "#181818") :weight normal))))
 '(mode-line-mousable ((t (:background "#e4e4ef" :foreground "magenta"))))
 '(mode-line-mousable-minor-mode ((t (:background "#e4e4ef" :foreground "#ffdd33")))))

(set-face-attribute 'mode-line nil  :height 180)

;; language modes ;;
;; svelte ;;
(use-package svelte-mode)

;; golang ;;
(use-package go-mode)


;; LaTeX ;;

(use-package auctex
  :ensure t
  :defer t
  :hook (LaTeX-mode .
          (lambda ()
            (push (list 'output-pdf "Zathura")
		  TeX-view-program-selection))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-list
   '(("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %(output-dir) %t" TeX-run-TeX nil
	  (plain-tex-mode texinfo-mode ams-tex-mode)
	  :help "Run plain TeX")
	 ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
	  (latex-mode doctex-mode)
	  :help "Run LaTeX")
	 ("Makeinfo" "makeinfo %(extraopts) %(o-dir) %t" TeX-run-compile nil
	  (texinfo-mode)
	  :help "Run Makeinfo with Info output")
	 ("Makeinfo HTML" "makeinfo %(extraopts) %(o-dir) --html %t" TeX-run-compile nil
	  (texinfo-mode)
	  :help "Run Makeinfo with HTML output")
	 ("AmSTeX" "amstex %(PDFout) %`%(extraopts) %S%(mode)%' %(output-dir) %t" TeX-run-TeX nil
	  (ams-tex-mode)
	  :help "Run AMSTeX")
	 ("ConTeXt" "%(cntxcom) --once --texutil %(extraopts) %(execopts)%t" TeX-run-TeX nil
	  (context-mode)
	  :help "Run ConTeXt once")
	 ("ConTeXt Full" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
	  (context-mode)
	  :help "Run ConTeXt until completion")
	 ("BibTeX" "bibtex %(O?aux)" TeX-run-BibTeX nil
	  (plain-tex-mode latex-mode doctex-mode context-mode texinfo-mode ams-tex-mode)
	  :help "Run BibTeX")
	 ("Biber" "biber %(output-dir) %s" TeX-run-Biber nil
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Run Biber")
	 ("Texindex" "texindex %s.??" TeX-run-command nil
	  (texinfo-mode)
	  :help "Run Texindex")
	 ("Texi2dvi" "%(PDF)texi2dvi %t" TeX-run-command nil
	  (texinfo-mode)
	  :help "Run Texi2dvi or Texi2pdf")
	 ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
	 ("Print" "%p" TeX-run-command t t :help "Print the file")
	 ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
	 ("File" "%(o?)dvips %d -o %f " TeX-run-dvips t
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Generate PostScript file")
	 ("Dvips" "%(o?)dvips %d -o %f " TeX-run-dvips nil
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Convert DVI file to PostScript")
	 ("Dvipdfmx" "dvipdfmx -o %(O?pdf) %d" TeX-run-dvipdfmx nil
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Convert DVI file to PDF with dvipdfmx")
	 ("Ps2pdf" "ps2pdf %f %(O?pdf)" TeX-run-ps2pdf nil
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Convert PostScript file to PDF")
	 ("Glossaries" "makeglossaries %(d-dir) %s" TeX-run-command nil
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Run makeglossaries to create glossary file")
	 ("Index" "makeindex %(O?idx)" TeX-run-index nil
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Run makeindex to create index file")
	 ("upMendex" "upmendex %(O?idx)" TeX-run-index t
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Run upmendex to create index file")
	 ("Xindy" "texindy %s" TeX-run-command nil
	  (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
	  :help "Run xindy to create index file")
	 ("Check" "lacheck %s" TeX-run-compile nil
	  (latex-mode)
	  :help "Check LaTeX file for correctness")
	 ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
	  (latex-mode)
	  :help "Check LaTeX file for common mistakes")
	 ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
	 ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
	 ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
	 ("Other" "" TeX-run-command t t :help "Run an arbitrary command")
	 ("pdflatex" "pdflatex %s" TeX-run-command nil t)))
 '(package-selected-packages
   '(auctex flycheck-posframe go-mode svelte-mode which-key use-package rainbow-delimiters mood-line ivy-rich helpful gruber-darker-theme flycheck doom-themes counsel)))
