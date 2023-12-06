(define (flatmap func list)
    (apply append (map func list)))

;; (define gensym
;;     (let ((counter -1))
;;         (lambda ()
;;             (set! counter (1+ counter))
;;             (string->symbol (string-append "l" (number->string counter 10))))))

(define (pat2insts e)
    (if (not (pair? e))
        `((match-value ,e))
        (let ((command (car e))
              (args (cdr e))
              (top (gensym "top"))
              (end (gensym "end")))
            (case command
                ((a an class)
                    `(match-type ,@args))
                ((space)
                    `((goto ,top ,end) ,top (match-type space) ,end))
                ((repeat many)
                    (let ((minrep (list-ref args 0))
                          (maxrep (list-ref args 1))
                          (tgtpair (if (list-ref args 2) (list top end) (list end top)))
                          (incode (compile (list-tail args 3)))
                          (result '()))
                        (let loop ((i minrep))
                            (when (< 0 i)
                                (set! result (append result incode))
                                (loop (1- i))))
                        (if (or (null? maxrep) (eqv? +inf.0 maxrep))
                            `(,@result (goto ,@tgtpair) ,top ,@incode (goto ,top) ,end)
                            (let ((counter (gensym "counter")))
                                `(,@result (setup-counter ,counter ,(- maxrep minrep)) (goto ,@tgtpair) ,top (decrement-counter ,counter ,end) ,@incode (goto ,top) ,end)))))
                ((alternate any)
                    (let ((in (list))
                          (places (list)))
                        (let loop ((c args))
                            (let ((here (gensym "option")))
                                (when (pair? c)
                                    (set! in `(,@in ,here ,@(compile (car c)) ,@(if (null? (cdr c)) '() `((goto ,end)))))
                                    (set! places (append places (list here)))
                                    (loop (cdr c)))))
                        `((goto ,@places) ,@in ,end)))
                (else
                    (error "bad pattern combinator" command))))))

(define (compile pattern)
    (if (pair? pattern)
        (flatmap pat2insts pattern)
        (pat2insts pattern)))

;; BUGGY

(display (compile '((alternate foo bar baz ((space)) ((many 10 12 #f aa bb))))))
