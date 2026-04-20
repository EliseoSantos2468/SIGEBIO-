-- V1_Initial_Schema.sql

-- Tabla de catálogo para la jerarquía de investigadores
CREATE TABLE rangos_investigador (
    id_rango SERIAL PRIMARY KEY,
    nombre_rango VARCHAR(50) NOT NULL
);

-- Tabla principal de investigadores
CREATE TABLE investigadores (
    id_investigador SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    id_rango INT NOT NULL
);

-- Tabla de laboratorios
CREATE TABLE laboratorios (
    id_laboratorio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

-- Tabla de equipos
CREATE TABLE equipos (
    id_equipo SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    id_laboratorio INT NOT NULL
);

-- Tabla de reservas (Cabecera)
CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_investigador INT NOT NULL,
    id_laboratorio INT NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL
);

-- Tabla intermedia para asociar equipos específicos a una reserva
CREATE TABLE reserva_equipos (
    id_reserva INT NOT NULL,
    id_equipo INT NOT NULL,
    PRIMARY KEY (id_reserva, id_equipo)
);

-- Tabla para el registro de auditoría
CREATE TABLE log_auditoria (
    id_log SERIAL PRIMARY KEY,
    tabla_afectada VARCHAR(50) NOT NULL,
    accion VARCHAR(20) NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);