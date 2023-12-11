(import rich)

(import .line [LineRenderable])

(require hyrule.control [defmain])


(defmain [script #* vals]
  (rich.print (LineRenderable
                (lfor val vals (float val)))))
