(progn

(defvar *p1* 14)
(defvar *p2* 32)
(pinmode *p1* :output)
(pinmode *p2* :output)
(defvar *phasetab* '(#b01 #b11 #b10 #b00))
(defvar *phase* 0)
(defun step (dir)
    (setq *phase* (mod (+ (length *phasetab*) dir *phase*) (length *phasetab*)))
    (digitalwrite *p1* (logbitp 0 (nth *phase* *phasetab*)))
    (digitalwrite *p2* (logbitp 1 (nth *phase* *phasetab*))))

(defvar *asteps* 20)

(defun move (a)
    (let ((dir (if (plusp a) 1 -1)))
        (setq a (abs a))
        (dotimes (_ a)
            (step dir)
            (delay 1))))
                

(defun run ()
    (loop
        (move 350)
        (move -350)))

nil
)
