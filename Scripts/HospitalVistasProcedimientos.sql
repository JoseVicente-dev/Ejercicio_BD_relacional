/*
INSTRUCCIONES DE EJECUCION

1. Ejecutar el script completo DDL-HospitalEsquema.sql

2. Ejecutar el script HospitalVistasProcedimientos.sql
*NOTA*: Ejecutar cada creacion de procedimiento y vista de forma individual para evitar errores de sintaxis

3. Ejecutar el script completo DML-HospitalData.sql

4. Ejecutar los CRUDs del archivo HospitalCRUDs.sql

AUTORES: Johan Muñetón, Samuel Duque, Jose Velasco - febrero/2022
*/

/* ----------------------------------------PROCEDIMIENTOS ALMACENADOS---------------------------------------- */

/*Lleva el control de los ingresos de una determinada historia clínica. Recibe como parámetro el valor raiz de la historia clínica*/
DELIMITER //
create procedure aumentarIngreso(in historiaClinica varchar(50))
begin
declare
max int;
select numIngreso into max from ingreso where numHistoriaClinica = historiaClinica order by numIngreso desc limit 1;
update ingreso set numIngreso =max+1 where numHistoriaClinica=historiaClinica and numIngreso=0;
end //
DELIMITER ;

/* Resta de las unidosis  del fármaco según el consumo. Recibe como parámetro la dosis consumida y el numero de registro del fármaco*/
DELIMITER //
create procedure restarFarmaco(in consumo int, in registro varchar(50))
begin
update farmaco set unidosis = (unidosis - consumo) where (numDeRegistro = registro);
end //
DELIMITER ;

/*Calcula el precio por unidosis de un farmaco de acuerdo al precio del envase y las unidosis*/
DELIMITER //
create procedure calcularPrecioUnidosis(in registro varchar(50))
begin
update farmaco set precioPorUnidosis = (farmaco.precioEnvase/farmaco.unidosis) where (numDeRegistro = registro);
end //
DELIMITER ;

/* ----------------------------------------PROCEDIMIENTOS ALMACENADOS fin---------------------------------------- */

/* --------------------------------- VISTAS ---------------------------------------- */

/* --Vista final que permite conocer los gastos por paciente ingresado y por servicio al que se ingresa*/
create view 
gastoPorPacientePorServicio as 
select concat('',i.numHistoriaClinica,i.numIngreso) as "Historia clinica",concat_ws(' ', p.primerNombre, p.segundoNombre) as "Nombres",concat_ws(' ', p.primerApellido, p.segundoApellido ) as "Apellidos",s.nombre as "Servicio",f.numDeRegistro as "Registro sanitario medicamento", f.nombreComercial as "Nombre Comercial", f.nombreClinico as "Nombre Clinico", r.unidosisConsumidas as "Unidosis consumidas",f.precioPorUnidosis as 'Precio por unidosis ($)',(f.precioPorUnidosis*r.unidosisConsumidas) as 'Gasto ($)'  
from farmaco as f inner join  receta as r on f.numDeRegistro = r.numDeRegistro 
inner join ingreso as i on r.numHistoriaClinica = i.numHistoriaClinica and r.numIngreso = i.numIngreso
inner join servicio as s on i.idServicio = s.idServicio
inner join paciente as p on i.numHistoriaClinica = p.numHistoriaClinica;

/* ------Vista intermedia que permite conocer los consumos por servicio------ */
create view 
gastoPorServicio as 
select s.nombre as nombreServicio, cf.idServicio, f.numDeRegistro,f.nombreClinico, cf.unidosisConsumidas,f.nombreComercial,f.precioPorUnidosis
from servicio as s
inner join consumoFarmaco as cf on s.idServicio = cf.idServicio
inner join farmaco as f on cf.numDeRegistro = f.numDeRegistro;

/* ------Vista intermedia que permite conocer los consumos por paciente ingresado------ */
create view 
gastoPorIngreso as 
select s.nombre as nombreServicio,m.idServicio, f.numDeRegistro, f.nombreClinico, r.unidosisConsumidas,f.nombreComercial, f.precioPorUnidosis
from servicio as s inner join medico as m on s.idServicio = m.idServicio
inner join receta as r on m.numDeColegiado = r.numDeColegiado
inner join farmaco as f on r.numDeRegistro = f.numDeRegistro;

/* ------Vista intermedia que une los consumos por paciente y por servicio------ */
create view 
unionGastos as
select * from gastoPorIngreso as gi
union 
select * from gastoPorServicio as gs;

/* ------Vista final que permite conocer los gastos totales por servicio------ */
create view
gastoTotalPorServicio as
select ug.nombreServicio as 'Servicio', sum(ug.unidosisConsumidas*ug.precioPorUnidosis) as 'Gasto total por servicio ($)'
from unionGastos as ug group by ug.idServicio;


select * from gastoPorPacientePorServicio;
select * from gastoPorIngreso;
select * from gastoPorServicio;
select * from unionGastos;
select * from gastoTotalPorServicio;

/* ----------------------------------------VISTAS fin ---------------------------------------- */