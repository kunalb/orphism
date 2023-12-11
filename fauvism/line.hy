(import math)

(import rich.style [Style])
(import rich.segment [Segment])


(setv BARS "▁▂▃▄▅▆▇█")
(setv POSITIVE-COLORS ["#e5f5e0" "#a1d99b" "#31a354"])
(setv NEGATIVE-COLORS ["#deebf7" "#9ecae1" "#3182bd"])


(defclass LineRenderable []

  (defn __init__ [self vals]
    (setv self.vals vals)
    (self.rescale))

  (defn rescale [self]
    (setv min-val (min self.vals)
          max-val (max self.vals))
    (setv min-val (min min-val (- max-val))
          max-val (max max-val (- min-val)))
    (setv buckets
          (* (len BARS) (+ (len NEGATIVE_COLORS)
                           (len POSITIVE_COLORS))))
    (setv self.bucket-size
          (math.ceil (/ (- max-val min-val) buckets)))

    (setv self.segments
          (lfor val self.vals
                (self.segment (int (/ val self.bucket-size))))))

  (defn segment [self bucket]
    #_ (positive only)
    (setv bar-index (% bucket (len BARS)))
    (setv color-index (min (- (len POSITIVE-COLORS) 1)
                           (int (/ bucket (len BARS)))))
    (Segment (get BARS bar-index)
             (Style :color (get POSITIVE-COLORS color-index)
                    :bgcolor (if (> color-index 0)
                                 (get POSITIVE-COLORS (- color-index 1))
                                 None))))

  (defn __rich_console__ [self console options]
    (for [segment self.segments]
      (yield segment))
    (yield "\n")))
