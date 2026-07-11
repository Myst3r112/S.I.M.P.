USE AlertCity;
GO

-- 1. Catálogo de Estados obligatorios (Restricción CHECK)
INSERT INTO Estado_Reporte (nombre) 
VALUES 
('Pendiente'), 
('En Proceso'), 
('Finalizado'), 
('Observado');
GO

-- 2. Registro de Municipalidades de Lima Metropolitana
INSERT INTO Municipalidad (nombre, distrito, direccion, ruc) 
VALUES 
('Municipalidad Distrital de Comas', 'Comas', 'Av. 22 de Agosto km 11', '20131313131'),
('Municipalidad de Los Olivos', 'Los Olivos', 'Av. Carlos Izaguirre 815', '20151515151'),
('Municipalidad de San Martín de Porres', 'San Martín de Porres', 'Av. Alfredo Mendiola 169', '20171717171');
GO

-- 3. Catálogo de Especialidades Técnicas para Obras
INSERT INTO Especialidad (nombre_especialidad) 
VALUES 
('Albañilería y Pavimentación'),
('Electricidad e Iluminación Pública'),
('Gasfitería y Redes de Agua'),
('Jardinería y Paisajismo Urbano'),
('Soldadura Estructural');
GO

-- 4. Registro Maestro de Personas (Ciudadanos, Administradores y Técnicos)
INSERT INTO Persona (dni, nombre, apellido, direccion, fecha_registro) 
VALUES 
-- Ciudadanos
('71234567', 'Juan Carlos', 'Pérez Quispe', 'Av. Túpac Amaru 1420 - Comas', '2026-01-10'),
('45678912', 'María Elena', 'Mendoza Flores', 'Jr. Las Gemas 324 - Los Olivos', '2026-01-15'),
('61029384', 'Carlos Alberto', 'Sánchez Ramos', 'Av. Perú 3510 - SMP', '2026-02-01'),
('73948102', 'Ana Lucía', 'Gonzales Castro', 'Av. Universitaria 450 - Comas', '2026-02-12'),
-- Personal Administrativo (IDs generados: 5 y 6)
('10293847', 'Ricardo', 'Palacios Vera', 'Urb. El Retablo - Comas', '2026-01-02'),
('40596812', 'Sofía Lorena', 'Benites Ruiz', 'Av. Antúnez de Mayolo - Los Olivos', '2026-01-05'),
-- Personal Técnico (IDs generados: 7 al 10)
('09384756', 'Pedro Pablo', 'Guerrero Soto', 'Jr. Libertad 125 - Comas', '2026-01-03'),
('29384102', 'Jorge Luis', 'Chávez Huamán', 'Av. Canta Callao - SMP', '2026-01-04'),
('47382910', 'Manuel Antonio', 'Rojas Torres', 'Calle Los Jazmines 112 - Los Olivos', '2026-01-06'),
('70192834', 'César Augusto', 'Villanueva Díaz', 'Av. Central 780 - Comas', '2026-01-08');
GO

-- 5. Direcciones Geográficas de Incidentes (Ubicación_Reporte)
INSERT INTO Ubicacion_Reporte (direccion, latitud, longitud) VALUES 
('Av. Túpac Amaru cruce con Av. Puno, Comas', '-11.9342', '-77.0524'),
('Jr. Mercurio 415, Urb. Mercurio, Los Olivos', '-11.9621', '-77.0689'),
('Av. Tomás Valle frente al mercado Central, SMP', '-11.9912', '-77.0610'),
('Parque Central de la Urb. San Agustín, Comas', '-11.9215', '-77.0412'),
('Av. Las Palmeras cuadra 12, Los Olivos', '-11.9705', '-77.0734');
GO

