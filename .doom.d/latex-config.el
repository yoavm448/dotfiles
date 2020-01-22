;;; ~/.doom.d/latex-config.el -*- lexical-binding: t; -*-

(load "~/.doom.d/cdlatex-config.el")

(defvar prvt/use-TeX-fold t
  "Use TeX fold in TeX-mode.
When set to non-nil, this adds a few hooks/advices to fold stuff.")

(setq
 TeX-electric-sub-and-superscript nil ;; dont auto-insert braces on _^
 TeX-save-query nil ;; just save, dont ask me
 preview-auto-cache-preamble t ;; just cache, dont ask me
 ;; preview-auto-reveal '(eval
 ;; (preview-arrived-via
 ;; (key-binding [left])
 ;; (key-binding [right])
 ;; 'backward-char 'forward-char
 ;; 'backward-word 'forward-word))
 )



(when prvt/use-TeX-fold
  (setq TeX-fold-math-spec-list '(;; missing symbols
                                  ("≤" ("le"))
                                  ("≥" ("ge"))
                                  ("≠" ("ne"))
                                  ;; conviniance shorts
                                  ("‹" ("left"))
                                  ("›" ("right"))
                                  ;; private macros
                                  ("ℝ" ("RR"))
                                  ("ℕ" ("NN"))
                                  ("ℚ" ("QQ"))
                                  ("ℤ" ("ZZ"))
                                  ("ℂ" ("CC"))
                                  ("𝔽" ("FF")))
        ;; TeX-fold-macro-spec-list '(;; General conviniance
        ;; ("√{1}" ("sqrt"))
        ;; Private macros
        ;; ("({1})" ("pa"))
        ;; ("[{1}]" ("bra"))
        ;; ("{{1}}" ("bre"))
        ;; ("[{1})" ("bpa"))
        ;; ("({1}]" ("pba"))
        ;; ("|{1}|" ("abs"))
        ));)

(load! "fontification") ;;
(appendq! font-latex-match-math-command-keywords
          '(("oner")
            ("half")
            ("pa")
            ;; ("ln") ;;
            ("bra")
            ("bre")
            ("pba")
            ("bpa")
            ("abs")))


(defface unimportant-latex-face
  '((t
     :inherit font-lock-comment-face))
  "Face used to make obstructive commands (such as \\(, \\[) less visible."
  :group 'LaTeX-math)

(font-lock-add-keywords
 'latex-mode
 `((,(rx (and "\\" (any "()[]"))) 0 'unimportant-latex-face prepend))
 'end)


(custom-set-faces! '(rainbow-delimiters-depth-1-face :foreground nil :inherit rainbow-delimiters-depth-6-face)) ;; on default, 1-D braces look ordinary in latex math
(custom-set-faces! '(preview-reference-face :inherit solaire-default-face)) ;; fixes latex preview background color in solaire
(custom-set-faces! '(preview-face :inherit org-block)) ;; just configured for the theme
(custom-set-faces! '(TeX-fold-folded-face :inherit font-lock-builtin-face)) ;; just configured for the theme

;;;###autoload
(defun prvt/TeX-fold-current-line (&rest ignored)
  "folds current line, mostly used as a hook to fold math."
  (interactive)
  (TeX-fold-region (line-beginning-position) (line-end-position)))


(add-hook! 'TeX-mode-hook :append
           ;; (hl-todo-mode) ;; FIXME
           ;; (LaTeX-math-mode) - moved to cdlatex which is better
           (setq preview-scale 1.8 ;; bigger compiled math cause Im just used to it
                 company-idle-delay nil)) ;; auto-complete is annoying here

(after! tex
  (when prvt/use-TeX-fold
    (advice-add 'LaTeX-math-insert :after 'prvt/TeX-fold-current-line) ;; auto-fold after inserting math macro with prefix
    (advice-add 'LaTeX-insert-item :after 'prvt/TeX-fold-current-line)) ;; auto-fold after inserting math macro with prefix
  (map!
   :map LaTeX-mode-map
   :ei [C-return] 'LaTeX-insert-item
   ;; backspace alias
   :i "M-h" (lambda! (insert "\\"))
   ;; ^{} _{} aliases
   :iv "C-_" (lambda! (doom-snippets-expand :name "subscript-braces"))
   :iv "C-^" (lambda! (doom-snippets-expand :name "superscript-braces"))

   ;; normal stuff here
   (:localleader
     :desc "View" "v" #'TeX-view
     (:when prvt/use-TeX-fold
       :desc "Fold paragraph"     "f"   #'TeX-fold-paragraph
       :desc "unFold paragraph"   "C-f" #'TeX-fold-clearout-paragraph
       :desc "Fold buffer"        "F"   #'TeX-fold-buffer
       :desc "unFold buffer"      "C-F" #'TeX-fold-clearout-buffer)
     :desc "Preview at point"   "p"   #'preview-at-point
     :desc "Preview buffer"     "P"   #'preview-buffer
     :desc "Unpreview buffer"   "C-p" #'preview-clearout-buffer

     ;; override C-c C-c to compile with xetex
     :desc "compile with xetex" "c" (lambda! () (let ((TeX-engine 'xetex))
                                                  (TeX-command "LaTeX" 'TeX-master-file))))))
