/*
Consulta 3.1: Extracción analítica de incidencias críticas por jurisdicción

Propósito: Obtener las quejas catalogadas de urgencia 'alta' de un municipio específico, 
discriminando que pertenezcan únicamente a subcategorías derivadas (ramas hijas).  

Componentes: STORED PROCEDURE, IF-ELSE, Subquery, TRY-CATCH.  SQL
*/
CREATE OR ALTER PROCEDURE sp_ObtenerReportesCriticosPorMunicipio
    @id_municipalidad INT
AS
BEGIN
    BEGIN TRY
        IF EXISTS (
            SELECT 1 
            FROM Municipalidad 
            WHERE id_municipalidad = @id_municipalidad
        )
        BEGIN
            SELECT  r.id_reporte, 
                    r.titulo, 
                    r.nivel_urgencia, 
                    c.nombre_categoria
            FROM Reporte r
            INNER JOIN Categoria_incidente c 
                ON r.id_categoria = c.id_categoria
            WHERE r.id_municipalidad = @id_municipalidad 
              AND r.nivel_urgencia LIKE 'alta'
              AND r.id_categoria IN (
                  SELECT id_categoria 
                  FROM Categoria_incidente 
                  WHERE id_categoria_padre IS NOT NULL
              );
        END
        ELSE
        BEGIN
            PRINT 'Alerta: La municipalidad especificada no existe en los registros.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'Excepción controlada en ejecución: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

/*
Consulta 3.2: Identificación de personal con alta sobrecarga laboral

Propósito: Listar a los operarios técnicos que han recibido una asignación 
de órdenes de trabajo superior a la media de asignaciones de todo el equipo técnico de la plataforma.  

Componentes: INNER JOIN, GROUP BY, HAVING, Subquery.  SQL
*/
SELECT  p.nombre,
        p.apellido, 
        COUNT(at.id_asignacion) AS [Total_Trabajos]
FROM Asignacion_Trabajo at
INNER JOIN Persona p 
    ON at.id_persona_tecnico = p.id_persona
GROUP BY p.nombre, p.apellido
HAVING COUNT(at.id_asignacion) > (
    SELECT AVG(aux.Total)
    FROM (
        SELECT COUNT(id_asignacion) AS [Total] 
        FROM Asignacion_Trabajo 
        GROUP BY id_persona_tecnico
    ) AS aux
);
GO

/*
Consulta 3.3: Rastreo de auditoría cronológica en alertas de alta urgencia

Propósito: Listar el historial de transiciones de estados detallando los 
nombres de los flujos de cambio para reportes de urgencia extrema.  

Componentes: Subquery IN combinada con Joins jerárquicos.  SQL
*/

SELECT  her.id_reporte, 
        e_ant.nombre AS [Estado Anterior], 
        e_nue.nombre AS [Estado_Nuevo], 
        her.fecha_cambio
FROM Historial_Estado_Reporte her
INNER JOIN Estado_Reporte e_ant 
    ON her.id_estado_anterior = e_ant.id_estado_reporte
INNER JOIN Estado_Reporte e_nue 
    ON her.id_estado_nuevo = e_nue.id_estado_reporte
WHERE her.id_reporte IN (
    SELECT id_reporte 
    FROM Reporte 
    WHERE nivel_urgencia LIKE 'alta'
);
GO