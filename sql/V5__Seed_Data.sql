-- 1. Insertar Rangos
INSERT INTO rangos_investigador (nombre_rango) VALUES
('Investigador Junior'),
('Investigador Senior'),
('Director de Proyecto'),
('Asistente de Laboratorio'),
('Investigador Asociado');

-- 2. Insertar Investigadores (id_rango 3 es Director)
INSERT INTO investigadores (nombres, apellidos, id_rango) VALUES
('Ana', 'López', 1),
('Carlos', 'Méndez', 2),
('Elena', 'Torres', 3), 
('Roberto', 'Gómez', 4),
('Sofía', 'Ruiz', 5);

-- 3. Insertar Laboratorios (niveles 1 a 4)
INSERT INTO laboratorios (nombre, nivel_bioseguridad, capacidad) VALUES
('Lab Genómica Básica', 1, 20),
('Lab Biología Celular', 2, 15),
('Lab Virología Avanzada', 3, 10),
('Lab Patógenos Críticos', 4, 5),
('Lab Análisis Bioquímico', 2, 12);

-- 4. Insertar Equipos
INSERT INTO equipos (nombre, estado, id_laboratorio, ultima_revision) VALUES
('Microscopio Electrónico', 'Operativo', 1, '2026-03-15'),
('Centrífuga de Alta Velocidad', 'Operativo', 2, '2026-04-01'),
('Secuenciador de ADN', 'En Mantenimiento', 3, '2026-04-10'),
('Cabina de Bioseguridad Clase III', 'Operativo', 4, '2026-02-28'),
('Espectrómetro de Masas', 'Operativo', 5, '2026-01-20');

-- 5. Insertar Reservas (Esto activará el trigger de auditoría)
-- Nota: La reserva en el Lab 4 (id=4) la hace Elena (id=3), que es Director.
INSERT INTO reservas (id_investigador, id_laboratorio, fecha_inicio, fecha_fin) VALUES
(1, 1, '2026-05-01 08:00:00', '2026-05-01 12:00:00'),
(2, 2, '2026-05-02 10:00:00', '2026-05-02 14:00:00'),
(3, 4, '2026-05-03 09:00:00', '2026-05-03 18:00:00'),
(4, 5, '2026-05-04 13:00:00', '2026-05-04 16:00:00'),
(5, 3, '2026-05-05 07:00:00', '2026-05-05 11:00:00');

-- 6. Insertar Reserva_Equipos
INSERT INTO reserva_equipos (id_reserva, id_equipo) VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 5),
(5, 3);