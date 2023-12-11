(import rich)

(import .line [LineRenderable])

(require hyrule.control [defmain])


(defmain [script #* vals]
  (when vals
    (rich.print (LineRenderable (lfor val vals (float val))))
    (return)))
