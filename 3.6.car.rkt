;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.6.car) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD 40)
 
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

; wheel
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

; space between the wheels
(define SPACE
  (rectangle 10 10 "solid" "white"))

; both wheels
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

; body part: up and down
(define BODY
  (underlay/offset (rectangle 40 10 "solid" "red") 5 -5 (rectangle 10 10 "solid" "red")))

; whole car with wheels and body
(define CAR
  (underlay/offset BODY 0 10 BOTH-WHEELS))

(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

; State -> Image
; places the image of the car "x" pixels from 
; the left margin of the BACKGROUND image
(define (render-handler x)
  (place-image CAR x 30 BACKGROUND))
 
; State -> State
; adds 3 to x to move the car right
; examples:
;   given: 20, expect 23
;   given: 78, expect 81

(check-expect (tick-handler 3) 6)

(define (tick-handler x)
  (+ x 3))

; State -> Boolean
; decide whether program should end or not
(define (end-handler x)
  (cond
    [(> (+ WIDTH-OF-WORLD (/ (image-width CAR) 2)) x) false]
    [else true]))

; State -> State
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tick-handler]
     [to-draw render-handler]
     [stop-when end-handler]))

(main 13)