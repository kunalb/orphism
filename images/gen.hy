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
               :expand True
               :show_header False))

  (setv inputs (lfor x (range 0 (* 2 628) 12) (/ x 100)))

  (table.add_row
    "sin"
    (LineRenderable (list (map math.sin inputs))))
  (table.add_row
    "cos"
    (LineRenderable (list (map math.cos inputs))))
  (table.add_row
    "x"
    (LineRenderable inputs))
  (table.add_row
    "x^2"
    (LineRenderable (list (map (fn [x] (* x x)) inputs))))

  (setv console (Console :record True))
  (console.print table :justify "center")
  (console.save_svg "orphism.svg" :title "Orphism"))
