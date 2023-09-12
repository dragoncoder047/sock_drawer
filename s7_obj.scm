(define (make-object . prototypes)
  (let ((obj (inlet 'events (make-hook 'name 'payload) 'fields (make-hash-table) 'prototypes prototypes)))
    (openlet obj)
    obj))

(define (attach-event obj name handler)
  (set! (hook-functions (obj 'events)) (cons
                                        (lambda (h)
                                          (when (eq? (h 'name) name) (handler (h 'payload))))
                                        (hook-functions (obj 'events)))))
(define (call-event obj name payload)
  ((obj 'events) name payload))

(define property
  (dilambda
   (lambda (obj name . params)
         (let ((res ((obj 'fields) name)))
           (unless res
             (set! res (call-with-exit (lambda (done)
                                         (for-each (lambda (proto)
                                                     (let ((val (property proto name)))
                                                       (when val (done val)))) (obj 'prototypes))
                                         #f))))
           (unless res (error 'no-such-property obj name))
           (if (null? params)
               res
               (apply res (append (list obj) params)))))
   (lambda (obj name newval) (hash-table-set! (obj 'fields) name newval))))


(define p (make-object))
(set! (property p 'foo) 'boogaloo)
(set! (property p 'classmethod) (lambda (self _) (display (property self 'name))))
(define x (make-object p))
(attach-event x 'foo (lambda (p) (display "foo event on x")))
(attach-event x 'bar (lambda (p) (display "bar event on x named ") (display (property x 'name))))
(set! (property x 'name) "bob")
(call-event x 'foo #f)
(newline)
(call-event x 'bar #f)
(newline)
(display "object prototype foo property = ")
(display (property x 'foo))
(newline)
(display "calling method name = ")
(property x 'classmethod '_)











