
if object_id ('some_table', 'u') is not null
  drop table some_table;

go                                      -- optional
                                        -- second procedure
select product, model
  into some_table
  from production.product_model  
 where product_model_id in (3, 4);

go                                      -- optional

if object_id ('some_table', 'u') is not null
  select product, model
    from some_table
   where model in (3, 4);

go

if (select a from b)
  select product, model
    from some_table
   where model in (3, 4);

go

-- local variables:
-- sql-product: ms
-- end:
