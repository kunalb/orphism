(import sys)

(import rich)
(import rich.live [Live])

(import .line [LineRenderable])

(require hyrule.control [defmain])


(defn main []
  "Explicitly extracted as an entrypoint"
  (setv #(script #* vals) sys.argv)

  (when vals
    (rich.print (LineRenderable (lfor val vals (float val))))
    (return))

  (setv line (LineRenderable))

  (with [l (Live line :auto_refresh False)]
    (try
      (for [vals sys.stdin]
        (for [val (.split vals)]
          (line.add-val (float val))
          (l.refresh)))
      (except [e KeyboardInterrupt]
        (print "Interrupted! Exiting...")))))


(defmain []
  (main))
