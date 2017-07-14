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
		  (:src  "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js")
		  (:src "wwwroot/js/site.js"))
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


;; define the entry point
(defentry-point "modal.html" (:application *ucw-hello-world-app*)
    ()
  ;; display the window component
  (call-as-window 'main-window
		  :title "Bootstrap modal"
		  :body (make-instance 'bootstrap-modal)))

(defcomponent bootstrap-modal ()
  ())

(defmethod render ((component bootstrap-modal))
  (<:div :class "container"
	 (<:h3 "Bootstrap modal example")
	 (<:div :class "row"
		:style "margin-bottom:20px;"
		(<:a :href "/index.html"
		     "index"))
	 (<:button :class "btn btn-info btn-lg"
		   :data-toggle "modal"
		   :data-target "#myModal"
		   "Open")
	 
	 (<:div :class "row"
		:style "margin-top:10px;"
	  (<:button :class "btn btn-info btn-dm"
		    :onclick (ps (display-image))
		    "Display image"))	 
	 (<:div :class "row"
		:style "margin-top:20px;"
		(<:div :class "col-md-12"
		       :style "background-color:#006cbf;color:#000;"
		       (<:div :id "content-img"
			      :class "col-md-6 col-md-offset-3")))
	 (<:div :class "modal fade"
		:id "myModal"
		:role "dialog"
		(<:div :class "modal-dialog"
		       (<:div :class "modal-content"
			      (<:div :class "modal-header"
				     (<:button :type "button"
					       :class "close"
					       :data-dismiss "modal"
					       "x")
				     (<:h4 :class "modal-title" "Modal header"))
			      (<:div :class "modal-body"
				     (<:p "It works")
				     (<:img :src "wwwroot/img/lisp.png"
					    :style "width:100%"
					    :class "img-rounded"))
			      (<:div :class "modal-footer"
				     (<:button  :type "button"						
						:class "btn btn-default"
						:data-dismiss "modal"
						"close")))))))


(defentry-point "get-image" (:application *ucw-hello-world-app*)
    ()
  ;; display the window component
  (call 'display-image))

(defcomponent display-image ()
  ())

(defmethod render ((component display-image))
  (<:div :id "the-image"
   :style "width:100%;"
	 (<:img :src "wwwroot/img/lisp.png"
		:style "width:100%"
		:class "img-rounded")))
