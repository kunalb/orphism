(import collections.abc [Sequence])
(import enum [Enum])


(defclass BucketList [Sequence]

  (defn __init__ [self
                  bucket-count
                  [vals None]
                  [vals-range None]
                  [scale None]]
    (setv
      self.-bucket-count bucket-count
      self.-vals vals
      self.-vals-range vals-range
      self.-scale scale

      self.-bucket-size 0
      self.-min-val (min self.-vals)
      self.-max-val (max self.-vals)
      self.-bucket-range (or self.-vals-range)
      self.-buckets (* [0] (len self.-vals))))

  (defn add-vals [self vals]
    (self.-vals.extend vals))

  (defn add-val [self val]
    (self.-vals.append val))

  (defn set-range [self val-range]
    (setv self.-val-range val-range))

  (defn get-range [self]
    ...)

  (defn set-vals [self vals]
    (setv self.-vals vals))

  (defn buckets [self]
    (when self.-bucketed
      (return self.-bucketed-vals))
    [])

  (defn -make-buckets [self]
    )

  (defn __getitem__ [self key]
    (get self.-bucketed-vals key))

  (defn __len__ [self]
    (len self.-bucketed-vals)))
