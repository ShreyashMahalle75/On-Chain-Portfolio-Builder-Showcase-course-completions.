

(define-constant err-invalid-amount (err u100))
(define-constant err-already-staked (err u101))
(define-constant err-not-staked (err u102))

;; Track staking data
(define-map stakers principal uint)

;; Track if user has completed a course
(define-map course-completions principal bool)

;; Stake tokens to mark course completion
(define-public (stake (amount uint))
  (begin
    (asserts! (> amount u0) err-invalid-amount)
    (asserts! (is-none (map-get? stakers tx-sender)) err-already-staked)
    (map-set stakers tx-sender amount)
    (map-set course-completions tx-sender true)
    (ok true)))

;; Check if a user completed the course
(define-read-only (has-completed-course (user principal))
  (ok (default-to false (map-get? course-completions user))))