-- 6. Categorías de Incidentes (Relación recursiva Padre/Hijo)
-- Categorias Padre
INSERT INTO Categoria_incidente (id_categoria_padre, nombre_categoria, descripcion) 
VALUES 
(NULL, 'Vías y Pavimentos', 'Daños estructurales en pistas, veredas y gibas'),
(NULL, 'Alumbrado y Electricidad', 'Fallas en postes de luz, semáforos y cables expuestos'),
(NULL, 'Ornato y Áreas Verdes', 'Problemas en parques, árboles caídos y basura acumulada');
GO
-- Categorias Hijo
INSERT INTO Categoria_incidente (id_categoria_padre, nombre_categoria, descripcion) 
VALUES 
(1, 'Baches y Socavones', 'Huecos profundos en la capa asfáltica que dañan vehículos'),
(1, 'Veredas Rotas', 'Roturas en concreto que impiden el paso peatonal seguro'),
(2, 'Postes Apagados', 'Luminarias públicas que no encienden de noche'),
(3, 'Parques Desatendidos', 'Falta de regado, maleza alta o juegos recreativos rotos');
GO

-- 7. Teléfonos y Correos de Personas
INSERT INTO Telefono_Persona (id_persona, numero) 
VALUES 
(1, '991234567'), 
(2, '998765432'), 
(5, '945123789'), 
(7, '912345678'), 
(8, '934567123');
GO

INSERT INTO Correo_Persona (id_persona, correo) 
VALUES 
(1, 'juan.perez@gmail.com'), 
(2, 'maria.mendoza@outlook.com'), 
(5, 'rpalacios@comas.gob.pe'), 
(7, 'pguerrero_tecnico@hotmail.com');
GO

-- 8. Teléfonos y Correos de Municipalidades
INSERT INTO Telefono_Municipalidad (id_municipalidad, numero) 
VALUES 
(1, '(01) 542-1234'), 
(2, '(01) 614-1212'), 
(3, '(01) 311-5000');
GO
INSERT INTO Correo_Municipalidad (id_municipalidad, correo) 
VALUES 
(1, 'consultas@municomas.gob.pe'), 
(2, 'atencion@munilosolivos.gob.pe'), 
(3, 'mesadepartes@munismp.gob.pe');
GO

-- 9. Áreas o Gerencias Municipales
INSERT INTO Area_Municipal (id_municipalidad, nombre_area, tipo_area) 
VALUES 
(1, 'Gerencia de Obras Públicas e Infraestructura', 'Operativa Operaciones'),
(1, 'Subgerencia de Limpieza Pública y Ornato', 'Mantenimiento'),
(2, 'Gerencia de Desarrollo Urbano', 'Operativa Operaciones'),
(3, 'Dirección de Servicios Municipales', 'Mantenimiento');
GO

-- Rol: Ciudadano
INSERT INTO Ciudadano (id_persona) 
VALUES 
(1), 
(2), 
(3), 
(4);
GO

-- Rol: Ciudadano
INSERT INTO Personal_Administrativo (id_persona, id_area) 
VALUES 
(5, 1), -- Ricardo Palacios en Obras de Comas
(6, 3); -- Sofía Benites en Desarrollo Urbano de Los Olivos

-- Rol: Personal Técnico
INSERT INTO Personal_Tecnico (id_persona, disponibilidad, id_area) 
VALUES 
(7, 1, 1),  -- Pedro Guerrero (Disponible) - Obras Comas
(8, 1, 4),  -- Jorge Chávez (Disponible) - Servicios SMP
(9, 0, 3),  -- Manuel Rojas (Ocupado/No disp.) - Urb. Los Olivos
(10, 1, 2); -- César Villanueva (Disponible) - Ornato Comas

-- Técnico y sus Especialidades (M:N)
INSERT INTO Tecnico_Especialidad (id_persona_tecnico, id_especialidad) 
VALUES 
(7, 1),  -- Pedro es experto en Albañilería
(7, 5),  -- Pedro también sabe de Soldadura
(8, 3),  -- Jorge es especialista en Gasfitería
(9, 2),  -- Manuel domina Electricidad e Iluminación
(10, 4); -- César domina Jardinería y Paisajismo

