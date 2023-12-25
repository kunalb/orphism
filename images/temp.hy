"
Rendering data from weather.gov
https://www.weather.gov/wrh/Climate?wfo=okx

Temperatures in Central Park, NY over November
"

(import csv)
(import math)

(import rich [box]
        rich.console [Console]
        rich.table [Table])
(import orphism.line [LineRenderable])

(require hyrule [defmain])


(defmain []
  (setv table
        (Table "~" "Chart"
               :box box.SIMPLE_HEAD
               :show_header False))

  (setv maxs []
        mins []
        avgs []
        deps [])

  (with [chart (open "chart.csv")]
    (setv chart-reader (csv.reader chart))
    (for [row chart-reader]
      (maxs.append (float (get row 1)))
      (avgs.append (float (get row 2)))
      (mins.append (float (get row 3)))
      (deps.append (float (get row 4)))))

  (setv inputs (lfor x (range 0 (* 2 628) 12) (/ x 100)))
  (table.add_row "Max" (LineRenderable maxs))
  (table.add_row "Avg" (LineRenderable avgs))
  (table.add_row "Min" (LineRenderable mins))
  (table.add_row "Departure" (LineRenderable deps))

  (setv console (Console))
  (console.print table :justify "center"))
