/*
INSTRUCCIONES DE EJECUCION

1. Ejecutar el script completo DDL-HospitalEsquema.sql

2. Ejecutar el script HospitalVistasProcedimientos.sql

3. Ejecutar el script completo DML-HospitalData.sql

4. Ejecutar los CRUDs del archivo HospitalCRUDs.sql

AUTORES: Johan Muñetón, Samuel Duque, Jose Velasco - febrero/2022
*/

create database samuelDuque_joseVelasco_johanMuneton_24_02_2022 character set utf8;
use samuelDuque_joseVelasco_johanMuneton_24_02_2022;


create table paciente(
	numHistoriaClinica nvarchar(50) not null unique,
    primary key (numHistoriaClinica),
    primerNombre nvarchar(20) not null,
    segundoNombre nvarchar(20) null,
    primerApellido nvarchar(20) not null,
    segundoApellido nvarchar(20) null,
    fechaDeNacimiento date not null,
    telefono nvarchar(20) null,
    viaPrincipal nvarchar(20) not null,
    numViaPrincipal nvarchar(10) not null,
    viaGeneradora nvarchar(10) not null,
    numViaGeneradora nvarchar(10) not null  

);

create table ingreso(
	numHistoriaClinica nvarchar(50) not null,
    numIngreso int not null default 0,   
    fecha date not null,
    fechaDeAlta date null,
    diagnostico nvarchar(500) not null,
    idServicio nvarchar(10) not null,
    primary key (numHistoriaClinica,numIngreso),
    foreign key (numHistoriaClinica) references paciente(numHistoriaClinica) on update cascade on delete no action    
);

create table servicio(
	idServicio nvarchar(10) not null unique,
    nombre nvarchar(50) not null unique,
    primary key (idServicio)
);
alter table ingreso add foreign key (idServicio) references servicio(idServicio) on update cascade on delete no action;

create table farmaco(
	numDeRegistro nvarchar(50) not null unique,
    codigoProveedor nvarchar(50) not null,
    ubicacion nvarchar(20) not null,
    nombreComercial nvarchar(50) null unique,
    nombreClinico nvarchar(50) not null,
    compuestoQuimico nvarchar(100) not null,
    precioEnvase decimal(10,2) not null,
    unidosis int not null,
    precioPorUnidosis decimal(10,2) not null,
    primary key (numDeRegistro)
);

create table consumoFarmaco(	
	idConsumoFarmaco int auto_increment unique,    
	unidosisConsumidas int not null,
    fecha date not null,
    idServicio nvarchar(10) not null unique,
    numDeRegistro nvarchar(50) not null unique,    
    primary key(idConsumoFarmaco),
    foreign key (idServicio) references servicio(idServicio)  on update cascade on delete no action,
    foreign key (numDeRegistro) references farmaco(numDeRegistro)  on update cascade on delete no action
    );
    
create table medico(
	numDeColegiado nvarchar(50) not null unique,
    primerNombre nvarchar(20) not null,
    segundoNombre nvarchar(20) null,
    primerApellido nvarchar(20) not null,
    segundoApellido nvarchar(20) null,
    telefono nvarchar(30) not null,
    viaPrincipal nvarchar(20) not null,
    numViaPrincipal nvarchar(10) not null,
    viaGeneradora nvarchar(10) not null,
    numViaGeneradora nvarchar(10) not null,
    idServicio nvarchar(10) not null,
    primary key (numDeColegiado),
    foreign key (idServicio) references servicio(idServicio)  on update cascade on delete no action
);

create table revision(
	idRevision int auto_increment unique,
	informe nvarchar(500) not null,
    hora time not null,
    fecha date not null,
    numHistoriaClinica nvarchar(50) not null,
    numIngreso int not null,
    numDeColegiado nvarchar(50) not null,    
    primary key(idRevision),
    foreign key (numHistoriaClinica,numIngreso) references ingreso(numHistoriaClinica,numIngreso)  on update cascade on delete no action,
    foreign key (numDeColegiado) references medico(numDeColegiado)  on update cascade on delete no action
);

create table receta(	
	idReceta int auto_increment unique,
	unidosisConsumidas int not null,
    fecha date not null,
    numHistoriaClinica nvarchar(50) not null,
    numIngreso int not null,
    numDeColegiado nvarchar(50) not null,
    numDeRegistro nvarchar(50) not null,
    primary key(idReceta),
    foreign key (numHistoriaClinica,numIngreso) references ingreso(numHistoriaClinica,numIngreso)  on update cascade on delete no action,
    foreign key (numDeColegiado) references medico(numDeColegiado)  on update cascade on delete no action,    
    foreign key (numDeRegistro) references farmaco(numDeRegistro)  on update cascade on delete no action
);





