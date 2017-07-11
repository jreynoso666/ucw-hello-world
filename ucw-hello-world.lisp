;;;; ucw-hello-world.lisp

(in-package #:ucw-hello-world)

;;; "ucw-hello-world" goes here. Hacks and glory await!

;; define the server
(defvar *ucw-hello-world* (make-instance 'standard-server))

;; define the application
(defclass ucw-hello-world-app (standard-application
			       static-roots-application-mixin
			       cookie-session-application-mixin)
  ())
;; define wwwroot directory
(defvar *wwwroot*
  (merge-pathnames #P"wwwroot/"
		   (asdf:component-pathname (asdf:find-system :ucw-hello-world))))

;; create the object
(defvar *ucw-hello-world-app*
  (make-instance
   'ucw-hello-world-app
   :url-prefix "/"
   :debug-on-error t
   :static-roots (list (cons "wwwroot/"  *wwwroot*))))



;;; some basic functions

(defun start-app (&key (backend :httpd) (port 8080))
  "Start the server"
  (setf (server.backend *ucw-hello-world*)
	(make-backend backend :port port))
  
  (register-application *ucw-hello-world* *ucw-hello-world-app* )
  (startup-server *ucw-hello-world*))

(defun stop-app ()
  "Stop the server"
  (when (server.started *ucw-hello-world*)
    (shutdown-server *ucw-hello-world*)))



;; define the entry point
(defentry-point "index.html" (:application *ucw-hello-world-app*)
    ()
  ;; display the window component
  (call 'main-window))

;; define the window component
(defcomponent main-window (standard-window-component)
  ()
  (:default-initargs
      :title "UCW hello world"
    :meta '((:name "viewport" :content "width=device-width, initial-scale=1.0, user-scalable=no"))
    :javascript '((:src  "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js")
		  (:src  "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"))
    :stylesheet '("https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css")
    :body (make-instance 'index)))

(defcomponent index ()
  ())

(defmethod render ((component index))
  (<:div :class "container"
	 (<:div :class "row"
		(<:div :class "col-md-12"
		       :style "background-color:#2f3d63;color:#fff;"
		       (<:h2 :id "my-id"
			     :class "text-center"			     
			     "Hello world"))
		(<:div :class "row"
		       
		       (<:div :class "text-center "
			      
			      (<:button :type "button"
					:id "button"
				  :class "btn btn-primary"
				  :style "margin-top:10px;"
				  "Set good bye")))))
  
  (<:script :type "text/javascript"
	    "$('#button').click(function() {
   var item = $('#my-id');
   item.html('Good bye');
});"))
