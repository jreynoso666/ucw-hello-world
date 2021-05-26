(in-package #:ucw-hello-world)

(defvar *connections* (make-hash-table))

(defun handle-new-connection (con)
  (setf (gethash con *connections*)
        (format nil "user-id-~a" (random 100))))

(defun broadcast-to-room(message)
  (loop :for con :being :the :hash-key :of *connections* :do
          (pws:send con message)))

(defun handle-close-connection (connection)
  (let ((message (format nil " .... ~a has left."
                         (gethash connection *connections*))))
    (remhash connection *connections*)
    (loop :for con :being :the :hash-key :of *connections* :do
      (pws:send con message))))

;; Portal
(pws:define-resource "/echo" 
  :open (lambda (websocket)
	  (handle-new-connection websocket)
          (pws:send websocket "Welcome to echo server."))
  :message (lambda (websocket message)
	     ;; display the message form client
	     (format t "~% Message from client: [ ~a ] ~%" message))
  :close (lambda (websocket)
	   (handle-close-connection websocket)))

;; start server
(defparameter server 
  (pws:server 9191  t))

;;; UnCommonWeb
;; define the window component
(defcomponent portal-websockets (standard-window-component)
  ()
  (:default-initargs
   :title "Portable websockets for Common Lisp using usocket"
   :meta '((:name "viewport" :content "width=device-width, initial-scale=1, shrink-to-fit=no"))
   :stylesheet '("https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css")
   :body (make-instance 'websockets-test)))

(defcomponent websockets-test ()
  ())

(defmethod render ((component websockets-test))
  (<:script :type "text/javascript"
	    " function WebSocketTest() {
            if ('WebSocket' in window) {
               // Let us open a web socket
               var ws = new WebSocket('ws://localhost:9191/echo');
               ws.onopen = function() {
         // Web Socket is connected, send data using send()
	 ws.send('Hello world!');
               alert('Send a message');
                 
               };
               ws.onmessage = function (evt) { 
         var received_msg = evt.data;
	          alert('Message from server: ' + received_msg);
	 var node = document.createTextNode('[ ' + received_msg + ' ]');
	 document.getElementById('messages').appendChild(node);

               };
               ws.onclose = function() { 
                  // websocket is closed.
                  alert('Connection is closed...'); 
               };
            } else {
               // The browser doesn't support WebSocket
               alert('WebSocket NOT supported by your Browser!');
            }
         }"
	    )
  (<:div :class "container pt-5"
	 (<:div :class "row"
		(<:div :class "col-12 col-lg-8"
		       (<:div :class "alert alert-primary mt-3 shadow"
			      (@ "role" "alert")
			      "Portable websockets for Common Lisp using usocket.")))
	 (<:div :class "row"
		(<:div :class "col-12 col-lg-8"
		       (<:div :class "card"
			      
			      (<:img :class "card-img-top"
				     :src "/wwwroot/img/lisp.png")
			      (<:div :class "card-body"
				     (<:a :href "https://github.com/charJe/portal"
					  "https://github.com/charJe/portal")
				     (<:div :id "messages"
					    :class "py-3"))
			      (<:div :class "card-footer d-flex justify-content-end bg-white"
				     (<:button :class "btn btn-primary"
					       :onclick (ps-html "WebSocketTest();")
					       "Test websockets")))))))

;; define the entry point
(defentry-point "portal-websockets" (:application *ucw-hello-world-app*)
    ()
  ;; display the window component
  (call 'bootstrap-5 :body (make-instance 'portal-websockets)))
