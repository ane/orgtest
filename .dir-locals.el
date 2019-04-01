((nil . ((eval . (setq-local
                  blog-root
                  (if buffer-file-name
                      (file-name-directory
                       (car (dir-locals-find-file (buffer-file-name))))
                    default-directory)))
         (eval . (local-set-key
                  (kbd "<f3>")
                  (lambda ()
                    (interactive)
                    (save-excursion
                      (org-babel-load-file (expand-file-name "config.org" blog-root))
                      (org-publish-project "blog"))))))))
