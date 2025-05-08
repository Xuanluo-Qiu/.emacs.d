;; ivy
(use-package counsel
 :ensure t)

;; 必备
(use-package hydra
 :ensure t)

(use-package use-package-hydra
 :ensure t
 :after hydra)

(use-package ivy
 :ensure t
 :init
 (ivy-mode 1)
 (counsel-mode 1)
 :config
 (setq ivy-use-virtual-buffers t)
 (setq search-default-mode #'char-fold-to-regexp)
 (setq ivy-count-format "(%d/%d) ")
 :bind
 (("C-s" . 'swiper)
  ("C-x b" . 'ivy-switch-buffer)
  ("C-c v" . 'ivy-push-view)
  ("C-c s" . 'ivy-switch-view)
  ("C-c V" . 'ivy-pop-view)
  ("C-x C-@" . 'counsel-mark-ring); 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
  ("C-x C-SPC" . 'counsel-mark-ring)
  :map minibuffer-local-map
  ("C-r" . counsel-minibuffer-history)))

;; ace-window
;; 多窗口优化
(use-package ace-window
 :ensure t
 :bind (("C-x o" . 'ace-window)))

;; 平滑滚动
(use-package good-scroll
 :ensure t
 :if window-system     ; 在图形化界面时才使用这个插件
 :init (good-scroll-mode))

;; avy
(use-package avy
 :ensure t
 )

;; 一个为 Emacs minibuffer 中的选项添加注解的插件。
(use-package marginalia
 :ensure t
 :init (marginalia-mode)
 :bind (:map minibuffer-local-map
	     ("M-A" . marginalia-cycle)))

;; 多光标
(use-package multiple-cursors
 :ensure t
 :after hydra
 :bind
 (("C-x C-h m" . hydra-multiple-cursors/body)
  ("C-S-<mouse-1>" . mc/toggle-cursor-on-click))
 :hydra
 (hydra-multiple-cursors
  (:hint nil)
  "
Up^^       Down^^      Miscellaneous      % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]  Prev   [_n_]  Next   [_l_] Edit lines [_0_] Insert numbers
 [_P_]  Skip   [_N_]  Skip   [_a_] Mark all  [_A_] Insert letters
 [_M-p_] Unmark  [_M-n_] Unmark  [_s_] Search   [_q_] Quit
 [_|_] Align with input CHAR    [Click] Cursor at point"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("|" mc/vertical-align)
  ("s" mc/mark-all-in-region-regexp :exit t)
  ("0" mc/insert-numbers :exit t)
  ("A" mc/insert-letters :exit t)
  ("<mouse-1>" mc/add-cursor-on-click)
  ;; Help with click recognition in this hydra
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore)
  ("q" nil)))

;; 这个插件可以高亮出当前 Buffer 中所有的、与光标所在处的符号相同的符号。
(use-package highlight-symbol
 :ensure t
 :init (highlight-symbol-mode)
 :bind ("<f3>" . highlight-symbol)) ;; 按下 F3 键就可高亮当前符号

;; 这个插件可以用不同颜色标记多级括号，方便看清代码块（尤其在 EmacsLisp 中）。
(use-package rainbow-delimiters
 :ensure t
 :hook (prog-mode . rainbow-delimiters-mode))

;; 没有会死
(use-package evil
 :ensure t
 :init (evil-mode))

;; 欢迎界面
(use-package dashboard
 :ensure t
 :config
 (setq dashboard-banner-logo-title "Welcome to Emacs!") ;; 个性签名，随读者喜好设置
 ;; (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
 (setq dashboard-startup-banner 'official) ;; 也可以自定义图片
 (setq dashboard-items '((recents . 5)  ;; 显示多少个最近文件
  (bookmarks . 5) ;; 显示多少个最近书签
  (projects . 10))) ;; 显示多少个最近项目
 (dashboard-setup-startup-hook))

(provide 'init-tool)
