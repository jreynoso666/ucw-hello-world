(in-package #:ucw-hello-world)

;; define the window component
(defcomponent bootstrap-5 (standard-window-component)
  ()
  (:default-initargs
   :title "UCW | Bootstrap 5"
   :meta '((:name "viewport" :content "width=device-width, initial-scale=1, shrink-to-fit=no"))
   :stylesheet '("https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css")
   :body (make-instance 'floating-labels)))

(defcomponent floating-labels ()
  ())

(defmethod render ((component floating-labels))
  (<:div :class "container pt-5"
	 (<:div :class "row"
		(<:div :class "col-12 col-lg-6"
		       (<:div :class "alert alert-primary mt-3 shadow"
			      (@ "role" "alert")
			      "Common lisp UCW  and Bootstrap 5.")))
	 (<:div :class "row"
		(<:div :class "col-12 col-lg-6"
		       (<:div :class "card shadow"
			      (<:div :class "card-header bg-primary text-white"
				     (<:h3 "Floating labels"))
			      (<:div :class "card-body"
				     (<:div :class "form-floating mb-3"
					    (<:input :class "form-control"
						     :id "floatingInput"
						     :type "email"
						     :placeholder "name@example.com")
					    (<:label :for "floatingInput"
						     "Email address"))
				     (<:div :class "form-floating mb-3"
					    (<:input :class "form-control"
						     :id "floatingPassword"
						     :type "email"
						     :placeholder "Password")
					    (<:label :for "floatingPassword"
						     "Password")))
			      (<:div :class "card-footer d-flex justify-content-between bg-white"
				     (<:button :class "btn btn-secondary"
					       "Cancel")
				     (<:button :class "btn btn-primary"
					       "Login")))))))

;; define the entry point
(defentry-point "bootstrap5/form/floating-labels" (:application *ucw-hello-world-app*)
    ()
  ;; display the window component
  (call 'bootstrap-5 :body (make-instance 'floating-labels)))
