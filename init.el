;; ===========================================
;; FileName: .emacs.d
;; Author: Gao DaoJing (@Irvvin)
;; Email: gaodaojing@gmail.com
;; Site: http://gaodaojing.com
;; Version: 1.0
;; ===========================================

(add-to-list 'load-path "~/.emacs.d")
;; (add-to-list 'load-path "~/.emacs.d/conf")

;; Basic {{{
  ;; (load "basic")

  ;; ���ø�����Ϣ
  (setq user-full-name "Gao DaoJing")
  (setq user-mail-address "gaodaojing@gmail.com")

  ;; ��ʼ������
  (setq-default inhibit-startup-screen t)
  (setq-default initial-scratch-message nil)
  (setq-default initial-major-mode 'emacs-lisp-mode)

  ;; ��ʾ�к�
  (global-linum-mode t)

  ;; ��ʾƥ�������
  (show-paren-mode t)

  ;; ����ʱ���ʽ
  (setq-default display-time-24hr-format t)
  (setq-default display-time-day-and-date nil)

  ;; ��״̬����ʾ���к�
  (setq-default line-number-mode t)
  (setq-default column-number-mode t)

  ;; �رշ��˵ĳ���ʱ����ʾ��
  (setq-default visible-bell t)

  ;; ʹ�� "y/n" ���� "yes/no"
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; �Ʊ��
  (setq-default tab-width 2)
  (setq-default indent-tabs-mode nil)
  (setq x-stretch-cursor t)

  ;; �����ڻ�������ʾ����
  (setq-default echo-keystrokes -1)

  ;; �ڱ���֮ǰɾ����ĩ�հ�
  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; ������һ�����з������ļ�
  (setq-default require-final-newline t)

  ;; �ɲ˵��޸����õĶ������ᱣ���� custom-file ��
  (setq-default custom-file "~/.emacs.d/.custom-file.el")
  (if (file-exists-p custom-file) (load custom-file))

  ;; ��������
  (setq-default make-backup-file t)
  (setq version-control t)
  (setq kept-old-versions 2)
  (setq kept-new-versions 5)
  (setq delete-old-versions t)
  (setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
  (setq backup-by-copying t)

  ;; ֧��emacs���ⲿ�����ճ��
  (setq-default x-select-enable-clipboard t)

  ;; ����ƥ��ʱ��ʾ����һ�ߵ����ţ���������ת����һ������
  (when (fboundp 'show-paren-mode)
    (show-paren-mode t)
    (setq-default show-paren-style 'parentheses))

  ;; ��꿿��ʱ����겻��
  (mouse-avoidance-mode 'none)

  ;; ��ֹ������Ļ��˸
  (when (fboundp 'blink-cursor-mode)
    (blink-cursor-mode -1)
    (setq-default visible-bell nil))

  ;; ��Ҫ����������Ǹ��ط��������������
  (setq-default mouse-yank-at-point t)

  ;; �ݹ�ʹ�� minibuffer
  (setq-default enable-recursive-minibuffers t)

  ;; �ڱ�������ʾ buffer ������
  (setq-default frame-title-format '(buffer-file-name "%f" ("%b")))

  ;; ����Ĭ�ϵĿ⣬default.el
  (setq-default inhibit-default-init t)

  ;; ����ʹ text-mode ÿ 80 ���ַ��Զ�����
  (add-hook 'text-mode-hook 'turn-on-auto-fill)
  (setq-default fill-column 80)

  ;; �Ƚϲ����ļ�ʱ���� -u ģʽ
  (setq-default diff-switches "-u")

  ;; ��ʾ��β�Ŀհ��ַ�
  (setq-default show-trailing-whitespace 1)

  ;; ��ʾ�ļ���β�Ŀ���
  (setq-default indicate-empty-lines 1)

  ;; ibuffer
  (defalias 'list-buffers 'ibuffer)

  ;; ȡ��ԭ��������������
  (put 'narrow-to-region 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'scroll-left 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'erase-buffer 'disabled nil)

  ;; ��������
  (set-face-attribute
   'default nil :font "Source Code Pro 12")

  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Microsoft YaHei" :size 14)))
;; }}}


;; Initialise el-get {{{

  (require 'package)
  (package-initialize)

  ;(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")
  (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

  (unless (require 'el-get nil 'noerror)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
      (let (el-get-master-branch)
        (goto-char (point-max))
        (eval-print-last-sexp))))

  ;; personal recipes
  (setq el-get-sources
        '((:name el-get :branch "master")))

  ;; my package
  (setq my-packages
        (append
          '(el-get
            org-mode
            autopair
            tabbar-ruler
            yasnippet
            auto-complete
            markdown-mode
            solarized-theme
            tomorrow-theme
            web-mode
            js2-mode
            jshint-mode
            ruby-mode
            ruby-end
            inf-ruby
            ruby-compilation
            slim-mode
            haml-mode
            yaml-mode
            scss-mode
            coffee-mode
            rinari)

         (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))

  (el-get 'sync my-packages)


  ;; my packages setting
  ;; (load "plugin")

  ;; theme
  ;; (load-theme 'solarized-dark t)
  (require 'color-theme-tomorrow)
  (color-theme-tomorrow--define-theme night-eighties)

  ;; autopair
  (require 'autopair)
  (autopair-global-mode)

  ;; tabbar-ruler
  (setq tabbar-ruler-global-tabbar t) ; If you want tabbar
  (setq tabbar-ruler-global-ruler t) ; if you want a global ruler
  (require 'tabbar-ruler)

  (global-set-key (kbd "<M-up>") 'tabbar-backward-group)
  (global-set-key (kbd "<M-down>") 'tabbar-forward-group)
  (global-set-key (kbd "<M-left>") 'tabbar-backward)
  (global-set-key (kbd "<M-right>") 'tabbar-forward)

  ;; yasnippet
  (require 'yasnippet)
  (yas/global-mode 1)
  (yas/minor-mode-on)

  ;; auto-complete
  (require 'auto-complete)
  (require 'auto-complete-config)
  (ac-config-default)

  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous)

  (dolist (mode '(magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode
                  sass-mode scss-mode yaml-mode csv-mode espresso-mode haskell-mode
                  html-mode nxml-mode sh-mode smarty-mode clojure-mode
                  lisp-mode textile-mode markdown-mode tuareg-mode
                  js2-mode css-mode less-css-mode coffee-mode))
   (add-to-list 'ac-modes mode))

  ;; web-mode
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ftl\\'" . web-mode))

  ;; ruby-mode
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation)))

  ;; rhtml
  (add-to-list 'auto-mode-alist '("\\.eco$" . rhtml-mode))

  ;; rinari
  (global-rinari-mode)

;; }}}


;; Keybind {{{
  ;; (load "dekey")

  ;; set mark keymap
  (global-set-key (kbd "M-SPC") 'set-mark-command)

  ;; set goto-line
  (define-key ctl-x-map "l" 'goto-line)

;; }}}


;; Defunction {{{
  ;; (load "defun")

  ;; {{{
  ;; �޸�"M-;"ע�ͷ�ʽ
  ;; ��û�м��������ע��/��ע�͵�ǰ�У�������β��ʱ�������β��ע��
  (defun emacs-comment-dwim-line (&optional arg)
    "Replacement for the comment-dwim command.
  If no region is selected and current line is not blank and we are not at the end of the line,
  then comment current line.
  Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
    (interactive "*P")
    (comment-normalize-vars)
    (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
        (comment-or-uncomment-region (line-beginning-position) (line-end-position))
      (comment-dwim arg)))
  (global-set-key "\M-;" 'emacs-comment-dwim-line)
  ;; }}}

  ;; {{{
  ;; �޸�"Alt-w"����û�м��������ʱ�͸��Ƶ�ǰ����
  ;; Smart copy, if no region active, it simply copy the current whole line
  (defadvice kill-line (before check-position activate)
    (if (member major-mode
                '(emacs-lisp-mode scheme-mode lisp-mode
                                  c-mode c++-mode objc-mode js-mode
                                  latex-mode plain-tex-mode))
        (if (and (eolp) (not (bolp)))
            (progn (forward-char 1)
                   (just-one-space 0)
                   (backward-char 1)))))

  (defadvice kill-ring-save (before slick-copy activate compile)
    "When called interactively with no active region, copy a single line instead."
    (interactive (if mark-active (list (region-beginning) (region-end))
                   (message "Copied line")
                   (list (line-beginning-position)
                         (line-beginning-position 2)))))

  (defadvice kill-region (before slick-cut activate compile)
    "When called interactively with no active region, kill a single line instead."
    (interactive
     (if mark-active (list (region-beginning) (region-end))
       (list (line-beginning-position)
             (line-beginning-position 2)))))

  ;; Copy line from point to the end, exclude the line break
  (defun emacs-copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring"
    (interactive "p")
    (kill-ring-save (point)
                    (line-end-position))
    ;; (line-beginning-position (+ 1 arg)))
    (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

  (global-set-key (kbd "M-k") 'emacs-copy-line)
  ;; }}}

;; }}}
