(import unittest)

(import fauvism.bucket [BucketList])

(require hyrule.control [defmain])


(defclass TestBucket [unittest.TestCase]

  (defn test-empty [self]
    (setv buckets (BucketList 10))
    (self.assertEqual (len buckets) 0))

  (defn test-exact [self]
    )

  (defn test-negatives [self]
    )

  )


(defmain []
  (unittest.main))
