(import math)

(import rich.style [Style])
(import rich.segment [Segment])


(setv POSITIVE-BARS "▁▂▃▄▅▆▇")
(setv NEGATIVE-BARS "▇▆▅▄▃▂▁")

(setv BACKGROUND-COLOR "#000000")
(setv NEGATIVE-COLORS (cut ["#fee08b" "#fc8d59" "#d73027"] None None -1))
(setv POSITIVE-COLORS (cut ["#d9ef8b" "#91cf60" "#1a9850"] None None -1))
                                ; neutral "#ffffbf"

(defclass LineRenderable []

  (defn __init__ [self [vals None]]
    (setv self.vals (or vals []))
    (setv self.segments [])
    (self.rescale))

  (defn rescale [self]
    (when (not self.vals) (return))

    (setv min-val (min self.vals)
          max-val (max self.vals))
    (setv min-val (min min-val (- max-val))
          max-val (max max-val (- min-val)))
    (setv buckets
          (+
            (* (len POSITIVE-BARS) (len POSITIVE_COLORS))
            (* (len NEGATIVE-BARS) (len NEGATIVE-COLORS))))
    (setv self.bucket-size
          (math.ceil (/ (- max-val min-val) buckets)))
    (print self.bucket-size)

    (setv self.segments
          (lfor val self.vals
                (self.segment (int (/ val self.bucket-size))))))

  (defn add-val [self val]
    (self.vals.append val)
    (self.rescale))

  (defn segment [self bucket]
    (if (>= bucket 0)
        (do
          (setv bar-index (% bucket (len POSITIVE-BARS)))
          (setv color-index (min (- (len POSITIVE-COLORS) 1)
                                 (int (/ bucket (len POSITIVE-BARS)))))
          (Segment (get POSITIVE-BARS bar-index)
                   (Style :color (get POSITIVE-COLORS color-index)
                          :bgcolor (if (> color-index 0)
                                       (get POSITIVE-COLORS (- color-index 1))
                                       BACKGROUND-COLOR))))
        (do
          (setv bar-index (% (- bucket) (len NEGATIVE-BARS)))
          (setv color-index (min (- (len NEGATIVE-COLORS) 1)
                                 (int (/ (- bucket) (len NEGATIVE-BARS)))))
          (Segment (get NEGATIVE-BARS bar-index)
                   (Style :bgcolor (get NEGATIVE-COLORS color-index)
                          :color (if (> color-index 0)
                                     (get NEGATIVE-COLORS (- color-index 1))
                                     BACKGROUND-COLOR))))))

  (defn __rich_console__ [self console options]
    (setv offset
          (max 0 (- (len self.segments) (- console.size.width 10))))
    (for [segment (cut self.segments offset None)]
      (yield segment))
    (when self.vals
      (yield f" {(get self.vals -1):.02E}"))

    (yield "\n")))
