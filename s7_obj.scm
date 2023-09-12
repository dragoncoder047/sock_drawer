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
   (lambda (obj path . params)
     (if (pair? path)
         (for-each (lambda (pth)
                     (set! obj (or ((obj 'fields) pth)
                                   ((lambda ()
                                      (call-with-exit
                                       (lambda (found) (error 'todo))))))))
         (obj path)))
   (lambda (obj path newval) (error 'todo))))


(define x (make-object))
(attach-event x 'foo (lambda (p) (display "foo event on x")))
(attach-event x 'bar (lambda (p) (display "bar event on x named") (display (x 'name))))
(set! (property x 'name) "foo")
(call-event x 'bar #f)











