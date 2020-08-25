;;;; ucw-hello-world.asd

(asdf:defsystem #:ucw-hello-world
  :description "Describe ucw-hello-world here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:ucw
	       #:ucw-core
	       #:parenscript)
  :serial t
  :components ((:file "package")
               (:file "ucw-hello-world")
	       (:file "examples-bootstrap-4.0.0")
	       (:file "material-examples")))

