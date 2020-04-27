;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.4-ufo-task-completed) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sample Problem
; Add a status line.
; It says “descending” when the UFO’s height is above one third of the height of the canvas.
; It switches to "closing in" below that. And finally, when the UFO has reached the bottom of the canvas,
; the status notifies the player that the UFO has “landed.”

(require 2htdp/universe)
(require 2htdp/image)

; Sample Problem Design a program that simulates the descent of a UFO.

; A WorldState can be one of three states:
; - between 0 and CLOSE
; interpretation: number of pixels between the top and the UFO

(define WIDTH 100) ; distances in terms of pixels 
(define HEIGHT 300)
(define CLOSE (/ HEIGHT 3))
(define BACK (empty-scene WIDTH HEIGHT))
(define UFO (overlay (ellipse 10 5 "solid" "green")
                     (ellipse 20 15 "solid" "black")))

; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick next]
     [to-draw render/status]))

; WorldState -> WorldState
; computes next location of UFO 
(check-expect (next 11) 14)
(define (next y)
  (+ y 3))

; WorldState -> Image
; places UFO at given height into the center of BACK
(check-expect (render 11) (place-image UFO 50 11 BACK))

(define (render y)
  (place-image UFO (/ WIDTH 2) y BACK))

; WorldState -> Image
; places 
(define (render/status y)
  (place-image
   (cond
     [(<= 0 y CLOSE)
      (text "descending" 11 "green")]
     [(and (< 0 CLOSE) (<= y HEIGHT))
      (text "closing in" 11 "orange")]
     [(> y HEIGHT)
      (text "landed" 11 "red")])
   20 y
   (render y)))

(main 0)