(import collections.abc [MutableSequence])
(import enum [Enum])
(import math)


(defclass BucketList [MutableSequence]
  "Automatically maintains buckets for data.
   Maintains symmetry around 0."

  (defn __init__ [self
                  bucket-count
                  [iterable None]
                  [range-max None]]
    "Bucket count is just the number of distinct positive buckets"
    (setv
      self.-bucket-count bucket-count
      self.-vals []
      self.-range-max range-max
      self.-bucketed []

      self.-cached-max None
      self.-cached-bucket-size None)

    (when iterable
      (self.extend iterable)))

  (defn [property] range-max [self]
    self.-range-max)

  (defn [range-max.setter] set-range-max [self range-max]
    (setv self.-range-max range-max))

  (defn [property] vals [self]
    self.-vals)

  (defn [property] bucket-size [self]
    self.-cached-bucket-size)

  ;; Abstract methods

  (defn __getitem__ [self key]
    (get self.-bucketed key))

  (defn __len__ [self]
    (len self.-bucketed))

  (defn __setitem__ [self key val]
    (self.-del-value (get self.-bucketed key))
    (self.-add-value val)

    (setv (get self.-vals key) val))

  (defn __delitem__ [self key]
    (self.-del-value (get self.-bucketed key))
    (del (get self.-bucketed key))
    (del (get self.-vals key)))

  (defn insert [self key val]
    (self.-add-value val)
    (self.-vals.insert key val)
    (self.-bucketed.insert key (self.-bucket val)))

  ;; Implementation

  (defn -add-value [self val]
    (setv original-max self.-cached-max)

    (when (and (not self.-cached-max) self.-vals)
      (setv self.-cached-max (max (map abs self.-vals))))

    (setv self.-cached-max
          (cond
            (not self.-vals) (abs val)
            self.-vals (max self.-cached-max (abs val))))
    (setv self.-cached-max (max 1 self.-cached-max))

    (when (!= original-max self.-cached-max)
      (self.-resize)))

  (defn -del-value [self val]
    (setv original-max self.-cached-max)
    (setv self.-cached-max (max 1 #* (map abs self.-vals)))

    (when (!= original-max self.-cached-max)
      (self.-resize)))

  (defn -resize [self]
    (setv self.-cached-bucket-size
          (/ self.-cached-max (- self.-bucket-count 1)))

    (for [#(i val) (enumerate self.-vals)]
      (setv (get self.-bucketed i) (self.-bucket val))))

  (defn -bucket [self val]
    (setv invert 1)
    (when (< val 0)
      (setv invert -1)
      (setv val (- val)))

    (* invert (math.floor (+ .5 (/ val self.-cached-bucket-size))))))
