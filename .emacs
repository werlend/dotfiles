;; Define load-path
;;(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Set terminal color stuff
(load "term/xterm")
(defun terminal-init-screen ()
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

(package-initialize)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(require 'package)

;; Loop through packages and make sure they are installed and update
;;(when (not package-archive-contents)
;;  (package-refresh-contents))
(setq jpk-packages
  '(web-mode, less-css-mode, php-mode, crontab-mode, js-mode, jsx-mode, monokai-theme, zencoding-mode, flycheck, git-gutter))
(let ((refreshed nil))
  (when (not package-archive-contents)
    (package-refresh-contents)
    (setq refreshed t))
  (dolist (pkg jpk-packages)
    (when (and (not (package-installed-p pkg))
               (assoc pkg package-archive-contents))
      (unless refreshed
        (package-refresh-contents)
        (setq refreshed t))
      (package-install pkg))))

;; Theme
(load-theme 'monokai t)

;; Hides menu by default
(menu-bar-mode -1)

;; Key bindings
(global-set-key "\C-q"        'replace-string)
(global-set-key "\C-l"        'goto-line)
(global-set-key "\C-u"        'whitespace-cleanup)
(global-set-key "\M-c"        'comment-dwim)
(global-set-key [home]        'beginning-of-line)
(global-set-key [end]         'end-of-line)
(global-set-key [?\C-\d]      'backward-kill-word)
(global-set-key [C-delete]    'kill-word)

;; Git gutter
(global-git-gutter-mode +1)

;; Define auto save and backup file directories
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
; stop creating those #autosave# files
(setq auto-save-default nil)

;; Turn off tabs and set 4 spaces - default mode
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; Set XML indent to 4 spaces
(setq-default nxml-child-indent 4)
(setq-default nxml-attribute-indent 4)
(setq-default nxml-slash-auto-complete-flag t)
;; Set HTML indent to 4 spaces
(add-hook 'html-mode-hook (lambda () (set (make-local-variable 'sgml-basic-offset) 4)))
(add-hook 'sgml-mode-hook (lambda () (set (make-local-variable 'sgml-basic-offset) 2) (sgml-guess-indent)))

;; Init modes on specific file types
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.less?\\'" . less-css-mode))
(add-to-list 'auto-mode-alist '("crontab" . crontab-mode))
(unless (fboundp 'prog-mode) (defalias 'prog-mode 'fundamental-mode))

(setq web-mode-engines-alist
  '(("php" . "\\.phtml\\'")
    ("blade"  . "\\.blade\\.")
    ("smarty" . "\\.tpl\\."))
)

;; Set web-mode indent to 4 spaces
(defun web-mode-hook ()
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
)

(add-hook 'web-mode-hook  'web-mode-hook)

;; web-mode auto closing / auto pairing
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-pairing t)

;; Zencoding - Write html from css selectors
(require 'zencoding-mode)
(add-hook 'web-mode-hook 'zencoding-mode) ;; Auto-start on web mode

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(compilation-message-face (quote default))
 '(custom-safe-themes (quote ("3632cf223c62cb7da121be0ed641a2243f7ec0130178722554e613c9ab3131de" "f04122bbc305a202967fa1838e20ff741455307c2ae80a26035fbf5d637e325f" "c86f868347919095aa44d2a6129dd714cbcf8feaa88ba954f636295b14ceff8f" "0820d191ae80dcadc1802b3499f84c07a09803f2cb90b343678bdb03d225b26b" "cc60d17db31a53adf93ec6fad5a9cfff6e177664994a52346f81f62840fe8e23" "196cc00960232cfc7e74f4e95a94a5977cb16fd28ba7282195338f68c84058ec" default)))
 '(fci-rule-color "#49483E")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors (quote (("#49483E" . 0) ("#67930F" . 20) ("#349B8D" . 30) ("#21889B" . 50) ("#968B26" . 60) ("#A45E0A" . 70) ("#A41F99" . 85) ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#F92672") (40 . "#CF4F1F") (60 . "#C26C0F") (80 . "#E6DB74") (100 . "#AB8C00") (120 . "#A18F00") (140 . "#989200") (160 . "#8E9500") (180 . "#A6E22E") (200 . "#729A1E") (220 . "#609C3C") (240 . "#4E9D5B") (260 . "#3C9F79") (280 . "#A1EFE4") (300 . "#299BA6") (320 . "#2896B5") (340 . "#2790C3") (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )