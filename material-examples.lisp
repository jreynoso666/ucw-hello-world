(in-package #:ucw-hello-world)

;; define the entry point
(defentry-point "material/drawer" (:application *ucw-hello-world-app*)
    ()
  ;; display the window component
  (call 'material-example-window))

;; define the window component
(defcomponent material-example-window (standard-window-component)
  ()
  (:default-initargs
      :title "Material Components for the Web"
    :meta '((:name "viewport" :content "width=device-width, initial-scale=1, shrink-to-fit=no"))
    :javascript '((:src  "https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"))
    :stylesheet '("https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css"
		  "https://fonts.googleapis.com/icon?family=Material+Icons")
    :body (make-instance 'material-drawer)))

(defcomponent material-drawer ()
  ())

(defmethod render ((component material-drawer))
  (<:style "body {
  display: flex;
  height: 100vh;
}

.mdc-drawer-app-content {
  flex: auto;
  overflow: auto;
  position: relative;
}

.main-content {
  overflow: auto;
  height: 100%;
}

.app-bar {
  position: absolute;
}

// Only apply this style if below top app bar.
.mdc-top-app-bar {
  z-index: 7;
}")
  (<:aside :class "mdc-drawer mdc-drawer--dismissible"
	   (<:div :class "mdc-drawer__header"
		  (<:h3 :class "mdc-drawer__title"
			"UCW Lisp"))
	   (<:div :class "mdc-drawer__content"
		  (<:div :class "mdc-list"
			 (<:a :class "mdc-list-item mdc-list-item--activated"
			      :href "#"
			      (@ "aria-current" "page")
			      (<:span :class "mdc-list-item__ripple")
			      (<:i :class "material-icons mdc-list-item__graphic"
				   (@ "aria-hidden" "true")
				   "inbox")
			      (<:span :class "mdc-list-item__text"
				      "Inbox"))
			 (<:a :class "mdc-list-item"
			      :href "#"
			      (@ "aria-current" "send")
			      (<:span :class "mdc-list-item__ripple")
			      (<:i :class "material-icons mdc-list-item__graphic"
				   (@ "aria-hidden" "true")
				   "send")
			      (<:span :class "mdc-list-item__text"
				      "Outgoing"))
			 (<:a :class "mdc-list-item"
			      :href "#"
			      (@ "aria-current" "send")
			      (<:span :class "mdc-list-item__ripple")
			      (<:i :class "material-icons mdc-list-item__graphic"
				   (@ "aria-hidden" "true")
				   "drafts")
			      (<:span :class "mdc-list-item__text"
				      "Drafts")))))

  (<:div :class "mdc-drawer-app-content"
	 (<:header :class "mdc-top-app-bar app-bar"
		   :id "app-bar"
		   (<:div :class "mdc-top-app-bar__row"
			  (<:section :class "mdc-top-app-bar__section mdc-top-app-bar__section--align-start"
				     (<:button :class "material-icons mdc-top-app-bar__navigation-icon mdc-icon-button"
					       "menu")
				     (<:span :class "mdc-top-app-bar__title"
					     "Dismissible Drawer"))))

	 (<:main :class "main-content"
		 :id "main-content"
		 (<:div :class "mdc-top-app-bar--fixed-adjust"
			(<:p "Navigation drawers")
			(<:a :href "https://material-components.github.io/material-components-web-catalog/#/component/drawer"
			     :target "_blank"
			     "Drawer"))))
  (<:script :type "text/javascript"
	    (<:as-is
	     "const drawer = mdc.drawer.MDCDrawer.attachTo(document.querySelector('.mdc-drawer'));
              const topAppBar = mdc.topAppBar.MDCTopAppBar.attachTo(document.getElementById('app-bar'));
              topAppBar.setScrollTarget(document.getElementById('main-content'));
              topAppBar.listen('MDCTopAppBar:nav', () => {
                            drawer.open = !drawer.open;}); ")))


