/*
Consulta 3.1: Listar reportes pendientes de una categoría especifica 
Propósito: Filtrar los incidentes que siguen “Pendientes” y que pertenecen a una categoría crítica 
*/

db.Reportes.find({ 
    "estadoActual": "Pendiente", 
    "categoria.idCategoria": 1 
});

/*
Consulta 3.2: Obtener las últimas 5 incidencias registradas
Propósito: Mostrar en la pantalla principal del administrador una lista con los reportes más recientes ingresados en el sistema.
*/

db.Reportes.find()
    .sort({ "fechaReporte": -1 })
    .limit(5);
