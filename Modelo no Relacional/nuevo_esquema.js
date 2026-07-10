use('SIMP');

db.createCollection("Personas", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Personas",
            "required": ["nombre", "apellido", "DNI", "fechaRegistro", "rol"],
            "properties": {
                "_id": {
                    "bsonType": "objectId",
                    "description": "Identificador único de la persona"
                },
                "nombre": {
                    "bsonType": "string",
                    "maxLength": 50,
                    "description": "Nombre de la persona"
                },
                "apellido": {
                    "bsonType": "string",
                    "maxLength": 50,
                    "description": "Apellido de la persona"
                },
                "DNI": {
                    "bsonType": "string",
                    "maxLength": 8,
                    "minLength": 8,
                    "description": "Documento Nacional de Identidad (8 caracteres)"
                },
                "direccion": {
                    "bsonType": "string",
                    "maxLength": 150,
                    "description": "Dirección de residencia"
                },
                "fechaRegistro": {
                    "bsonType": "date",
                    "description": "Fecha de registro en el sistema"
                },
                "telefonoPersona": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "string",
                        "maxLength": 15
                    },
                    "description": "Lista de teléfonos de contacto"
                },
                "correoPersona": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "string",
                        "maxLength": 100
                    },
                    "description": "Lista de correos electrónicos"
                },
                "rol": {
                    "bsonType": "string",
                    "enum": ["Ciudadano", "Administrativo", "Tecnico"],
                    "description": "Rol asignado en el sistema"
                },
                "disponibilidad": {
                    "bsonType": "bool",
                    "description": "Disponibilidad del técnico (true/false)"
                },
                "especialidades": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "required": ["idEspecialidad", "nombreEspecialidad"],
                        "properties": {
                            "idEspecialidad": { "bsonType": "objectId" },
                            "nombreEspecialidad": { "bsonType": "string", "maxLength": 50 }
                        },
                        "additionalProperties": false
                    },
                    "description": "Especialidades asignadas al técnico"
                },
                "area": {
                    "bsonType": "object",
                    "required": ["idArea", "nombreArea"],
                    "properties": {
                        "idArea": { "bsonType": "objectId" },
                        "nombreArea": { "bsonType": "string", "maxLength": 50 },
                        "tipoArea": { "bsonType": "string", "maxLength": 50 }
                    },
                    "additionalProperties": false,
                    "description": "Área municipal a la que pertenece"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "strict",
    "validationAction": "error"
});
 
db.createCollection("Reportes", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Reportes",
            "required": ["titulo", "descripcion", "nivelUrgencia", "esAnonimo", "fechaReporte", "estadoActual", "ubicacion"],
            "properties": {
                "_id": {
                    "bsonType": "objectId",
                    "description": "Identificador único del reporte"
                },
                "titulo": {
                    "bsonType": "string",
                    "maxLength": 50,
                    "description": "Título corto de la incidencia"
                },
                "descripcion": {
                    "bsonType": "string",
                    "maxLength": 500,
                    "description": "Detalle explicativo del reporte"
                },
                "nivelUrgencia": {
                    "bsonType": "string",
                    "enum": ["Baja", "Media", "Alta"],
                    "description": "Nivel de urgencia asignado"
                },
                "esAnonimo": {
                    "bsonType": "bool",
                    "description": "Indica si el ciudadano reporta de forma anónima"
                },
                "fechaReporte": {
                    "bsonType": "date",
                    "description": "Fecha de creación del reporte"
                },
                "categoria": {
                    "bsonType": "object",
                    "required": ["idCategoria", "nombreCategoria"],
                    "properties": {
                        "idCategoria": { "bsonType": "objectId" },
                        "nombreCategoria": { "bsonType": "string" }
                    },
                    "additionalProperties": false,
                    "description": "Categoría principal de la incidencia"
                },
                "estadoActual": {
                    "bsonType": "string",
                    "enum": ["Pendiente", "En Proceso", "Finalizado", "Observado"],
                    "description": "Estado actual de atención del reporte"
                },
                "ciudadano": {
                    "bsonType": "object",
                    "required": ["idPersona", "dni"],
                    "properties": {
                        "idPersona": { "bsonType": "objectId" },
                        "dni": { "bsonType": "string", "maxLength": 8, "minLength": 8 },
                        "nombre": { "bsonType": "string" },
                        "apellido": { "bsonType": "string" }
                    },
                    "additionalProperties": false,
                    "description": "Datos básicos del ciudadano que reporta"
                },
                "municipalidad": {
                    "bsonType": "object",
                    "required": ["idMunicipalidad", "nombre"],
                    "properties": {
                        "idMunicipalidad": { "bsonType": "objectId" },
                        "nombre": { "bsonType": "string" }
                    },
                    "additionalProperties": false,
                    "description": "Municipalidad encargada del caso"
                },
                "ubicacion": {
                    "bsonType": "object",
                    "required": ["direccion", "longitud", "latitud"],
                    "properties": {
                        "direccion": { "bsonType": "string", "maxLength": 150 },
                        "longitud": { "bsonType": "double" },
                        "latitud": { "bsonType": "double" }
                    },
                    "additionalProperties": false,
                    "description": "Coordenadas geográficas y dirección de la incidencia"
                },
                "evidencias": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "required": ["tipoArchivo", "urlArchivo", "fechaCarga"],
                        "properties": {
                            "tipoArchivo": { "bsonType": "string", "enum": ["Foto", "Video"] },
                            "urlArchivo": { "bsonType": "string", "maxLength": 150 },
                            "fechaCarga": { "bsonType": "date" }
                        },
                        "additionalProperties": false
                    },
                    "description": "Archivos multimedia adjuntos como prueba"
                },
                "historialEstados": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "required": ["estadoAnterior", "estadoNuevo", "fechaCambio"],
                        "properties": {
                            "estadoAnterior": { "bsonType": "string" },
                            "estadoNuevo": { "bsonType": "string" },
                            "fechaCambio": { "bsonType": "date" }
                        },
                        "additionalProperties": false
                    },
                    "description": "Línea de tiempo de los cambios de estado"
                },
                "asignaciones": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "required": ["idAsignacion", "fechaAsignacion", "fechaInicio"],
                        "properties": {
                            "idAsignacion": { "bsonType": "objectId" },
                            "tecnico": {
                                "bsonType": "object",
                                "properties": { "idPersona": { "bsonType": "objectId" }, "nombre": { "bsonType": "string" } },
                                "additionalProperties": false
                            },
                            "administrador": {
                                "bsonType": "object",
                                "properties": { "idPersona": { "bsonType": "objectId" }, "nombre": { "bsonType": "string" } },
                                "additionalProperties": false
                            },
                            "fechaAsignacion": { "bsonType": "date" },
                            "fechaInicio": { "bsonType": "date" },
                            "fechaFin": { "bsonType": "date" },
                            "instrucciones": { "bsonType": "string", "maxLength": 1000 }
                        },
                        "additionalProperties": false
                    },
                    "description": "Historial de técnicos asignados a resolver el caso"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "strict",
    "validationAction": "error"
});
 
