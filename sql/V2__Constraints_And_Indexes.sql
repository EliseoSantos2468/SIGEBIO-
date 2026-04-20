-- V2_Constraints_And_Indexes.sql

-- ==============================================================================
-- 1. RESTRICCIONES DE INTEGRIDAD REFERENCIAL (LLAVES FORÁNEAS)
-- ==============================================================================

ALTER TABLE investigadores
ADD CONSTRAINT fk_investigador_rango 
FOREIGN KEY (id_rango) REFERENCES rangos_investigador(id_rango) 
ON DELETE SET NULL;

ALTER TABLE equipos
ADD CONSTRAINT fk_equipo_laboratorio 
FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id_laboratorio) 
ON DELETE CASCADE;

ALTER TABLE reservas
ADD CONSTRAINT fk_reserva_investigador 
FOREIGN KEY (id_investigador) REFERENCES investigadores(id_investigador) 
ON DELETE CASCADE,
ADD CONSTRAINT fk_reserva_laboratorio 
FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id_laboratorio) 
ON DELETE CASCADE;

ALTER TABLE reserva_equipos
ADD CONSTRAINT fk_reservaequipos_reserva 
FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva) 
ON DELETE CASCADE,
ADD CONSTRAINT fk_reservaequipos_equipo 
FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo) 
ON DELETE CASCADE;


-- ==============================================================================
-- 2. RESTRICCIONES DE DOMINIO (CHECK)
-- ==============================================================================

ALTER TABLE laboratorios
ADD CONSTRAINT chk_nivel_bioseguridad 
CHECK (nivel_bioseguridad BETWEEN 1 AND 4);


-- ==============================================================================
-- 3. ÍNDICES PARA OPTIMIZACIÓN DE CONSULTAS
-- ==============================================================================

CREATE INDEX idx_reservas_fechas ON reservas (fecha_inicio, fecha_fin);

CREATE INDEX idx_reservas_investigador ON reservas (id_investigador);