(import collections.abc [MutableSequence])
(import enum [Enum])


(defclass BucketList [MutableSequence]

  (defclass Scale [Enum]
    (setv LINEAR 0)
    (setv LOG 1))

  (defn __init__ [self
                  bucket-count
                  [iterable None]
                  [range-max None]
                  [scale Scale.LINEAR]]
    (setv
      self.-bucket-count bucket-count
      self.-vals (if iterable (list iterable) [])
      self.-scale scale
      self.-range-max range-max
      self.-bucketed []))

  (defn set-range-max [self range-max]
    (setv self.-range-max range-max))

  (defn get-range-max [self]
    self.-range-max)

  (defn vals [self]
    self.-vals)

  ;; Abstract methods

  (defn __getitem__ [self key]
    (get self.-bucketed key))

  (defn __len__ [self]
    (len self.-bucketed))

  (defn __setitem__ [self key val]
    (setv (get self.-vals key) val))

  (defn __delitem__ [self]
    (del (get self.-vals key)))

  (defn insert [self key val]
    (self.-vals.insert key val)))
