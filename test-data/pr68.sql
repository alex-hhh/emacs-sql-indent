SELECT *
  FROM t1
         JOIN (
           t2
           LEFT JOIN t3 USING (k2)
         )
             ON t1.k1 = t2.k1
