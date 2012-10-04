CLOSE ALL

SET PROCEDURE TO evp_procesos
SET DATE FRENCH 
*--
ipserver = "localhost"
uidserver = "postgres"
pwdserver = "ydaleu"
bdserver = "puentepiedra"
*bdserver = "titania_test"
PUBLIC lcstring 
lcstring = SQLSTRINGCONNECT("Driver={PostgreSQL ANSI};SERVER="+ipserver+";Port=5432;Database="+bdserver+";Uid="+ uidserver + ";Pwd="+ pwdserver +";")
IF lcstring<1
	MESSAGEBOX("Imposible conectar con PostgreSQL", 16)
	return
ENDIF
*--
parte00 = 'SELECT contrib, tributo, peini, vdeuda, vmora, vderemi, fvenc, usuario, ws, fcontrol, hcontrol, aini FROM ctacte '
IF SQLEXEC( lcstring, parte00, 'ctacte00' ) > 0
	SqLCOMMIT(lcstring)
	brow
ELSE
	SQLrollback(lcstring)
	CLOSE ALL
	return
endif 
*--
p_anual = '2000'
SELECT ctacte00 
SELECT distinct  ;
	SPACE(10) idsigma, ;
	a.contrib cidpers, ;
	b.idpredio cidpred, ;
	c.tributo00 ctiping, ;
	c.tributo00 ctiprec, ;
	SPACE(25) nnumdoc, ;
	SPACE(25) nconven, ;
    peini cperiod, ;
    1 ncantid, ;
    vdeuda imp_insol, ;
    1.00 fact_reaj, ;
    0.00 imp_reaj, ;
    0.00 fact_mora, ;
    0.00 imp_mora, ;
    vderemi costo_emis, ;
    iif( peini = '00', a.fcontrol, IIF( tributo00 = '0000000273' ,  CTOD( '01/' + TRANSFORM(( VAL( peini) * 3) -1 , '@l 99' ) +'/'+ a.aini ), CTOD( '01/' + peini +'/'+ a.aini )) ) dfecven, ;
    CTOT( '01/01/1990') dfecpag, ;
    ' ' vobserv, ;
    0 nestado, ;
    a.usuario vusernm, ;
    a.ws vhostnm, ;
    CTOT(DTOC( a.fcontrol ) +' '+ a.hcontrol ) ddatetm, ;
    a.aini cperanio ;
	FROM ctacte00 a ;
	INNER JOIN  predio99 b ON b.contrib = a.contrib AND b.aini = '2011' ; 
	INNER JOIN  tributo00 c ON c.tra = a.tributo ;
	WHERE BETWEEN( a.aini, p_anual , '2012' ) ;
	ORDER BY a.aini, c.tributo00 ;
INTO TABLE recibo_ctacte

*	INNER JOIN  predio99 b ON b.contrib = a.contrib AND b.aini = '2011' ; a.aini ; 
* se especifica el año 2011 por lo que no hay año 2012

p_ano = cperanio
p_cuenta = 0
SCAN
	IF p_ano <> cperanio
		p_cuenta = 0
	ENDIF
	p_cuenta = p_cuenta +1 
	xidsigma = RIGHT(p_ano,2) + TRANSFORM( p_cuenta, '@l 99999999')
	REPLACE idsigma WITH xidsigma
	p_ano = cperanio
ENDSCAN

COPY TO recibo_ctacte.txt DELIMITED WITH '"' WITH CHAR TAB
COPY TO ctacte_sdf.SDF TYPE SDF
COPY TO ctacte_xls.xls TYPE xl5


*!*	SELECT idsigma, cidpers, cidpred, ctiping, ctiprec, nnumdoc, nconven, 
*!*	       cperiod, ncantid, imp_insol, fact_reaj, imp_reaj, fact_mora, 
*!*	       imp_mora, costo_emis, dfecven, dfecpag, vobserv, nestado, vusernm, 
*!*	       vhostnm, ddatetm, cperanio


CLOSE ALL
return



CLOSE ALL
return