/*
Durand Romero Ezio Yener
Consulta 2.1: Categorías de incidentes con demandas atípicas

Propósito: Identificar cuáles son las categorías específicas de incidentes que registran 
una cantidad de quejas vecinales por encima del promedio global de la plataforma para 
coordinar mantenimientos preventivos.  

Componentes: GROUP BY, HAVING, Subquery.  
*/

SELECT	ci.nombre_categoria,
		COUNT(r.id_reporte) AS [Total Quejas]
FROM Reporte r
INNER JOIN Categoria_incidente ci
	ON r.id_categoria = ci.id_categoria
GROUP BY ci.nombre_categoria
HAVING COUNT(r.id_reporte) > (
	SELECT AVG(aux.Conteo)
	FROM (
		SELECT COUNT(id_reporte) AS [Conteo]
		FROM Reporte
		GROUP BY id_categoria
	) AS aux
);
GO

/*
Consulta 2.2: Modificación controlada de contactos institucionales

Propósito: Procedimiento administrativo que actualiza el correo electrónico de un usuario 
asegurando que la persona exista y que el nuevo correo electrónico no se duplique en el sistema.  

Componentes: STORED PROCEDURE, IF-ELSE, TRY-CATCH
*/
CREATE OR ALTER PROCEDURE sp_ActualizarCorreoPersona
	@id_persona INT,
	@nuevo_correo NVARCHAR(100)
AS
BEGIN
	BEGIN TRY
		IF EXISTS (
			SELECT 1
			FROM Persona
			WHERE id_persona = @id_persona
		)
		BEGIN
			IF NOT EXISTS (
				SELECT 1
				FROM Correo_Persona
				WHERE correo = @nuevo_correo
			)
			BEGIN
				UPDATE Correo_Persona
				SET correo = @nuevo_correo
				WHERE id_persona = @id_persona;
			END
		END
		ELSE
		BEGIN
			PRINT 'Error: La persona no existe en la base de datos'
		END
	END TRY
	BEGIN CATCH
		PRINT 'Falla detectada en la ejecucion' + ERROR_MESSAGE();
	END CATCH
END;
GO

/*
Consulta 2.3: Fiscalización de alertas desatendidas en macro-entidades

Propósito: Extraer los reportes que permanecen en estado 'Pendiente' pertenecientes 
de manera exclusiva a municipalidades cuyo RUC institucional empiece con el prefijo 
comercial '20'.

Componentes: Subquery condicional estructurada.  
*/
SELECT	r.id_reporte,
		r.titulo,
		r.nivel_urgencia,
		r.fecha_reporte
FROM Reporte r
WHERE r.id_estado_reporte = 1
	AND r.id_municipalidad IN (
		SELECT id_municipalidad
		FROM Municipalidad
		WHERE ruc LIKE '20%'
	);