db.createCollection("Municipalidades", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Municipalidades",
            "required": ["nombre", "distrito", "ruc"],
            "properties": {
                "_id": {
                    "bsonType": "objectId",
                    "description": "Identificador único de la municipalidad"
                },
                "nombre": {
                    "bsonType": "string",
                    "maxLength": 50,
                    "description": "Nombre de la entidad municipal"
                },
                "distrito": {
                    "bsonType": "string",
                    "maxLength": 50,
                    "description": "Distrito de jurisdicción"
                },
                "direccion": {
                    "bsonType": "string",
                    "maxLength": 150,
                    "description": "Dirección de la sede central"
                },
                "ruc": {
                    "bsonType": "string",
                    "maxLength": 11,
                    "minLength": 11,
                    "description": "Registro Único de Contribuyentes (11 dígitos)"
                },
                "telefonoMunicipalidad": {
                    "bsonType": "array",
                    "items": { "bsonType": "string", "maxLength": 15 },
                    "description": "Central telefónica"
                },
                "correoMunicipalidad": {
                    "bsonType": "array",
                    "items": { "bsonType": "string", "maxLength": 100 },
                    "description": "Correos institucionales"
                },
                "area": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "required": ["idArea", "nombreArea"],
                        "properties": {
                            "idArea": { "bsonType": "objectId" },
                            "nombreArea": { "bsonType": "string", "maxLength": 50 },
                            "tipoArea": { "bsonType": "string", "maxLength": 50 }
                        },
                        "additionalProperties": false
                    },
                    "description": "Lista de áreas operativas de la municipalidad"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "strict",
    "validationAction": "error"
});
 
db.createCollection("Notificaciones", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Notificaciones",
            "required": ["idReporte", "idPersona", "mensaje", "fechaEnvio", "leido"],
            "properties": {
                "_id": {
                    "bsonType": "objectId",
                    "description": "Identificador único de la notificación"
                },
                "idReporte": {
                    "bsonType": "objectId",
                    "description": "Referencia (Llave foránea) al reporte asociado"
                },
                "idPersona": {
                    "bsonType": "objectId",
                    "description": "Referencia (Llave foránea) al usuario destino"
                },
                "mensaje": {
                    "bsonType": "string",
                    "maxLength": 500,
                    "description": "Contenido del mensaje de alerta"
                },
                "fechaEnvio": {
                    "bsonType": "date",
                    "description": "Fecha y hora de salida del mensaje"
                },
                "leido": {
                    "bsonType": "bool",
                    "description": "Estado de lectura por el usuario (true/false)"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "strict",
    "validationAction": "error"
});
 
db.createCollection("Categorias", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Categorias",
            "required": ["nombreCategoria"],
            "properties": {
                "_id": {
                    "bsonType": "objectId",
                    "description": "Identificador único de la categoría"
                },
                "nombreCategoria": {
                    "bsonType": "string",
                    "maxLength": 50,
                    "description": "Nombre de la categoría principal"
                },
                "descripcion": {
                    "bsonType": "string",
                    "maxLength": 500,
                    "description": "Descripción del tipo de incidencias que engloba"
                },
                "subCategoria": {
                    "bsonType": "array",
                    "items": {
                        "bsonType": "object",
                        "required": ["idCategoria", "nombreCategoria"],
                        "properties": {
                            "idCategoria": { "bsonType": "objectId" },
                            "nombreCategoria": { "bsonType": "string" },
                            "descripcion": { "bsonType": "string" }
                        },
                        "additionalProperties": false
                    },
                    "description": "Subclasificaciones asociadas"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "strict",
    "validationAction": "error"
});