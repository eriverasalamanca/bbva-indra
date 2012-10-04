create or replace view registro.vpoblad as
select b.vobserv ctippob, a.idsigma mpoblad, a.ccodcen, a.vnombre vnompob
	, a.cidzona, trim(b.vobserv) || ' ' || trim(a.vnombre) tnompob
	, cast(extract(year from coalesce(a.dfecdes, now())) as character varying(4)) cperdes
	, cast(extract(year from coalesce(a.dfechas, now())) as character varying(4)) cperhas
	, a.nestado
from registro.mpoblad a inner join public.mconten b on a.ctipcen=b.idsigma;

create or replace view registro.vviadis as
select e.vobserv ctipvia, d.idsigma mviadis, d.vnombre vnomvia, d.ccodvia
	, trim(e.vobserv) || ' ' || trim(d.vnombre) tnomvia
	, cast(extract(year from coalesce(d.dfecdes, now())) as character varying(4)) cperdes
	, cast(extract(year from coalesce(d.dfechas, now())) as character varying(4)) cperhas
	, d.nestado
from registro.mviadis d inner join public.mconten e on d.ctipvia=e.idsigma;

drop function if exists pl_function.listar_vias(in p_cperiod character varying, in p_vnompob character varying, in p_vnomvia character varying);
create or replace function pl_function.listar_vias(in p_cperiod character varying, in p_vnompob character varying, in p_vnomvia character varying)
	returns table(ctippob character varying
		, mpoblad character
		, ccodcen character
		, vnompob character varying
		, cidzona character varying
		, tnompob text
		, nladvia smallint
		, ncuaini smallint
		, ncuafin smallint
		, narance numeric
		, cperiod character varying
		, ctipvia character varying
		, mviadis character
		, vnomvia character varying
		, ccodvia character
		, tnomvia text) as
$body$
begin
    return query
	select a.ctippob, a.mpoblad, a.ccodcen, a.vnompob, a.cidzona, a.tnompob
		, b.nladvia , b.ncuaini, b.ncuafin, b.narance, b.cperiod
		, c.ctipvia, c.mviadis, c.vnomvia, c.ccodvia, c.tnomvia
	from registro.vpoblad a
		inner join registro.marance b on a.mpoblad=b.mpoblad
		inner join registro.vviadis c on b.mviadis=c.mviadis
	where 
		b.cperiod = p_cperiod
		and a.tnompob ilike ('%' || p_vnompob || '%')
		and c.tnomvia ilike ('%' || p_vnomvia || '%');
end
$body$
language plpgsql;

create or replace view registro.vpredio as
select
	  a.idsigma mpropie, b.idsigma mpredio, a.dporcen
	, a.ctippro, c.vdescri vtippro, a.dfecadq
	, a.dfecdes, a.vnrodoc, a.dfecdoc
	, a.cmotivo, d.vdescri vmotivo, b.ctipdat
	, e.vdescri vtipfic, b.ctipdoc, e.vdescri vtipdoc
	, g.tnompob, h.tnomvia, b.dnumero
	, b.dinteri, b.dletras, b.ddepart
	, b.destaci, b.ddeposi, b.drefere
	, b.dmanzan, b.dnlotes, b.ccatast
	, b.cplanos, b.ctipmer, b.dnummer
	, b.cdiscat, b.czoncat, b.cmzacat
	, b.cseccat, b.cltecat, b.cundcat
	, b.dbloque, b.dseccio, b.dunidad
	, b.vdirpre, b.nestado, b.ccodpre
	, b.cperiod, b.idanexo, b.ccodcuc
	, b.ntippre, i.vdescri vtippre
	, j.idsigma dpredio, j.ctippre, j.cclasif
	, j.ccondic, j.cestado, j.cusogen
	, j.cusoesp, j.nporcen, j.ntertot
	, j.nporter, j.nterren, j.ncomtot
	, j.nporcom, j.narecom, j.narance
	, j.nvalpis, j.nvalins, j.nvalter
	, j.nvalpre, j.nporafe, j.nvalafe
	, j.dafecta, j.nfrente, j.ncanper
	, j.vnrodjj, j.ctippar, j.vobserv
	, j.nestado destado, a.mperson
from registro.mpropie a
	inner join registro.mpredio b on a.mpredio=b.idsigma
	inner join public.mconten c on a.ctippro=c.idsigma
	inner join public.mconten d on a.cmotivo=d.idsigma
	inner join public.mconten e on b.ctipdat=e.idsigma
	inner join public.mconten f on b.ctipdoc=f.idsigma
	inner join registro.vpoblad g on b.mpoblad=g.mpoblad
	inner join registro.vviadis h on b.mviadis=h.mviadis
	inner join public.mconten i on b.ntippre=i.idsigma
	inner join registro.dpredio j on b.idsigma= j.mpredio;

