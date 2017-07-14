;;;; package.lisp

(defpackage #:ucw-hello-world
  ;;(:shadowing-import-from #:ucw-core #:parent)
  (:shadowing-import-from :ucw-standard :call)
  (:use #:cl
	#:ucw
	#:ucw-core
	#:parenscript))

