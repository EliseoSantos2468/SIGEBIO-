-- V4_Equipment_Maintenance.sql

-- Añadir la columna ultima_revision a la tabla de equipos
ALTER TABLE equipos
ADD COLUMN ultima_revision DATE;