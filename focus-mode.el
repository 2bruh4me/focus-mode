;; focus-mode --- Free from distractions
;;; Commentary:
;;; Code:

;; variables
(defvar focus-mode-previous-fringe-mode nil)
(defvar focus-mode-previous-line-numbers-mode nil)
(defvar focus-mode-previous-mode-line-format nil)

;; the mode itself
(define-minor-mode focus-mode
  "Tries to remove distractions by making Emacs go fullscreen and centering text etc."
  :lighter " Focus"
  (if focus-mode
      (progn
        ;; delete  other windows
        (delete-other-windows)
        ;; set fullscreen
        (setq focus-mode-previous-fringe-mode fringe-mode)
        (set-frame-parameter nil 'fullscreen 'fullboth)
        ;; center text with big fringe
        (set-fringe-mode
         (/ (- (frame-pixel-width)
               (* 120 (frame-char-width)))
            2))
        ;; turn off line numbers if they already are on
        (setq focus-mode-previous-line-numbers-mode display-line-numbers-mode)
        (display-line-numbers-mode -1)
        ;; hide modeline
        (setq focus-mode-previous-mode-line-format mode-line-format)
        (setq mode-line-format nil))
    (progn
      ;; exit fullscreen
      (set-frame-parameter nil 'fullscreen nil)
      ;; revert big fringe thingy
      (set-fringe-mode focus-mode-previous-fringe-mode)
      ;; revert line numbers change
      (display-line-numbers-mode focus-mode-previous-line-numbers-mode)
      ;; revert mode-line-format
      (setq mode-line-format focus-mode-previous-mode-line-format))))

(provide 'focus-mode)
;;; focus-mode ends here
