;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.3.51-) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

(define WIDTH 200)
(define HEIGHT 200)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

; Number -> Number
; takes a number and divides by two
(define (place-to-center x)
  (/ x 2))

; State -> Image
; places the image of the TrafficLight circle
; to the BACKGROUND
(define (render-handler color)
  (place-image
   (circle 40 "solid" color)
   (place-to-center WIDTH)
   (place-to-center HEIGHT)
   BACKGROUND))


; TrafficLight -> TrafficLight
; yields the next state given current state "color"
(check-expect (traffic-light-next "red") "green")

(define (traffic-light-next color)
  (cond
    [(string=? "red" color) "green"]
    [(string=? "green" color) "yellow"]
    [(string=? "yellow" color) "red"]))

(define (main ws)
   (big-bang ws
     [on-tick traffic-light-next]
     [to-draw render-handler]))


(main "red")