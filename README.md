* Get the code

First change to quicklisp directory

cd  ~/quicklisp/local-projects

Clone the repo:

git clone https://github.com/juan-reynoso/ucw-hello-world.git

* Load with Quicklisp:

(ql:quickload "ucw-hello-world")

(in-package :ucw-hello-world)

(start-app)

* Bootstrap examples

You can open the URL in order to see the examples.


http://localhost:8080/examples/pricing

http://localhost:8080/components/toasts

http://localhost:8080/bootstrap5/form/floating-labels


* Websockets example

http://localhost:8080/portal-websockets


* Material design example

You can open the URL in order to see the example.

http://localhost:8080/material/drawer

* UCW Backends

UCW can be made to work with any backend, including iolib, mod_lisp, or its own internal HTTPD. 
* Backend mod_lisp on Debian GNU/Linux

In order to install mode_lisp you need to run:
aptitude install libapache2-mod-lisp 

* Enable module

a2enmod lisp

* Configuring Apache with mod_lisp

add the following lines in /etc/apache2.conf  file:


LispServer 127.0.0.1 8080 "ucw"
SetHandler lisp-handler

* Restart apache server

/etc/init.d/apache2 restart

or

systemctl restart apache2

* Start the app with mod-lisp backend

(ql:quickload "ucw-hello-world")

(in-package :ucw-hello-world)

(start-app :backend :mod-lisp)


* Bootstrap examples

You can open the URL in order to see the examples.


http://localhost/examples/pricing

http://localhost/components/toasts

http://localhost/bootstrap5/form/floating-labels


* Material design example

You can open the URL in order to see the example.

http://localhost/material/drawer
