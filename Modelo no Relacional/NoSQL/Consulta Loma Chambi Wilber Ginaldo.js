/*
Consulta 4.1: Buscar técnicos disponibles en un área específica 
Propósito: Encontrar personal técnico asignado al area que se encuentre como disponible para asignarle un caso urgente.
*/

db.Personas.find({ 
    "rol": "Tecnico", 
   "disponibilidad": true, 
    "area.idArea": 2 
});

/*
Consulta 4.2: Contar cuantos resportes ha realizado un cuidadano especifico
Propósito: Evaluar el nivel de participación o identificar reportes masivos de un mismo usuario utilizando su número de DNI
*/

db.Reportes.countDocuments({ 
    "ciudadano.dni": "71234567" 
});
