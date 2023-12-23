(import unittest)

(import fauvism.bucket [BucketList])

(require hyrule.control [defmain])


(defclass TestBucket [unittest.TestCase]

  (defn test-empty [self]
    (setv buckets (BucketList 10))
    (self.assertEqual (len buckets) 0))

  (defn test-exact [self]
    (setv buckets (BucketList 3))
    (buckets.extend (range 0 3))

    (self.assertEqual buckets.vals [0 1 2])
    (self.assertEqual (list buckets) [0 1 2])
    (self.assertEqual buckets.bucket-size 1))

  (defn test-negatives [self]
    (setv buckets (BucketList 3))
    (buckets.extend (range 0 -3 -1))

    (self.assertEqual buckets.vals [0 -1 -2])
    (self.assertEqual (list buckets) [0 -1 -2])
    (self.assertEqual buckets.bucket-size 1))

  (defn test-interpolation [self]
    (setv buckets (BucketList 3))
    (buckets.extend (range -4 6 2))

    (self.assertEqual buckets.vals [-4 -2 0 2 4])
    (self.assertEqual (list buckets) [-2 -1 0 1 2])
    (self.assertEqual buckets.bucket-size 2))


  ; test deletion
  )


(defmain []
  (unittest.main))
