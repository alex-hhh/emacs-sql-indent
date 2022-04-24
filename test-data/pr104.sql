alter table x
   drop constraint if exists not_unique_idx,
  add constraint unique_idx unique (this, that);
