/*
Paucar Baldeon Heidy Samyra

Consulta 5.1: Proceso de finalización de obras con notificación integrada

Propósito: Realizar el cierre administrativo de un reporte, liberando la disponibilidad 
del operario técnico y disparando atómicamente la notificación informativa para el ciudadano afectado.  

Componentes: STORED PROCEDURE, TRANSACTION, IF-ELSE, TRY-CATCH
*/
CREATE PROCEDURE sp_Finalizar_Reporte_Con_Notificacion
    @id_reporte INT,
    @id_tecnico INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Reporte WHERE id_reporte = @id_reporte AND id_estado_reporte <> 3)
        BEGIN
            BEGIN TRANSACTION;
                UPDATE Reporte 
                SET id_estado_reporte = 3 
                WHERE id_reporte = @id_reporte;
                
                UPDATE Personal_Tecnico 
                SET disponibilidad = 1 
                WHERE id_persona = @id_tecnico;
                
                INSERT INTO Notificacion (id_reporte, id_persona, mensaje, fecha_envio)
                SELECT  @id_reporte, 
                        id_persona_ciudadano, 
                        'Buenas noticias, las obras públicas en la zona de su reporte han finalizado con éxito.', GETDATE()
                FROM Reporte 
                WHERE id_reporte = @id_reporte;
            COMMIT TRANSACTION;
            PRINT 'Proceso culminado: Reporte cerrado, técnico liberado y vecino notificado.';
        END
        ELSE
        BEGIN
            PRINT 'Alerta: El reporte ingresado no existe o ya se encuentra finalizado.';
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
            ROLLBACK TRANSACTION;
        PRINT 'Falla crítica detectada durante el cierre: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

/*
Consulta 5.2: Balance de recursos humanos en gerencias municipales

Propósito: Listar las áreas o gerencias de la municipalidad que cuentan con una cantidad 
de técnicos a su cargo superior al promedio de personal por gerencia del ecosistema.  

Componentes: GROUP BY, HAVING, SUBCONSULTAS.
*/
SELECT  am.nombre_area AS [Gerencia], 
        COUNT(pt.id_persona) AS [Total_Tecnicos_Asignados]
FROM Personal_Tecnico pt
INNER JOIN Area_Municipal am 
    ON pt.id_area = am.id_area
GROUP BY am.nombre_area
HAVING COUNT(pt.id_persona) > (
    SELECT AVG(aux.Cantidad)
    FROM (
        SELECT COUNT(id_persona) AS [Cantidad] 
        FROM Personal_Tecnico 
        GROUP BY id_area
    ) AS aux
);

/*
Consulta 5.3: Control de notificaciones por observaciones de campo

Propósito: Encontrar rápidamente los mensajes de alerta enviados a los teléfonos de 
ciudadanos cuyos reportes fueron clasificados temporalmente en estado 'Observado' 
por el equipo técnico.

Componentes: SUBCONSULTAS IN jerárquica.
*/
SELECT  n.id_notificacion, 
        p.nombre + ' ' + p.apellido AS [Destinatario], 
        n.mensaje, 
        n.fecha_envio
FROM Notificacion n
INNER JOIN Persona p 
    ON n.id_persona = p.id_persona
WHERE n.id_reporte IN (
    SELECT id_reporte 
    FROM Reporte 
    WHERE id_estado_reporte = 4 
);