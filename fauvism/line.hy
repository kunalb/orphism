(import math)

(import rich.style [Style])
(import rich.segment [Segment])

(import .bucket [BucketList])


(setv BARS " ▁▂▃▄▅▆▇")
(setv COLORS ["#000000" "#1a9850" "#91cf60" "#d9ef8b"
              "#fee08b" "#fc8d59" "#d73027"])

(defclass LineRenderable []

  (defn __init__ [self [vals None]]
    (setv self.-buckets (BucketList (* (len BARS) (// (len COLORS) 2)) vals))
    (setv self.-segment-cache {}))

  (defn add-val [self val]
    (self.-buckets.append val))

  (defn segment [self bucket]
    (when (in bucket self.-segment-cache)
      (return (get self.-segment-cache bucket)))

    (setv invert 1)
    (when (< bucket 0)
      (setv invert -1)
      (setv bucket (- bucket)))

    (setv fg-color (+ 1 (// bucket (len BARS))))
    (setv bg-color (- fg-color 1))

    (setv bar-index (% bucket (len BARS)))

    (setv segment
          (Segment (get BARS bar-index)
                   (Style :color (get COLORS (* invert fg-color))
                          :bgcolor (get COLORS (* invert bg-color)))))

    (setv (get self.-segment-cache (* invert bucket)) segment)

    segment)

  (defn __rich_console__ [self console options]
    (setv offset
          (max 0 (- (len self.-buckets) (- console.size.width 10))))
    (for [bucket (cut self.-buckets offset None)]
      (yield (self.segment bucket)))
    (when self.-buckets
      (yield f" {(get self.-buckets.vals -1):.02E}"))

    (yield "\n")))
