/*
Vilchez Gamarra Jhostyn Amir
Consulta 1.1:
Identificación de zonas críticas por volumen de alertas

Propósito: Listar las municipalidades (distritos) que acumulan un volumen total de 
reportes superior al promedio de quejas de toda la provincia, permitiendo priorizar 
presupuestos de emergencia.

Componentes: JOIN, GROUP BY, HAVING, SUBCONSULTA.
*/

SELECT	m.nombre AS [Municipalidad],
		m.distrito AS [Distrito],
		COUNT(r.id_reporte) AS [Total_reporte]
FROM Reporte r
INNER JOIN Municipalidad m
	ON r.id_municipalidad = m.id_municipalidad
GROUP BY m.nombre, m.distrito
HAVING COUNT(r.id_reporte) > (
	SELECT AVG(aux.Total)
	FROM (
		SELECT COUNT(id_reporte) AS [Total]
		FROM Reporte
		GROUP BY id_municipalidad
	) AS aux
);
GO


/*
Consulta 1.2: Procedimiento Almacenado para asignación segura de operarios

Propósito: Registrar una orden de trabajo en la tabla transaccional verificando previamente 
que el operario técnico se encuentre en estado disponible y envolviendo el proceso en seguridad 
transaccional.

Componentes: STORED PROCEDURE, IF-ELSE, TRY-CATCH.
*/

CREATE OR ALTER PROCEDURE sp_AsignarTecnicoSeguro
	@id_reporte INT,
	@id_tecnico INT,
	@id_admin INT,
	@fecha_fin DATE,
	@instrucciones NVARCHAR(1000)
AS
BEGIN
	BEGIN TRY
		IF EXISTS (
			SELECT 1
			FROM Personal_Tecnico
			WHERE id_persona = @id_tecnico
				AND disponibilidad = 1
		)
		BEGIN
			BEGIN TRANSACTION;
				INSERT INTO Asignacion_Trabajo (id_reporte, id_persona_tecnico, id_persona_admin, fecha_asignacion, fecha_inicio, fecha_fin, instrucciones)
				VALUES
				(@id_reporte, @id_tecnico, @id_admin, GETDATE(), GETDATE(), @fecha_fin, @instrucciones)

				UPDATE Personal_Tecnico
				SET disponibilidad = 0
				WHERE id_persona = @id_tecnico;
			COMMIT TRANSACTION;
			PRINT 'Asignacion realizada con exito y tecnico marcado como ocupado.'
		END
		ELSE
		BEGIN
			PRINT 'Alerta: El tecnico seleccionado no existe o ya esta asignado a otra obra.'
		END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		PRINT 'Excepcion detectada en la transaccion: ' + ERROR_MESSAGE();
	END CATCH
END;
GO


/*
Consulta 1.3: Análisis de gravedad e impacto multimedia

Propósito: Encontrar aquellos reportes con nivel de urgencia 'alta' que contienen 
un número de evidencias fotográficas o de video superior al promedio general del sistema.  

Componentes: JOIN, GROUP BY, HAVING, SUBCONSULTAS.  
*/

SELECT	r.id_reporte,
		r.titulo,
		COUNT(em.id_evidencia) AS [Total Evidencias]
FROM Reporte r
INNER JOIN Evidencia_Multimedia em
	ON r.id_reporte = em.id_reporte
WHERE r.nivel_urgencia LIKE 'alta'
GROUP BY r.id_reporte, r.titulo
HAVING COUNT(em.id_evidencia) > (
	SELECT AVG(aux.Cantidad)
	FROM (
		SELECT COUNT(id_evidencia) AS [Cantidad]
		FROM Evidencia_Multimedia
		GROUP BY id_reporte
	) AS aux

);
GO