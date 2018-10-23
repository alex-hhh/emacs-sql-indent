/* -*- sql-product: postgres; -*- */
set serveroutput on;

begin transaction;
do $$ DECLARE
  v1 TABLE1.F1%TYPE;
  v2 record;
  BEGIN
    v1 = :v_v1;
    if v1 in (NULL, '') then
      raise 'message1';
      rollback;
    elsif (select count(F1) from TABLE1
            where F1 = v1) = 0 then
      raise 'message2';
      rollback;
    elsif (select count(F2)
             from TABLE1 natural join TABLE2
            where F1 = v1) = 0 then
      raise 'message3';
      rollback;
    elsif (select count(F3)
             from TABLE3
                    natural join TABLE2
                    natural join TABLE1
            where F1 = v1) = 0 then
      raise 'message4';
      rollback;
    else
      for v2 in 
        select *
        from TABLE3 
        natural join TABLE1
        natural join TABLE4
        natural join TABLE2
        where F1 = v1 loop
        raise info 'message5',
          v2.F3, v2.F2, v2.F4 || ' ' ||
          v2.F9 || case when v2.F5 is NULL then '' else
          ' ''' || v2.F5 || '''' end, v2.F6,
          v2.F7, v2.F8;
      end loop;
    end if;
  END; $$;
commit;

do $$ DECLARE
  v1 TABLE4.F9%TYPE;
  prev1 TABLE4.F4%TYPE;
  v2 record;
  BEGIN
    v1 := :v_v1;
    prev1 := :v_prev1;
    if v1 in (NULL, '') then
      raise 'message6';
      rollback;
    elsif prev1 in (NULL, '') then
      raise 'message7';
      rollback;
    elsif (select count(F10)
             from TABLE4
            where F9 = v1
              and F4 = prev1) = 0 then
      raise 'message8';
      rollback;
    elsif (select count(F2)
             from TABLE2
                    natural join TABLE5
                    natural join TABLE4
            where F9 = v1
              and F4 = prev1) = 0 then
      raise 'message9';
      rollback;
    elsif (select count(F3)
             from TABLE3
                    natural join TABLE2
                    natural join TABLE5
                    natural join TABLE4
            where F9 = v1
              and F4 = prev1) = 0 then
      raise 'message10';
      rollback;
    else
      for v2 in select *
        from TABLE4
        natural join TABLE5
        natural join TABLE3
        natural join TABLE2
        where F9 = v1
        and F4 = prev1 loop
        raise info 'message11',
          v2.F3, v2.F2, v2.F4 || ' ' ||
          v2.F9 || case when v2.F5 is NULL then '' else
          ' ''' || v2.F5 || '''' end, v2.F6,
          v2.F7, v2.F8;
      end loop;
    end if;
  end; $$;


do $$ DECLARE
  v2 record;
  v3 TABLE2.F6%TYPE;
  BEGIN
    v3 := :v_v3;
    if v3 in ('', NULL) then
      raise 'message12';
      rollback;
    elsif (select count(F6) from TABLE2
            where F6 = v3) = 0 then
      raise 'message13';
      rollback;
    elsif (select count(F3)
             from TABLE3
                    natural join TABLE2
            where F6 = v3) = 0 then
      raise 'message14';
      rollback;
    else
      for v2 in select *
        from TABLE4
        natural join TABLE5
        natural join TABLE3
        natural join TABLE2
        where F6 = v3 loop
        raise info 'message15',
          v2.F3, v2.F2, v2.F4 || ' ' ||
          v2.F9 || case when v2.F5 is NULL then '' else
          ' ''' || v2.F5 || '''' end, v2.F6,
          v2.F7, v2.F8;
      end loop;
    end if;
  END; $$;

do $$ DECLARE
  v2 record;
  v3 TABLE2.F2%TYPE;
  BEGIN
    v3 := :v_ouv_titre;
    if v3 in ('', NULL) then
      raise 'message16';
      rollback;
    elsif (select count(F2) from TABLE2
            where F2 = v3) = 0 then
      raise 'messaeg17';
      rollback;
    elsif (select count(F3)
             from TABLE3
                    natural join TABLE2
            where F2 = v3) = 0 then
      raise 'message18';
      rollback;
    else
      for v2 in select *
        from TABLE4
        natural join TABLE5
        natural join TABLE3
        natural join TABLE2
        where F2 = v3 loop
        raise info 'message19',
          v2.F3, v2.F2, v2.F4 || ' ' ||
          v2.F9 || case when v2.F5 is NULL then '' else
          ' ''' || v2.F5 || '''' end, v2.F6,
          v2.F7, v2.F8;
      end loop;
    end if;
  END;
$$;

do $$ DECLARE
  v1 TABLE6.F12%TYPE;
  prev1 TABLE6.F13%TYPE;
  v2 record;
  BEGIN
    v1 := :v_v1;
    prev1 := :v_v2;
    if v1 in ('', NULL) then
      raise 'message20';
      rollback;
    elsif prev1 in ('', NULL) then
      raise 'message21';
      rollback;
    elsif (select count(F23) from TABLE6
            where F12 = v1
              and F13 = prev1) = 0 then
      raise 'message22';
      rollback;
    else
      for v2 in select * from TABLE6
        where F12 = v1
        and F13 = prev1 loop
        raise info 'message23',
          v2.F23, v2.F13 || ' ' || v2.F12,
          v2.F27, v2.F28;
      end loop;
    end if;
  END;
$$;

begin transaction;
do $$ DECLARE
  v1 TABLE6.F23%TYPE;
  v1 TABLE6.F12%TYPE;
  prev1 TABLE6.F13%TYPE;
  v9 TABLE6.V2%TYPE;
  BEGIN
    select max(v2_id)+1 into v1 from t_v2ent;
    v1 := :v_v2_c2;
    prev1 := :v_v2_c8;
    v9 := :v_v2_c9;
    if v1 in ('', NULL) then
      raise 'message24';
      rollback;
    elsif prev1 in ('', NULL) then
      raise 'message25';
      rollback;
    elsif v9 in ('', NULL) then
      raise 'message26';
      rollback;
    else
      insert into TABLE6 values (v1, :v19, timestamp 'now',
                                 v1, prev1, :v_v2_v8,
                                 :v_v2_c7, :v_v2_v9,
                                 :v_v2_c8, :v_v2_v10,
                                 :v_v2_c9, v9);
      raise notice 'message27', v1;
    end if;
  END;
$$;
commit;

begin transaction;
do $$ DECLARE
  v1 TABLE6.F23%TYPE;
  BEGIN
    v1 := :v_v2_id;
    if (select count(F23) from TABLE6 where F23 = v2_id) = 0 then
      raise 'message28';
      rollback;
    elsif (select F27 from TABLE6 where F23 = v1) is not
      NULL then
      raise 'message29';
      rollback;
    else
      delete from TABLE6 where V1 = v1;
      raise notice 'message 30';
    end if;
  END;
$$;
commit;
