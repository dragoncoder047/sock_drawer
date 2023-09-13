(define (make-object . prototypes)
  (openlet (inlet
            'events (make-hook 'name 'payload)
            'fields (make-hash-table)
            'prototypes prototypes
            'let-ref-fallback (lambda (self name) (property self name))
            'let-set-fallback (lambda (self name value) (set! (property self name) value)))))

(define (attach-event obj name handler)
  (set! (hook-functions (obj 'events)) (cons
                                        (lambda (h)
                                          (when (eq? (h 'name) name) (handler (h 'payload))))
                                        (hook-functions (obj 'events)))))

(define (call-event obj name payload)
  ((obj 'events) name payload))

(define property
  (dilambda
   (lambda (obj name)
         (let ((res ((obj 'fields) name)))
           (unless res
             (set! res (call-with-exit (lambda (done)
                                         (for-each (lambda (proto)
                                                     (let ((val (property proto name)))
                                                       (when val (done val))))
                                                   (obj 'prototypes))
                                         #f))))
           (unless res (error 'no-such-property obj name))
           res))
   (lambda (obj name newval) (set! ((obj 'fields) name) newval))))


(define p (make-object))
(set! (p 'foo) 'boogaloo)
(set! (p 'classmethod) (lambda args (display 'classmethod->) (display args)))
(define x (make-object p))
(attach-event x 'foo (lambda (p) (display "foo event on x")))
(attach-event x 'bar (lambda (p) (display "bar event on x named ") (display (x 'name))))
(set! (x 'name) "bob")
(call-event x 'foo #f)
(newline)
(call-event x 'bar #f)
(newline)
(display "object prototype foo property = ")
(display (x 'foo))
(newline)
(display "calling method name = ")
(x 'classmethod 'arg1 'arg2)



