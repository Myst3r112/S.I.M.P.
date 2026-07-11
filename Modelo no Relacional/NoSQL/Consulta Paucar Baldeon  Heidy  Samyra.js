/*
Consulta 5.1: Reportes observados con evidencias 
Propósito: Listar los reportes devueltos “Observados” que ya cuentan con fotos y videos de prueba, ordenados por fecha ascendente
*/

db.Reportes.find({ 
    "estadoActual": "Observado", 
    "evidencias.0": { "$exists": true } 
}).sort({ "fechaReporte": 1 });

/*
Consulta 5.2: Cantidad de resportes por estado
Propósito: Agrupar y contar cuántas incidencias existen en cada estado actual del sistema
*/

db.Reportes.aggregate([
    { "$group": { "_id": "$estadoActual", 
      "total": { "$sum": 1 } } 
    }
]);
