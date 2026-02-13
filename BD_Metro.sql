-- corregido: drop database if exists proyecto_metro;
drop database if exists proyecto_metro;
create database proyecto_metro;
use proyecto_metro;

-- 1. creacion de tablas
create table personal (
    id_personal int primary key,
    nombre varchar(100),
    cargo varchar(50)
);

create table impacto_trafico (
    id_impacto int primary key,
    zona varchar(100),
    reduccion_trafico_porcentaje decimal(5,2)
);

create table horarios (
    id_horario int primary key,
    hora_salida time,
    hora_llegada time,
    id_tren int,
    FOREIGN KEY (id_tren) REFERENCES trenes(id_tren)
);

create table mantenimiento (
    id_mantenimiento int primary key,
    fecha date,
    descripcion text,
    id_tren int,
    FOREIGN KEY (id_tren) REFERENCES trenes(id_tren)
);

create table Lineas (
    id_linea int primary key auto_increment,
    nombre_linea varchar(50) not null,
    color varchar(30),
    longitud_km decimal(5,2)
);

create table Estaciones (
    id_estacion int primary key auto_increment,
    nombre varchar(50) not null,
    zona varchar(30),
    id_linea int,
    foreign key (id_linea) references Lineas(id_linea)
);
create table trenes (
    id_tren int auto_increment primary key,
    modelo varchar(50) not null,
    capacidad_pasajeros int not null,
    estado varchar(30) not null
);


create table conductores (
    id_conductor int auto_increment primary key,
    nombre varchar(100) not null,
    licencia varchar(50) not null,
    anios_experiencia int not null
);

-- 2. procedimientos crud para personal con delimiter

delimiter //

create procedure sp_crear_personal(in _id int, in _nom varchar(100), in _car varchar(50))
begin
    insert into personal (id_personal, nombre, cargo) values (_id, _nom, _car);
end //

create procedure sp_leer_personal(in _id int)
begin
    select * from personal where id_personal = _id;
end //

create procedure sp_actualizar_personal(in _id int, in _nom varchar(100), in _car varchar(50))
begin
    update personal set nombre = _nom, cargo = _car where id_personal = _id;
end //

create procedure sp_eliminar_personal(in _id int)
begin
    delete from personal where id_personal = _id;
end //

-- 3. procedimientos crud para impacto_trafico

create procedure sp_crear_impacto(in _id int, in _zona varchar(100), in _red decimal(5,2))
begin
    insert into impacto_trafico (id_impacto, zona, reduccion_trafico_porcentaje) values (_id, _zona, _red);
end //

create procedure sp_leer_impacto(in _id int)
begin
    select * from impacto_trafico where id_impacto = _id;
end //

create procedure sp_actualizar_impacto(in _id int, in _zona varchar(100), in _red decimal(5,2))
begin
    update impacto_trafico set zona = _zona, reduccion_trafico_porcentaje = _red where id_impacto = _id;
end //

create procedure sp_eliminar_impacto(in _id int)
begin
    delete from impacto_trafico where id_impacto = _id;
end //

-- 4. procedimientos crud para horarios

create procedure sp_crear_horario(in _id int, in _salida time, in _llegada time, in _tren int)
begin
    insert into horarios (id_horario, hora_salida, hora_llegada, id_tren) values (_id, _salida, _llegada, _tren);
end //

create procedure sp_leer_horario(in _id int)
begin
    select * from horarios where id_horario = _id;
end //

create procedure sp_actualizar_horario(in _id int, in _salida time, in _llegada time, in _tren int)
begin
    update horarios set hora_salida = _salida, hora_llegada = _llegada, id_tren = _tren where id_horario = _id;
end //

create procedure sp_eliminar_horario(in _id int)
begin
    delete from horarios where id_horario = _id;
end //

-- 5. procedimientos crud para mantenimiento

create procedure sp_crear_mantenimiento(in _id int, in _fec date, in _desc text, in _tren int)
begin
    insert into mantenimiento (id_mantenimiento, fecha, descripcion, id_tren) values (_id, _fec, _desc, _tren);
