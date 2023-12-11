(import rich)
(import rich.live [Live])

(import .line [LineRenderable])

(require hyrule.control [defmain])


(defmain [script #* vals]
  (when vals
    (rich.print (LineRenderable (lfor val vals (float val))))
    (return))

  (setv line (LineRenderable))

  (with [l (Live line :auto_refresh False)]
    (for [vals sys.stdin]
      (for [val (.split vals)]
        (line.add-val (float val))
        (l.refresh)))))
