/*Consulta 1.1: Buscar ciudadanos con datos incompletos
Propósito: Identificar cuentas de usuario registrado como ciudadano que no han ingresado su dirección fisica para campañas de actualización de datos.
*/
db.Personas.find(
    { "rol": "Ciudadano", 
        "direccion": { "$exists": false } }, 
    { "nombre": 1, "apellido": 1, "DNI": 1 }
)

/*
Consulta 1.2: Buscar reportes de urgencia alta
Propósito: Mostrar los titulo de las indicencias mas criticas “Alta ” ordenadas de la mas antigua a la más reciente
*/

db.Reportes.find(
    { "nivelUrgencia": "Alta" }, 
    { "titulo": 1 }
).sort({ "fechaReporte": 1 });


