(defconst emacs-start-time (current-time))

(require 'package)

;;
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; for latest org-mode and org-plus-contrib
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

;; https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el#L64
;; (setq package-enable-at-startup nil)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; install packages automatically if not already present on your
;; system to be global for all packages
(require 'use-package-ensure)

(setq use-package-always-ensure t)

(use-package org
  :ensure org-plus-contrib
  :config
  (use-package htmlize)
  (require 'org-tempo)
  (require 'ox-rss)
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((plantuml . t)
                                 (ditaa . t)
                                 (dot . t)
                                 (shell . t)
                                 (python . t)
                                 (R . t)))

  (setq org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
        org-confirm-babel-evaluate nil
        org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar"))

(use-package dash)

(use-package s)

(setq-local blog-root (if buffer-file-name
                          (file-name-directory
                           (car (dir-locals-find-file (buffer-file-name))))
                        default-directory))

(org-babel-load-file "config.org")

(org-publish-project "blog")

(provide 'foo)
;;; foo.el ends here
