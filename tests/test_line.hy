(import unittest)

(import orphism.line)

(require hyrule.control [defmain])


(defclass TestLine [unittest.TestCase]

  (defn test_scaling [self]
    (self.assertTrue False)))


(defmain []
  (unittest.main))
