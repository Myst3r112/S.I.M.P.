use ('SIMP');

db.createCollection("Personas", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Personas",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "idPersona": {
                    "bsonType": "objectId"
                },
                "nombre": {
                    "bsonType": "string",
                    "maxLength": 50
                },
                "apellido": {
                    "bsonType": "string",
                    "maxLength": 50
                },
                "DNI": {
                    "bsonType": "string",
                    "maxLength": 8,
                    "minLength": 8
                },
                "direccion": {
                    "bsonType": "string",
                    "maxLength": 150
                },
                "fechaRegistro": {
                    "bsonType": "date"
                },
                "telefonoPersona": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "string",
                        "maxLength": 15
                    }
                },
                "correoPersona": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "string",
                        "maxLength": 100
                    }
                },
                "rol": {
                    "bsonType": "string",
                    "enum": [
                        "Ciudadano",
                        "Administrativo",
                        "Tecnico"
                    ]
                },
                "disponibilidad": {
                    "bsonType": "bool"
                },
                "especialidades": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "idEspecialidad": {
                                "bsonType": "number"
                            },
                            "nombreEspecialidad": {
                                "bsonType": "string",
                                "maxLength": 50
                            }
                        },
                        "additionalProperties": false
                    }
                },
                "area": {
                    "bsonType": "object",
                    "properties": {
                        "idArea": {
                            "bsonType": "number"
                        },
                        "nombreArea": {
                            "bsonType": "string",
                            "maxLength": 50
                        },
                        "tipoArea": {
                            "bsonType": "string",
                            "maxLength": 50
                        }
                    },
                    "additionalProperties": false
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("Reportes", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Reportes",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "idReporte": {
                    "bsonType": "objectId"
                },
                "titulo": {
                    "bsonType": "string",
                    "maxLength": 50
                },
                "descripcion": {
                    "bsonType": "string",
                    "maxLength": 500
                },
                "nivelUrgencia": {
                    "bsonType": "string",
                    "enum": [
                        "Baja",
                        "Media",
                        "Alta"
                    ]
                },
                "esAnonimo": {
                    "bsonType": "bool"
                },
                "fechaReporte": {
                    "bsonType": "date"
                },
                "categoria": {
                    "bsonType": "object",
                    "properties": {
                        "idCategoria": {
                            "bsonType": "number"
                        },
                        "nombreCategoria": {
                            "bsonType": "string"
                        }
                    },
                    "additionalProperties": false
                },
                "estadoActual": {
                    "bsonType": "string",
                    "enum": [
                        "Pendiente",
                        "En Proceso",
                        "Finalizado",
                        "Observado"
                    ]
                },
                "ciudadano": {
                    "bsonType": "object",
                    "properties": {
                        "idPersona": {
                            "bsonType": "objectId"
                        },
                        "dni": {
                            "bsonType": "string",
                            "maxLength": 8,
                            "minLength": 8
                        },
                        "nombre": {
                            "bsonType": "string"
                        },
                        "apellido": {
                            "bsonType": "string"
                        }
                    },
                    "additionalProperties": false
                },
                "municipalidad": {
                    "bsonType": "object",
                    "properties": {
                        "idMunicipalidad": {
                            "bsonType": "objectId"
                        },
                        "nombre": {
                            "bsonType": "string"
                        }
                    },
                    "additionalProperties": false
                },
                "ubicacion": {
                    "bsonType": "object",
                    "properties": {
                        "direccion": {
                            "bsonType": "string",
                            "maxLength": 150
                        },
                        "longitud": {
                            "bsonType": "double"
                        },
                        "latitud": {
                            "bsonType": "double"
                        }
                    },
                    "additionalProperties": false
                },
                "evidencias": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "tipoArchivo": {
                                "bsonType": "string",
                                "enum": [
                                    "Foto",
                                    "Video"
                                ]
                            },
                            "urlArchivo": {
                                "bsonType": "string",
                                "maxLength": 150
                            },
                            "fechaCarga": {
                                "bsonType": "date"
                            }
                        },
                        "additionalProperties": false
                    }
                },
                "historialEstados": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "estadoAnterior": {
                                "bsonType": "string"
                            },
                            "estadoNuevo": {
                                "bsonType": "string"
                            },
                            "fechaCambio": {
                                "bsonType": "date"
                            }
                        },
                        "additionalProperties": false
                    }
                },
                "asignaciones": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "idAsignacion": {
                                "bsonType": "number"
                            },
                            "tecnico": {
                                "bsonType": "object",
                                "properties": {
                                    "idPersona": {
                                        "bsonType": "number"
                                    },
                                    "nombre": {
                                        "bsonType": "string"
                                    }
                                },
                                "additionalProperties": false
                            },
                            "administrador": {
                                "bsonType": "object",
                                "properties": {
                                    "idPersona": {
                                        "bsonType": "number"
                                    },
                                    "nombre": {
                                        "bsonType": "string"
                                    }
                                },
                                "additionalProperties": false
                            },
                            "fechaAsignacion": {
                                "bsonType": "date"
                            },
                            "fechaInicio": {
                                "bsonType": "date"
                            },
                            "fechaFin": {
                                "bsonType": "date"
                            },
                            "instrucciones": {
                                "bsonType": "string",
                                "maxLength": 1000
                            }
                        },
                        "additionalProperties": false
                    }
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("Municipalidades", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Municipalidades",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "idMunicipalidad": {
                    "bsonType": "objectId"
                },
                "nombre": {
                    "bsonType": "string",
                    "maxLength": 50
                },
                "distrito": {
                    "bsonType": "string",
                    "maxLength": 50
                },
                "direccion": {
                    "bsonType": "string",
                    "maxLength": 150
                },
                "ruc": {
                    "bsonType": "string",
                    "maxLength": 11
                },
                "telefonoMunicipalidad": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "string",
                        "maxLength": 15,
                        "minLength": 0
                    }
                },
                "correoMunicipalidad": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "string",
                        "maxLength": 100
                    }
                },
                "area": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "idArea": {
                                "bsonType": "number"
                            },
                            "nombreArea": {
                                "bsonType": "string",
                                "maxLength": 50
                            },
                            "tipoArea": {
                                "bsonType": "string",
                                "maxLength": 50
                            }
                        },
                        "additionalProperties": false
                    }
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("Notificaciones", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Notificaciones",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "idNotificacion": {
                    "bsonType": "objectId"
                },
                "idReporte": {
                    "bsonType": "objectId"
                },
                "idPersona": {
                    "bsonType": "objectId"
                },
                "mensaje": {
                    "bsonType": "string",
                    "maxLength": 500,
                    "minLength": 0
                },
                "fechaEnvio": {
                    "bsonType": "date"
                },
                "leido": {
                    "bsonType": "bool"
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});




db.createCollection("Categorias", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "Categorias",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "idCategoria": {
                    "bsonType": "objectId"
                },
                "nombreCategoria": {
                    "bsonType": "string",
                    "maxLength": 50
                },
                "descripcion": {
                    "bsonType": "string",
                    "maxLength": 500
                },
                "subCategoria": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "idCategoria": {
                                "bsonType": "number"
                            },
                            "nombreCategoria": {
                                "bsonType": "string"
                            },
                            "descripcion": {
                                "bsonType": "string"
                            }
                        },
                        "additionalProperties": false
                    }
                }
            },
            "additionalProperties": false
        }
    },
    "validationLevel": "off",
    "validationAction": "warn"
});