-- Registro de Reportes Vecinales (Incidentes)
INSERT INTO Reporte (id_categoria, id_persona_ciudadano, id_municipalidad, id_ubicacion, id_estado_reporte, titulo, descripcion, nivel_urgencia, es_anonimo, fecha_reporte) 
VALUES 
(4, 1, 1, 1, 1, 'Mega bache destruye neumáticos', 'Hay un hueco enorme en el cruce de las avenidas, los autos frenan de golpe y ya provocó dos choques leves.', 'alta', 0, '2026-06-15'),
(6, 2, 2, 2, 2, 'Poste con luz parpadeante y cables sueltos', 'Frente al inmueble 415 la bombilla pública está averiada y cuelga un cable de baja tensión hacia la vereda.', 'alta', 0, '2026-06-18'),
(5, 3, 3, 3, 4, 'Vereda destruida por raíces de árbol', 'La vereda del frente comercial está totalmente levantada, los adultos mayores se tropiezan constantemente.', 'media', 1, '2026-06-20'),
(7, 4, 1, 4, 1, 'Juegos infantiles oxidados y rotos', 'Los columpios del parque San Agustín tienen las cadenas rotas y fierros filosos expuestos, peligro para los niños.', 'media', 0, '2026-06-22'),
(4, 1, 2, 5, 3, 'Hundimiento del asfalto en vía principal', 'Pequeño hundimiento que se está ensanchando rápido debido al paso de buses de transporte público.', 'baja', 0, '2026-06-23');

-- Auditoría Interna: Historial de Estados de los Reportes
INSERT INTO Historial_Estado_Reporte (id_reporte, id_estado_anterior, id_estado_nuevo, fecha_cambio) 
VALUES 
(2, 1, 2, '2026-06-19 09:30:00'), 
(3, 1, 4, '2026-06-21 14:15:00'), 
(5, 1, 2, '2026-06-24 08:00:00'), 
(5, 2, 3, '2026-06-26 17:45:00'); 
GO

-- Carga de Evidencias Multimedia
INSERT INTO Evidencia_Multimedia (id_reporte, tipo_archivo, url_archivo, fecha_carga) 
VALUES 
(1, 'Foto', 'https://storage.alertcity.pe/evidencias/reporte1_foto1.jpg', '2026-06-15 10:05:00'),
(1, 'Video', 'https://storage.alertcity.pe/evidencias/reporte1_video.mp4', '2026-06-15 10:06:22'),
(2, 'Foto', 'https://storage.alertcity.pe/evidencias/reporte2_poste.jpg', '2026-06-18 23:15:00'),
(3, 'Foto', 'https://storage.alertcity.pe/evidencias/reporte3_vereda.jpg', '2026-06-20 12:40:00');
GO

-- Registro Transaccional: Asignaciones de Órdenes de Trabajo
INSERT INTO Asignacion_Trabajo (id_reporte, id_persona_tecnico, id_persona_admin, fecha_asignacion, fecha_inicio, fecha_fin, instrucciones) 
VALUES 
(2, 9, 6, '2026-06-19', '2026-06-19', '2026-06-21', 'Aislar el cable expuesto con cinta vulcanizante y reemplazar el bloque de luminaria LED de 150W.'),
(5, 7, 5, '2026-06-24', '2026-06-24', '2026-06-26', 'Rellenar con afirmado y aplicar la capa de mezcla asfáltica en frío. Compactar adecuadamente.');
GO

-- 18. Historial de Notificaciones Enviadas a los Ciudadanos
INSERT INTO Notificacion (id_reporte, id_persona, mensaje, fecha_envio) 
VALUES 
(1, 1, 'Estimado vecino, su reporte de Bache ha sido recibido con éxito por el municipio.', '2026-06-15 10:07:00'),
(2, 2, 'Buenas tardes, la cuadrilla técnica ha sido enviada a reparar el poste de luz reportado.', '2026-06-19 09:35:00'),
(5, 1, '¡Buenas noticias! La reparación del hundimiento de asfalto ha sido culminada.', '2026-06-26 17:50:00');
GO