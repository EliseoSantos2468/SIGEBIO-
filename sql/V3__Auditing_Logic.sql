-- Función PL/pgSQL para validar el rango del investigador
CREATE OR REPLACE FUNCTION verificar_rango_laboratorio()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_bioseguridad INT;
    v_nombre_rango VARCHAR(50);
BEGIN
    -- Obtener el nivel de bioseguridad del laboratorio solicitado
    SELECT nivel_bioseguridad INTO v_nivel_bioseguridad
    FROM laboratorios
    WHERE id_laboratorio = NEW.id_laboratorio;

    -- Si el laboratorio es nivel 4, verificamos el rango
    IF v_nivel_bioseguridad = 4 THEN
        SELECT ri.nombre_rango INTO v_nombre_rango
        FROM investigadores i
        JOIN rangos_investigador ri ON i.id_rango = ri.id_rango
        WHERE i.id_investigador = NEW.id_investigador;

        -- Si el rango no contiene la palabra 'Director', se bloquea la transacción
        IF v_nombre_rango NOT LIKE '%Director%' THEN
            RAISE EXCEPTION 'Regla de Negocio: Los laboratorios de bioseguridad nivel 4 solo pueden ser reservados por investigadores de rango Director.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que se dispara 
CREATE TRIGGER trg_verificar_reserva_lab
BEFORE INSERT OR UPDATE ON reservas
FOR EACH ROW
EXECUTE FUNCTION verificar_rango_laboratorio();

-- Función PL/pgSQL para poblar la tabla log_auditoria
CREATE OR REPLACE FUNCTION auditar_nueva_reserva()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_auditoria (tabla_afectada, accion, usuario, fecha_hora)
    VALUES ('reservas', 'INSERT', CURRENT_USER, CURRENT_TIMESTAMP);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que se dispara automáticamente después de cada inserción en reservas
CREATE TRIGGER trg_auditoria_reservas
AFTER INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION auditar_nueva_reserva();