(define (make-object)
  (openlet (inlet 'events (make-hook 'name 'payload))))

(define (attach-event obj name handler)
  (set! (hook-functions (obj 'events)) (cons
                                        (lambda (h)
                                          (when (eq? (h 'name) name) (handler (h 'payload))))
                                        (hook-functions (obj 'events)))))
(define (call-event obj name payload)
  ((obj 'events) name payload))



(define x (make-object))
(attach-event x 'foo (lambda (p) (display "foo event on x")))
(attach-event x 'bar (lambda (p) (display "bar event on x named") (display (x 'name))))
(set! (x 'name) "foo")
(call-event x 'bar #f)











