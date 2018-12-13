select *
  from t1
         join (
           t2
           left join t3
               using (k2)
         )
             on t1.k1 = t2.k1;

