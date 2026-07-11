use ('SIMP');

db.Municipalidades.insertMany([
    {
        nombre: "Municipalidad Distrital de Comas",
        distrito: "Comas",
        direccion: "Av. 22 de Agosto km 11",
        ruc: "20131313131",
        telefonoMunicipalidad: ["(01) 542-1234"],
        correoMunicipalidad: ["consultas@municomas.gob.pe"],
        area: [
            { idArea: NumberInt(1), nombreArea: "Gerencia de Obras Públicas e Infraestructura", tipoArea: "Operativa Operaciones" },
            { idArea: NumberInt(2), nombreArea: "Subgerencia de Limpieza Pública y Ornato", tipoArea: "Mantenimiento" }
        ]
    },
    {
        nombre: "Municipalidad de Los Olivos",
        distrito: "Los Olivos",
        direccion: "Av. Carlos Izaguirre 815",
        ruc: "20151515151",
        telefonoMunicipalidad: ["(01) 614-1212"],
        correoMunicipalidad: ["atencion@munilosolivos.gob.pe"],
        area: [
            { idArea: NumberInt(3), nombreArea: "Gerencia de Desarrollo Urbano", tipoArea: "Operativa Operaciones" }
        ]
    }
]);

db.Categorias.insertMany([
    {
        nombreCategoria: "Vías y Pavimentos",
        descripcion: "Daños estructurales en pistas, veredas y gibas",
        subCategoria: [
            { idCategoria: NumberInt(4), nombreCategoria: "Baches y Socavones", descripcion: "Huecos profundos en la capa asfáltica que dañan vehículos" },
            { idCategoria: NumberInt(5), nombreCategoria: "Veredas Rotas", descripcion: "Roturas en concreto que impiden el paso peatonal seguro" }
        ]
    },
    {
        nombreCategoria: "Alumbrado y Electricidad",
        descripcion: "Fallas en postes de luz, semáforos y cables expuestos",
        subCategoria: [
            { idCategoria: NumberInt(6), nombreCategoria: "Postes Apagados", descripcion: "Luminarias públicas que no encienden de noche" }
        ]
    }
]);

db.Personas.insertMany([
  {
    nombre: "Juan Carlos",
    apellido: "Pérez Quispe",
    DNI: "71234567",
    direccion: "Av. Túpac Amaru 1420 - Comas",
    fechaRegistro: new Date("2026-01-10T00:00:00Z"),
    rol: "Ciudadano",
    telefonoPersona: ["991234567"],
    correoPersona: ["juan.perez@gmail.com"]
  },
  {
    nombre: "Ricardo",
    apellido: "Palacios Vera",
    DNI: "10293847",
    direccion: "Urb. El Retablo - Comas",
    fechaRegistro: new Date("2026-01-02T00:00:00Z"),
    rol: "Administrativo",
    area: { idArea: NumberInt(1), nombreArea: "Gerencia de Obras Públicas e Infraestructura", tipoArea: "Operativa Operaciones" }
  },
  {
    nombre: "Pedro Pablo",
    apellido: "Guerrero Soto",
    DNI: "09384756",
    direccion: "Jr. Libertad 125 - Comas",
    fechaRegistro: new Date("2026-01-03T00:00:00Z"),
    rol: "Tecnico",
    disponibilidad: true,
    especialidades: [
        { idEspecialidad: NumberInt(1), nombreEspecialidad: "Albañilería y Pavimentación" }
    ],
    area: { idArea: NumberInt(1), nombreArea: "Gerencia de Obras Públicas e Infraestructura", tipoArea: "Operativa Operaciones" }
  }
]);

db.Reportes.insertMany([
    {
    titulo: "Mega bache destruye neumáticos",
    descripcion: "Hay un hueco enorme en el cruce de las avenidas, los autos frenan de golpe y ya provocó dos choques leves.",
    nivelUrgencia: "Alta",
    esAnonimo: false,
    fechaReporte: new Date("2026-06-15T10:00:00Z"),
    estadoActual: "En Proceso",
    categoria: { idCategoria: NumberInt(4), nombreCategoria: "Baches y Socavones" },
    ubicacion: { direccion: "Av. Túpac Amaru cruce con Av. Puno, Comas", latitud: -11.9342, longitud: -77.0524 },
    ciudadano: { idPersona: NumberInt(1), dni: "71234567", nombre: "Juan Carlos", apellido: "Pérez Quispe" },
    municipalidad: { idMunicipalidad: NumberInt(1), nombre: "Municipalidad Distrital de Comas" },
    evidencias: [
        { tipoArchivo: "Foto", urlArchivo: "https://storage.alertcity.pe/evidencias/reporte1_foto1.jpg", fechaCarga: new Date("2026-06-15T10:05:00Z") },
        { tipoArchivo: "Video", urlArchivo: "https://storage.alertcity.pe/evidencias/reporte1_video.mp4", fechaCarga: new Date("2026-06-15T10:06:22Z") }
    ],
    historialEstados: [
        { estadoAnterior: "Pendiente", estadoNuevo: "En Proceso", fechaCambio: new Date("2026-06-19T09:30:00Z") }
    ],
    asignaciones: [
        {
            idAsignacion: NumberInt(1),
            tecnico: { idPersona: NumberInt(7), nombre: "Pedro Pablo Guerrero Soto" },
            administrador: { idPersona: NumberInt(5), nombre: "Ricardo Palacios Vera" },
            fechaAsignacion: new Date("2026-06-24T00:00:00Z"),
            fechaInicio: new Date("2026-06-24T00:00:00Z"),
            fechaFin: new Date("2026-06-26T00:00:00Z"),
            instrucciones: "Rellenar con afirmado y aplicar la capa de mezcla asfáltica en frío. Compactar adecuadamente."
        }
    ]
    },
    {
        titulo: "Poste con luz parpadeante y cables sueltos",
        descripcion: "Frente al inmueble 415 la bombilla pública está averiada y cuelga un cable de baja tensión hacia la vereda.",
        nivelUrgencia: "Alta",
        esAnonimo: false,
        fechaReporte: new Date("2026-06-18T23:15:00Z"),
        estadoActual: "Pendiente",
        categoria: { idCategoria: NumberInt(6), nombreCategoria: "Postes Apagados" },
        ubicacion: { direccion: "Jr. Mercurio 415, Urb. Mercurio, Los Olivos", latitud: -11.9621, longitud: -77.0689 },
        ciudadano: { idPersona: NumberInt(2), dni: "45678912", nombre: "María Elena", apellido: "Mendoza Flores" },
        municipalidad: { idMunicipalidad: NumberInt(2), nombre: "Municipalidad de Los Olivos" }
    }
]);

db.Notificaciones.insertMany([
  {
    idReporte: new ObjectId(), 
    idPersona: new ObjectId(),
    mensaje: "Estimado vecino, su reporte de Bache ha sido recibido con éxito por el municipio.",
    fechaEnvio: new Date("2026-06-15T10:07:00Z"),
    leido: false
  }
]);