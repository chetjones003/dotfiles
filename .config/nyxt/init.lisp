(in-package :nyxt-user)

;; generalities: background, text colour, buttons and links
(define-configuration (internal-buffer prompt-buffer editor-buffer)
  ((style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
	 :background-color "#282a36"
	 :color "#abb2bf"
     :opacity "0.9")
	(hr
	 :color "#56b6c2")
	(|a:link|
	 :color "#98c379")
	(\.button
	 :color "#c678dd"
	 :background-color "#282a36")))))))

;; message area
(define-configuration window
  ((message-buffer-style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
         :background-color "#282a36"
         :color "#abb2bf")))))))

;; prompt
;; Q do we want to see modes here? (I think not)
(define-configuration prompt-buffer
  ((style (str:concat
	   %slot-default%
	   (cl-css:css
	    '((body
	       :background-color "#282a36"
	       :color "#abb2bf")
	      ("#prompt-area"
	       :background-color "#212121")
	      ("#input"
	       :background-color "#404040"
	       :color "#abb2bf")
	      (".source-name"
	       :color "#56b6c2"
	       :background-color "#282a36")
	      (".source-content"
	       :background-color "#212121"
	       :width "95%"
	       :border-spacing "4px 1px")
	      (".source-content th"
	       :border "1px solid #bdbdb3"
	       :background-color "#212121"
	       :font-weight "bold")
	      (".source-content td"
	       :text-overflow "ellipsis")
	      ("#selection"
	       :background-color "#212121"
	       :color "#00C0FF")
	      (\.marked
	       :background-color "#212121"
	       :font-weight "bold"
	       :color "#C000FF")
	      (\.selected :background-color "#212121"
			  :color "#4184e4")))))))

;; status bar: adapted from https://gitlab.com/ambrevar/dotfiles/-/blob/master/.config/nyxt/init.lisp
(defun my-status-style ()
  (cl-css:css
   '((body
      :background "#282a36"
      :font-size "14px"
      :color "#bdbdb3"
      :padding 0
      :margin 0
      :line-height "20px")
     (".arrow"
      :width "10px"
      :height "20px")
     (".arrow-right"
      :clip-path "polygon(0 100%, 100% 50%, 0 0)")
     (".arrow-left"
      :clip-path "polygon(0 50%, 100% 100%, 100% 0)")
     ("#container"
      :display "grid"
      ;; Columns: controls, arrow, url, arrow, modes
      :grid-template-columns "50px 10px auto 10px 20px"
      :overflow-y "hidden")
     ("#controls"
      :background-color "#282a36"
      :padding-left "5px"
      :overflow "hidden"
      :white-space "nowrap")
     ("#url, #url a.button"
      :background-color "#282a36"
      :color "#abb2bf"
      :min-width "100px"
      :text-overflow "ellipsis"
      :overflow-x "hidden"
      :white-space "nowrap"
      :padding-left "15px"
      :padding-right "10px"
      :margin-left "-10px")
     ("#url a.button:hover"
      :color "#ffff80")
     ("#modes"
      :background-color "#282a36"
      :color "#56b6c2"
      :text-align "right"
      :padding-right "5px"
      :text-overflow "ellipsis"
      :overflow-x "hidden"
      :white-space "nowrap")
     (".button, .has-history"
      :text-decoration "none"
      :padding-left "2px"
      :padding-right "2px"
      :margin-left "2px"
      :margin-right "2px")
     (|\.button:hover|
      :color "white")
     (".button"
      :color "#98c379")
     (.has-history
      :color "#61afef")
     (|\.has-history:hover|
      :color "#c678dd"))))


;; special case: branch markers on the history tree
(define-configuration nyxt/history-tree-mode::history-tree-mode
  ((style
    (str:concat
     %slot-default%
     (cl-css:css
      '(("ul li::before"
	 :background-color "#286a36")
	("ul li::after"
	 :background-color "#286a36")
	("ul li:only-child::before"
	 :background-color "#286a36")))))))

;; out-lier: style lisp-mode

;; visual indication of whether there is any history
;;
;; detect history (based on https://discourse.atlas.engineer/t/q-how-to-find-out-if-buffer-has-history/108)
(defun forward-history-p (&optional (buffer (current-buffer)))
  (with-data-unsafe (history (history-path buffer))
    ;; the following errors out on a new buffer or window
    (ignore-errors (htree:children (htree:current-owner-node history)))))

(defun backward-history-p (&optional (buffer (current-buffer)))
  (with-data-unsafe (history (history-path buffer))
    ;; the following errors out on a new buffer or window
    (ignore-errors (htree:all-parents history))))

;; we could do more here.  Example: change the forwards command
;; if the history branches here.
(defun my-format-status-buttons ()
  (markup:markup
   (:a :class (if (backward-history-p) "has-history" "button")
       :title "Backwards" :href (lisp-url '(nyxt/web-mode:history-backwards)) "❮")
   (:a :class (if (forward-history-p) "has-history" "button")
       :title "Forwards" :href (lisp-url '(nyxt/web-mode:history-forwards)) "❯")))

;; truncate url; copy url on click and see full url on hover
(defun my-format-status-url (buffer)
  (let ((url (render-url (url buffer))))
    (markup:markup
     (:a :class "button"
	 :title url
	 :href (lisp-url '(nyxt:copy-url))
	 (if (str:emptyp url)
	     (title buffer)
	     (format nil " ~a — ~a"
		     (str:prune 50 url :ellipsis "…")
		     (title buffer)))))))

(defun my-format-status (window)
  (let ((buffer (current-buffer window)))
    (setf (style (status-buffer window)) (my-status-style))
    (markup:markup
     (:div :id "container"
           (:div :id "controls"
                 (markup:raw (my-format-status-buttons)))
           (:div :class "arrow arrow-right"
                 :style "background-color:rgb(21,21,21);background-color:rgb(49,49,49)"  "")
           (:div :id "url"
                 (markup:raw
                  (format-status-load-status buffer)
                  (my-format-status-url buffer)))
           (:div :class "arrow arrow-left"
                 :style "background-color:rgb(21,21,21);background-color:rgb(49,49,49)" "")
           (:div :id "modes"
		 :title (format-status-modes buffer window)
		 "--")))))
;; TODO
;; better format status url (truncate the url)?


(define-configuration window
  ((status-formatter #'my-format-status)))
