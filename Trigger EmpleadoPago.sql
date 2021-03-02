--trigger para empleado-pago--
create or replace function tr_empleadoinsert()
returns trigger as $tr_empleadoinsert$
declare
--cargo varchar;
pago int;
--nempresa varchar;
npago int;
begin
select count (*) into pago  from empleado where id_pago=new.id_pago;
		 select id_pago into npago from pago ;
if(pago >= npago) then
   raise exception SQLSTATE 'E0002' using
        message = 'Hey..Este empleado ya se le pago... ';
	return false;
end if;
return new;
end;
$tr_empleadoinsert$ language 'plpgsql';
create trigger tr_empleadoinsert
before insert or update on empleado
for each row
execute procedure tr_empleadoinsert();