;;;; ucw-hello-world.lisp

(in-package #:ucw-hello-world)

;;; "ucw-hello-world" goes here. Hacks and glory await!

;; define the server
(defvar *ucw-hello-world* (make-instance 'standard-server))

;; define the application
(defclass ucw-hello-world-app (static-roots-application-mixin
			       standard-application
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
  (if (server.started *ucw-hello-world* )
      (error "Server already started")
      (setf (server.backend *ucw-hello-world*)
	    (make-backend backend :port port)))
  (register-application *ucw-hello-world* *ucw-hello-world-app* )
  (startup-server *ucw-hello-world*))

(defun stop-app ()
  "Stop the server"
  (when (server.started *ucw-hello-world*)
    (shutdown-server *ucw-hello-world*)))

(defun restart-huuii-server ()
  "Restart the server"
  (stop-app)
  (start-app))

;; define the entry point
(defentry-point "hello-world.ucw" (:application *ucw-hello-world-app*)
    ()
  ;; displya the window component
  (call 'main-window))


;; define the window component
(defcomponent main-window (standard-window-component)
  ()
  (:default-initargs
   :title "Hello world"
    :body (make-instance 'say-hello)) 
  (:documentation "Window component"))

;; define the component
(defcomponent say-hello ()
  ())

(defmethod render ((component say-hello))
  (<:p "Hello World"))
