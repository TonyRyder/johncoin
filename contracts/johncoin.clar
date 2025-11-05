(define-fungible-token johncoin)

;; Basic metadata
(define-constant NAME "JohnCoin")
(define-constant SYMBOL "JOHN")
(define-constant DECIMALS u6)               ;; 6 decimal places
(define-constant TOTAL_SUPPLY u1000000000000) ;; 1,000,000 JOHN in base units (10^6)

;; One-time initializer to mint the fixed supply to a specified recipient
(define-data-var initialized bool false)

(define-public (initialize (recipient principal))
  (if (var-get initialized)
      (err u100)                                   ;; already initialized
      (begin
        (try! (ft-mint? johncoin TOTAL_SUPPLY recipient))
        (var-set initialized true)
        (ok true))))

;; SIP-010-like surface (not claiming trait conformance here)
(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (ft-transfer? johncoin amount sender recipient))

(define-read-only (get-name)
  (ok NAME))

(define-read-only (get-symbol)
  (ok SYMBOL))

(define-read-only (get-decimals)
  (ok DECIMALS))

(define-read-only (get-total-supply)
  (ok (ft-get-supply johncoin)))

(define-read-only (get-balance (who principal))
  (ok (ft-get-balance johncoin who)))
