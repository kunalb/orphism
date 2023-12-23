(import math)

(import rich.style [Style])
(import rich.segment [Segment])

(import .bucket [BucketList])


(setv BARS " ▁▂▃▄▅▆▇")
(setv COLORS ["#000000" "#1a9850" "#91cf60" "#d9ef8b"
              "#fee08b" "#fc8d59" "#d73027"])

; Add NAN / INF support

(defclass LineRenderable []

  (defn __init__ [self [vals None]]
    (setv self.-buckets (BucketList (* (len BARS) (// (len COLORS) 2)) vals))
    (setv self.-segment-cache {}))

  (defn add-val [self val]
    (self.-buckets.append val))

  (defn positive-segment [self bucket]
    (setv fg-color (+ 1 (// bucket (len BARS))))
    (setv bg-color (- fg-color 1))
    (setv bar-index (% bucket (len BARS)))
    (Segment (get BARS bar-index)
             (Style :color (get COLORS fg-color)
                    :bgcolor (get COLORS bg-color))))

  (defn negative-segment [self bucket]
    (setv bg-color (+ 1 (// (- bucket 1) (len BARS)))
          fg-color (- bg-color 1)
          bar-index (- (% bucket (len BARS))))

    (Segment (get BARS bar-index)
             (Style :color (get COLORS (- fg-color))
                    :bgcolor (get COLORS (- bg-color)))))

  (defn segment [self bucket]
    (when (in bucket self.-segment-cache)
      (return (get self.-segment-cache bucket)))

    (setv segment
      (if (>= bucket 0)
          (self.positive-segment bucket)
          (self.negative-segment (- bucket))))

    (setv (get self.-segment-cache bucket) segment)
    segment)

  (defn __rich_console__ [self console options]
    (setv offset
          (max 0 (- (len self.-buckets) (- console.size.width 10))))
    (for [bucket (cut self.-buckets offset None)]
      (yield (self.segment bucket)))
    (when self.-buckets
      (yield f" {(get self.-buckets.vals -1):.02E}"))

    (yield "\n")))
