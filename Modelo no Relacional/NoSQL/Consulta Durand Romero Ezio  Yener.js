/*
Consulta 2.1: Total de usuarios por cada rol 
Propósito: Agrupar a los usuarios según su rol (ciudadano, técnico, administrador) para contar cuantos hay de cada uno
*/
db.Personas.aggregate([
    { "$group": { "_id": "$rol", 
    "totalUsuarios": { "$sum": 1 }}
     }
]);

/*
Consulta 2.2: Contar reportes por nivel de urgencia 
Propósito: Obtener mátricas rápidas para el tablero del administrador que muestren cuántas incidencias de prioridad “Alta” requieren atención inmediata.
*/

db.Reportes.aggregate([
    { "$group": { "_id": "$nivelUrgencia", 
    "total": { "$sum": 1 } }
     }
]);
