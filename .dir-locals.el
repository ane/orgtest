((nil . ((eval . (setq-local
                  blog-root
                  (if buffer-file-name
                      (file-name-directory
                       (car (dir-locals-find-file (buffer-file-name))))
                    default-directory)))
         (eval . (local-set-key
                  (kbd "<f3>")
                  (lambda (arg)
                    (interactive "P")
                    (when arg
                      (org-babel-load-file (expand-file-name "config.org" blog-root))
                      (org-publish-remove-all-timestamps))
                    (let ((start-time (current-time)))
                      (save-excursion
                        (org-publish-project "blog"))
                      (let ((end-time (time-subtract (current-time) start-time)))
                        (message "Blog published in %.2f seconds." (float-time end-time))))))))))
