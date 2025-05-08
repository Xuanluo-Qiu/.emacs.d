;; 编辑器基本配置
(let ((minver "25.1"))
 (when (version< emacs-version minver)
  (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "26.1")
 (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ; 设定源码加载路径
;; (require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;; 修改垃圾回收的内存上限来提高 Emacs 启动速度
(let ((normal-gc-cons-threshold (* 20 1024 1024))
   (init-gc-cons-threshold (* 128 1024 1024)))
 (setq gc-cons-threshold init-gc-cons-threshold)
 (add-hook 'emacs-startup-hook
	   (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(setq confirm-kill-emacs #'yes-or-no-p)   ; 在关闭 Emacs 前询问是否确认关闭，防止误触
(electric-pair-mode t)            ; 自动补全括号
(add-hook 'prog-mode-hook #'show-paren-mode) ; 编程模式下，光标在括号上时高亮另一个括号
(column-number-mode t)            ; 在 Mode line 上显示列号
(global-auto-revert-mode t)         ; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(delete-selection-mode t)          ; 选中文本后输入文本会替换文本（更符合我们习惯了的其它编辑器的逻辑）
(setq inhibit-startup-message t)       ; 关闭启动 Emacs 时的欢迎界面
(setq make-backup-files nil)         ; 关闭文件自动备份
(add-hook 'prog-mode-hook #'hs-minor-mode)  ; 编程模式下，可以折叠代码块
(global-display-line-numbers-mode 1)     ; 在 Window 显示行号
(tool-bar-mode -1)              ; 关闭 Tool bar
(when (display-graphic-p) (toggle-scroll-bar -1)) ; 图形界面时关闭滚动条

(savehist-mode 1)              ; 打开 Buffer 历史记录保存
(setq display-line-numbers-type 'relative)  ; 显示相对行号
(add-to-list 'default-frame-alist '(width . 100)) ; 设定启动图形界面时的初始 Frame 宽度（字符数）
(add-to-list 'default-frame-alist '(height . 800)) ; 设定启动图形界面时的初始 Frame 高度（字符数）

;; 字体大小
(set-frame-font "RecMonoCasual Nerd Font 15" nil t)

;; 配置MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; 首先加载use-package的插件
(eval-when-compile
  (require 'use-package))

;; 导入外观配置
(require 'init-theme)
;; 导入工具配置
(require 'init-tool)

(provide 'init)
;;; End init
