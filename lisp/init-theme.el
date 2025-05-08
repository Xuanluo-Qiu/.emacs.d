;; 设置custom变更位置
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; 主题配色
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'macchiato) ;; 'frappe, 'latte, 'macchiato, or 'mocha
(catppuccin-reload)

;; 配置图标
(use-package all-the-icons
 :if (display-graphic-p))


(provide 'init-theme)
