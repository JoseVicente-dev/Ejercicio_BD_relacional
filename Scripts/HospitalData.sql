/*
INSTRUCCIONES DE EJECUCION

1. Ejecutar el script completo DDL-HospitalEsquema.sql

2. Ejecutar el script HospitalVistasProcedimientos.sql
*NOTA*: Ejecutar cada creacion de procedimiento y vista de forma individual para evitar errores de sintaxis

3. Ejecutar el script completo DML-HospitalData.sql

4. Ejecutar los CRUDs del archivo HospitalCRUDs.sql

AUTORES: Johan Muñetón, Samuel Duque, Jose Velasco - febrero/2022
*/

use samuelDuque_joseVelasco_johanMuneton_24_02_2022;

insert into paciente values('A001-','Jose','Vicente','Velasco','Lopez','1987-09-28','34565816','calle','9','16','126');
insert into paciente values('B001-','Samuel','Ignacio','Duque','Rodriguez','1998-11-09','36984529','carrera','12','106','12');
insert into paciente values('C001-','Johan','','Muñeton','','1992-11-04','75984612','avenida','5','87','165');

insert into servicio values('01','Pediatria');
insert into servicio values('02','Oncologia');
insert into servicio values('03','Traumatologia');

insert into farmaco values('F-001','P-01','Bodega1','Viagra','Sildenafil','C22H30N6O4S',15000,4,3750);
insert into farmaco values('F-002','P-02','Bodega2',null,'Acetaminofen','C8H9NO2',8000,10,800);
insert into farmaco values('F-003','P-03','Bodega3','Advil','Ibuprofeno','C13H18O2',8300,5,1660);
insert into farmaco values('F-004','P-03','Bodega3',null,'Alcohol etilico','C2H5OH',6400,100,64);
insert into farmaco values('F-010','P-08','Bodega6',null,'Morfina','C17H19NO3',173000,25,6920);
insert into farmaco values('F-005','P-04','Bodega4','Dolex','Acetaminofen','C8H9NO2',8000,8,1000);

insert into medico values('M001','Manuel','','Salas','','454656546','carretera','2','06','13','02');
insert into medico values('M002','Ivan','','Arroyave','','30215485','calle','13','11','15','03');
insert into medico values('M003','Daniel','','Londoño','Ramirez','35471236','carrera','5','22','11','01');

insert into ingreso(numHistoriaClinica,fecha,diagnostico,idServicio) values('A001-','1990-06-24','Fractura de radio','01');
call aumentarIngreso('A001-');
insert into ingreso(numHistoriaClinica,fecha,diagnostico,idServicio) values('A001-','2005-03-11','Desprendimiento de rotula','03');
call aumentarIngreso('A001-');
insert into ingreso(numHistoriaClinica,fecha,diagnostico,idServicio) values('A001-','2015-04-22','Lunar muy grande','02');
call aumentarIngreso('A001-');
insert into ingreso(numHistoriaClinica,fecha,diagnostico,idServicio) values('B001-','2016-03-11','Desprendimiento de rotula','03');
call aumentarIngreso('B001-');
insert into ingreso(numHistoriaClinica,fecha,diagnostico,idServicio) values('B001-','2018-12-03','Migraña','03');
call aumentarIngreso('B001-');
insert into ingreso(numHistoriaClinica,fecha,diagnostico,idServicio) values('C001-','2020-04-15','Ulcera gastrica cronica','02');
call aumentarIngreso('C001-');

insert into consumoFarmaco(unidosisConsumidas,fecha,idServicio,numDeRegistro) values (3,'1999-06-23','01','F-004');
call restarFarmaco(3,'F-004');

insert into receta(unidosisConsumidas,fecha,numHistoriaClinica,numIngreso,numDeColegiado,numDeRegistro) values(1,'2018-12-18','B001-',2,'M002','F-003');
call restarFarmaco(1,'F-003');
insert into receta(unidosisConsumidas,fecha,numHistoriaClinica,numIngreso,numDeColegiado,numDeRegistro)values(1,'2020-04-20','C001-',1,'M001','F-010');
call restarFarmaco(1,'F-010');
insert into receta(unidosisConsumidas,fecha,numHistoriaClinica,numIngreso,numDeColegiado,numDeRegistro) values(2,'2015-04-30','A001-',3,'M001','F-005');
call restarFarmaco(2,'F-005');
insert into receta(unidosisConsumidas,fecha,numHistoriaClinica,numIngreso,numDeColegiado,numDeRegistro) values(2,'1990-06-24','A001-',1,'M003','F-002');
call restarFarmaco(2,'F-002');
insert into receta(unidosisConsumidas,fecha,numHistoriaClinica,numIngreso,numDeColegiado,numDeRegistro) values(5,'2018-12-18','B001-',2,'M002','F-005');
call restarFarmaco(5,'F-005');

insert into revision(informe,hora,fecha,numHistoriaClinica,numIngreso,numDeColegiado) values('El paciente presenta dolor','20:30','1990-06-24','A001-',1,'M003');
insert into revision(informe,hora,fecha,numHistoriaClinica,numIngreso,numDeColegiado) values('El paciente presenta una fractura osea y mucho dolor','05:42','2016-03-11','B001-',1,'M002');
insert into revision(informe,hora,fecha,numHistoriaClinica,numIngreso,numDeColegiado) values('El paciente presenta mucho dolor y vomito','12:02','2020-04-15','C001-',1,'M001');