drop type if exists registro.tpredio cascade;
create type registro.tpredio as (
  mpropie character(10),
  mpredio character(10),
  dporcen numeric(18,2),
  ctippro character(10),
  vtippro character varying(250),
  dfecadq timestamp without time zone,
  dfecdes timestamp without time zone,
  vnrodoc character varying(50),
  dfecdoc timestamp without time zone,
  cmotivo character(10),
  vmotivo character varying(250),
  ctipdat character(10),
  vtipfic character varying(250),
  ctipdoc character(10),
  vtipdoc character varying(250),
  tnompob text,
  tnomvia text,
  dnumero character varying(25),
  dinteri character varying(25),
  dletras character varying(25),
  ddepart character varying(25),
  destaci character varying(25),
  ddeposi character varying(25),
  drefere character varying(100),
  dmanzan character varying(25),
  dnlotes character varying(25),
  ccatast character varying(25),
  cplanos character varying(4),
  ctipmer character varying(1),
  dnummer character varying(10),
  cdiscat character varying(25),
  czoncat character varying(25),
  cmzacat character varying(25),
  cseccat character varying(25),
  cltecat character varying(25),
  cundcat character varying(25),
  dbloque character varying(25),
  dseccio character varying(25),
  dunidad character varying(25),
  vdirpre character varying(250),
  nestado character varying(2),
  ccodpre character varying(20),
  cperiod character varying(4),
  idanexo character(10),
  ccodcuc character varying(25),
  ntippre character(10),
  vtippre character varying(250),
  dpredio character varying(10),
  ctippre character(10),
  cclasif character(10),
  ccondic character(10),
  cestado character(10),
  cusogen character(10),
  cusoesp character(10),
  nporcen numeric(10,2),
  ntertot numeric(10,5),
  nporter numeric(10,2),
  nterren numeric(10,5),
  ncomtot numeric(10,5),
  nporcom numeric(10,2),
  narecom numeric(10,5),
  narance numeric(10,5),
  nvalpis numeric(10,5),
  nvalins numeric(10,5),
  nvalter numeric(10,5),
  nvalpre numeric(10,5),
  nporafe numeric(10,2),
  nvalafe numeric(10,5),
  dafecta timestamp without time zone,
  nfrente numeric(10,5),
  ncanper integer,
  vnrodjj character varying(50),
  ctippar character(10),
  vobserv character varying(500),
  destado integer,
  mperson character(10)
);

drop function if exists pl_function.listar_predios(in p_cperiod character varying, in p_cidpers character varying);
create or replace function pl_function.listar_predios(in p_cperiod character varying, in p_cidpers character varying, p_ref refcursor)
returns refcursor as
$body$
begin
	open p_ref for select a.ccodpre
		, ((a.tnompob
			|| ' ' || a.tnomvia
			|| case when length(trim(a.dnumero)) > 0 then ' Nro. ' || trim(a.dnumero) else '' end
			|| case when length(trim(a.ddepart)) > 0 then ' Dpt. ' || trim(a.ddepart) else '' end
			|| case when length(trim(a.dmanzan)) > 0 then ' Mza. ' || trim(a.dmanzan) else '' end
			|| case when length(trim(a.dnlotes)) > 0 then ' Lte. ' || trim(a.dnlotes) else '' end) :: character varying(300)) tnumero
		, a.cusogen
		, a.nvalpre
		, a.nvalafe
		, a.dfecadq
		, a.vnrodoc
		, a.nporcen
		from registro.vpredio a
		where a.cperiod = p_cperiod and a.mperson =p_cidpers;
	return p_ref;
end
$body$
language plpgsql;

-- update registro.mpredio set cperiod='2012';
-- select * from registro.vpredio;

select ccodpre
	, dfecadq
	, vnrodoc
	, cusogen
	, nporcen
	, nvalpre
	, nvalafe
	, (tnompob :: character varying(150)) tnompob
	, (tnomvia :: character varying(150)) tnomvia
	, ((case when length(trim(dnumero)) > 0 then ' Nro. ' || trim(dnumero) else '' end
	|| case when length(trim(ddepart)) > 0 then ' Dpt. ' || trim(ddepart) else '' end
	|| case when length(trim(dmanzan)) > 0 then ' Mza. ' || trim(dmanzan) else '' end
	|| case when length(trim(dnlotes)) > 0 then ' Lte. ' || trim(dnlotes) else '' end) :: character varying(300)) tnumero
from registro.vpredio; -- ('2012', '0000000020');
-- select * from pl_function.listar_vias('2012', '', '');

/* 
*/

-- select * from registro.mpropie a inner join registro.mpredio b on a.mpredio=b.idsigma