end //

create procedure sp_leer_mantenimiento(in _id int)
begin
    select * from mantenimiento where id_mantenimiento = _id;
end //

create procedure sp_actualizar_mantenimiento(in _id int, in _fec date, in _desc text, in _tren int)
begin
    update mantenimiento set fecha = _fec, descripcion = _desc, id_tren = _tren where id_mantenimiento = _id;
end //

create procedure sp_eliminar_mantenimiento(in _id int)
begin
    delete from mantenimiento where id_mantenimiento = _id;
end //

delimiter ;

-- Lineas
-- create
DELIMITER //

create procedure sp_crear_linea(in _id int,in _nombre varchar(50),in _color varchar(30),in _longitud decimal(5,2)
)
begin
    insert into Lineas (id_linea, nombre_linea, color, longitud_km) values (_id, _nombre, _color, _longitud);
end //

-- Leer
create procedure sp_leer_linea(in _id int)
begin
    select * from Lineas where id_linea = _id;
end //

-- Actualizar
create procedure sp_actualizar_linea(in _id int,in _nombre varchar(50),in _color varchar(30),in _longitud decimal(5,2)
)
begin
    update Lineas
    set nombre_linea = _nombre,
        color = _color,
        longitud_km = _longitud
    where id_linea = _id;
end //

-- Eliminar
create procedure sp_eliminar_linea(in _id int)
begin
    delete from Lineas where id_linea = _id;
end //

-- Estaciones 
-- create 
create procedure sp_crear_estacion(in _id int,in _nombre varchar(50),in _zona varchar(30),in _id_linea int
)
begin
    insert into Estaciones (id_estacion, nombre, zona, id_linea) values (_id, _nombre, _zona, _id_linea);
end //

-- Leer
create procedure sp_leer_estacion(in _id int)
begin
    select * from Estaciones where id_estacion = _id;
end //

-- Actualizar
create procedure sp_actualizar_estacion(in _id int,in _nombre varchar(50),in _zona varchar(30),in _id_linea int
)
begin
    update Estaciones
    set nombre = _nombre,
        zona = _zona,
        id_linea = _id_linea
    where id_estacion = _id;
end //

-- Eliminar
create procedure sp_eliminar_estacion(in _id int)
begin
    delete from Estaciones where id_estacion = _id;
end //


-- agregue procedimientos de trenes y conductores

delimiter //

create procedure sp_crear_tren(
    in _id int,
    in _modelo varchar(50),
    in _capacidad int,
    in _estado varchar(30)
)
begin
    insert into trenes(id_tren, modelo, capacidad_pasajeros, estado)
    values(_id, _modelo, _capacidad, _estado);
end //

create procedure sp_leer_tren(in _id int)
begin
    select * from trenes where id_tren = _id;
end //

create procedure sp_actualizar_tren(
    in _id int,
    in _modelo varchar(50),
    in _capacidad int,
    in _estado varchar(30)
)
begin
    update trenes
    set modelo = _modelo,
        capacidad_pasajeros = _capacidad,
        estado = _estado
    where id_tren = _id;
end //

create procedure sp_eliminar_tren(in _id int)
begin
    delete from trenes where id_tren = _id;
end //

delimiter ;


delimiter //

create procedure sp_crear_conductor(
    in _id int,
    in _nombre varchar(100),
    in _licencia varchar(50),
    in _exp int
)
begin
    insert into conductores(id_conductor, nombre, licencia, anos_experiencia)
    values(_id, _nombre, _licencia, _exp);
end //

create procedure sp_leer_conductor(in _id int)
begin
    select * from conductores where id_conductor = _id;
end //

create procedure sp_actualizar_conductor(
    in _id int,
    in _nombre varchar(100),
    in _licencia varchar(50),
    in _exp int
)
begin
    update conductores
    set nombre = _nombre,
        licencia = _licencia,
        anios_experiencia = _exp
    where id_conductor = _id;
end //

create procedure sp_eliminar_conductor(in _id int)
begin
    delete from conductores where id_conductor = _id;
end //

delimiter ;
