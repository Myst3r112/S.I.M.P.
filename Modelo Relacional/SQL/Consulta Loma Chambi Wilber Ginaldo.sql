/*
Loma Chambi Wilber Ginaldo

Consulta 4.1: Trigger histórico automatizado para auditoría de trazabilidad urbana

Propósito: Capturar de forma automática cualquier variación en el estado de un reporte e 
insertarlo en la tabla histórica, blindando la transparencia ante auditorías gubernamentales.  

Componentes: TRIGGER, tablas del sistema Inserted y Deleted, TRY-CATCH
*/
CREATE OR ALTER TRIGGER tr_Auditoria_Cambio_Estado
ON Reporte
AFTER UPDATE
AS
BEGIN
    BEGIN TRY
        IF UPDATE(id_estado_reporte)
        BEGIN
            INSERT INTO Historial_Estado_Reporte (id_reporte, id_estado_anterior, id_estado_nuevo, fecha_cambio)
            SELECT 
                i.id_reporte,
                d.id_estado_reporte,
                i.id_estado_reporte,
                GETDATE()
            FROM Inserted i
            INNER JOIN Deleted d 
                ON i.id_reporte = d.id_reporte
            WHERE i.id_estado_reporte <> d.id_estado_reporte;
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error en la ejecución automática del Trigger histórico: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

/*
Consulta 4.2: Ciudadanos recurrentes en quejas de infraestructura vial

Propósito: Listar a los vecinos que reportan baches y socavones en una cantidad 
igual o superior al promedio de alertas viales registradas por ciudadano.

Componentes: GROUP BY, HAVING, Subquery.
*/
SELECT  p.nombre, 
        p.apellido, 
        COUNT(r.id_reporte) AS [Alertas_Emitidas]
FROM Reporte r
INNER JOIN Persona p 
    ON r.id_persona_ciudadano = p.id_persona
WHERE r.id_categoria = 4
GROUP BY p.nombre, p.apellido
HAVING COUNT(r.id_reporte) >= (
    SELECT AVG(aux.Cantidad)
    FROM (
        SELECT COUNT(id_reporte) AS [Cantidad] 
        FROM Reporte 
        WHERE id_categoria = 4 
        GROUP BY id_persona_ciudadano
    ) AS aux
);
GO

/*
Consulta 4.3: Modificación del estado operativo de técnicos

Propósito: Cambiar la disponibilidad de un operario técnico de forma directa y controlada 
ante solicitudes de descanso o licencias médicas.

Componentes: STORED PROCEDURE, IF-ELSE, TRY-CATCH.
*/
CREATE OR ALTER PROCEDURE sp_Modificar_Disponibilidad_Tecnico
    @id_tecnico INT,
    @nueva_disponibilidad BIT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (
            SELECT 1 
            FROM Personal_Tecnico 
            WHERE id_persona = @id_tecnico
        )
        BEGIN
            UPDATE Personal_Tecnico 
            SET disponibilidad = @nueva_disponibilidad 
            WHERE id_persona = @id_tecnico;
            
            PRINT 'Disponibilidad de personal técnico actualizada correctamente.';
        END
        ELSE
        BEGIN
            PRINT 'Error: El código del técnico ingresado no existe.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Falla al actualizar disponibilidad: ' + ERROR_MESSAGE();
    END CATCH
END;
GO