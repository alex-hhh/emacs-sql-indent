select *
  from T1
         inner join T2
             on a
         cross join T3
             on b
         left join T4
             on c
         right join T5
             on d
         cross join T6
             on e
         natural join T7
             on f
         join T8
             on g
         ;

select *
  from T1
         inner join T2
             on a;

select *
  from T1
         left join T2
             on a
         ;

select *
  from T1
         right join T2
             on a
         ;

select *
  from T1
         cross join T2
             on a
         ;

select *
  from T1
         natural join T2
             on a
         ;


select *
  from T1
         join T2
             on a
         ;
