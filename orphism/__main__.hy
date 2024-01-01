(import argparse)
(import sys)

(import rich)
(import rich.live [Live])

(import .line [LineRenderable])

(require hyrule.control [defmain])


(defn main []
  "Explicitly extracted as an entrypoint"
  (setv parser (argparse.ArgumentParser))
  (parser.add-argument "vals"
                       :nargs "*"
                       :help "Values to plot, can also be piped in through stdin")
  (parser.add-argument "-l"
                       "--show-last-value"
                       :help "Show the last value on the line"
                       :action "store_true"
                       :default False)
  (setv args (parser.parse_args))

  (when args.vals
    (rich.print (LineRenderable
                  (lfor val args.vals (float val))
                  :show-last-val args.show-last-value))
    (return))

  (setv line (LineRenderable
               :show-last-val args.show-last-value))
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
