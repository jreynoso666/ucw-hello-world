(in-package #:ucw-hello-world)


;; define the entry point
(defentry-point "bootstrap/examples/pricing" (:application *ucw-hello-world-app*)
    ()
  ;; display the window component
  (call 'bootstrap-4))

;; define the window component
(defcomponent bootstrap-4 (standard-window-component)
  ()
  (:default-initargs
      :title "UCW hello world"
    :meta '((:name "viewport" :content "width=device-width, initial-scale=1, shrink-to-fit=no"))
    :javascript '((:src  "https://code.jquery.com/jquery-3.3.1.min.js")
		  (:src  "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js")
		  (:src "wwwroot/js/site.js"))
    :stylesheet '("https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css")
    :body (make-instance 'pricing)))

(defcomponent pricing ()
  ())

(defmethod render ((component pricing))
  
  (<:div :class "container"
	 
	 (<:h4 :class "text-white text-center mb-2 py-2"
		      :style "background-color:#2595ff; height:50px;"
		      "Bootstrap 4 Examples")
	 (<:div :class "row"
		(<:div :class "col-12 col-sm-6 col-md-6 col-lg-4 col-xl-4"
		       (<:div :class "card text-center mb-4"
			      (<:div :class "card-header"
				     (<:h4 :class "font-weight-normal"
					   "Free"))
			      (<:div :class "card-body"
				     (<:h1 :class "card-title"
					   "0"
					   (<:small :class "text-muted"
						    "/mo"))
				     (<:ul :class "list-unstyled mt-3 mb-4"
					   (<:li "10 users included")
					   (<:li "2 GB of storage")
					   (<:li "Email support")
					   (<:li "Help center access"))
				     (<:button :type "button"
					       :class "btn btn-lg btn-block btn-outline-primary"
					       "Sign up for free"
					       ))))

		(<:div :class "col-12 col-sm-6 col-md-6 col-lg-4 col-xl-4"
		       (<:div :class "card text-center mb-4"
			      (<:div :class "card-header"
				     (<:h4 :class "font-weight-normal"
					   "Pro"))
			      (<:div :class "card-body"
				     (<:h1 :class "card-title"
					   "15"
					   (<:small :class "text-muted"
						    "/mo"))
				     (<:ul :class "list-unstyled mt-3 mb-4"
					   (<:li "20 users included")
					   (<:li "10 GB of storage")
					   (<:li "Email support")
					   (<:li "Help center access"))
				     (<:button :type "button"
					       :class "btn btn-lg btn-block btn-primary"
					       "Get started"
					       ))))
		(<:div :class "col-12 col-sm-6 col-md-6 col-lg-4 col-xl-4"
		       (<:div :class "card text-center mb-4"
			      (<:div :class "card-header"
				     (<:h4 :class "font-weight-normal"
					   "Enterprise"))
			      (<:div :class "card-body"
				     (<:h1 :class "card-title"
					   "29"
					   (<:small :class "text-muted"
						    "/mo"))
				     (<:ul :class "list-unstyled mt-3 mb-4"
					   (<:li "30 users included")
					   (<:li "15 GB of storage")
					   (<:li "Email support")
					   (<:li "Help center access"))
				     (<:button :type "button"
					       :class "btn btn-lg btn-block btn-success"
					       "Get started"
					       )))))))
