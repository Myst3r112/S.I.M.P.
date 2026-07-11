CREATE TABLE Municipalidad (
	id_municipalidad INT           NOT NULL IDENTITY(1,1),
	nombre           NVARCHAR(50)  NOT NULL,
	distrito         NVARCHAR(50)  NOT NULL,
	direccion        NVARCHAR(150) NULL    ,
    ruc              NVARCHAR(11)  NOT NULL UNIQUE,
  
    PRIMARY KEY (id_municipalidad)
);
GO
CREATE TABLE Persona (
    id_persona     INT           NOT NULL IDENTITY(1,1),
    dni            NVARCHAR(8)   NOT NULL UNIQUE,
    nombre         NVARCHAR(50)  NOT NULL,
    apellido       NVARCHAR(50)  NOT NULL,
    direccion      NVARCHAR(150) NOT NULL,
    fecha_registro DATE          NOT NULL DEFAULT GETDATE(),

    PRIMARY KEY (id_persona)
);
GO
CREATE TABLE Especialidad (
    id_especialidad     INT          NOT NULL IDENTITY(1,1),
    nombre_especialidad NVARCHAR(50) NOT NULL,
    
    PRIMARY KEY (id_especialidad)
);
GO
CREATE TABLE Estado_Reporte (
    id_estado_reporte INT          NOT NULL IDENTITY(1,1),
    nombre            NVARCHAR(20) NOT NULL,
    
    PRIMARY KEY (id_estado_reporte),
    CONSTRAINT CK_Estado_Reporte_nombre CHECK (nombre IN ('Pendiente', 'En Proceso', 'Finalizado', 'Observado'))
);
GO
CREATE TABLE Categoria_incidente (
    id_categoria       INT           NOT NULL IDENTITY(1,1),
    id_categoria_padre INT           NULL    ,
    nombre_categoria   NVARCHAR(50)  NOT NULL,
    descripcion        NVARCHAR(500) NULL    ,
    
    PRIMARY KEY (id_categoria),
    FOREIGN KEY (id_categoria_padre) REFERENCES Categoria_incidente (id_categoria)
);
GO
CREATE TABLE Telefono_Persona (
    id_telefono_per INT          NOT NULL IDENTITY(1,1),
    id_persona      INT          NOT NULL,
    numero          NVARCHAR(15) NOT NULL,
    
    PRIMARY KEY (id_telefono_per),
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona)
);
GO
CREATE TABLE Correo_Persona (
    id_correo_per INT           NOT NULL IDENTITY(1,1),
    id_persona    INT           NOT NULL,
    correo        NVARCHAR(100) NOT NULL,
    
    PRIMARY KEY (id_correo_per),
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona)
);
GO
CREATE TABLE Telefono_Municipalidad (
    id_telefono_mun  INT          NOT NULL IDENTITY(1,1),
    id_municipalidad INT          NOT NULL,
    numero           NVARCHAR(15) NOT NULL,

    PRIMARY KEY (id_telefono_mun),
    FOREIGN KEY (id_municipalidad) REFERENCES Municipalidad (id_municipalidad)
);
GO
CREATE TABLE Correo_Municipalidad (
    id_correo_mun    INT           NOT NULL IDENTITY(1,1),
    id_municipalidad INT           NOT NULL,
    correo           NVARCHAR(100) NOT NULL,

    PRIMARY KEY (id_correo_mun),
    FOREIGN KEY (id_municipalidad) REFERENCES Municipalidad (id_municipalidad)
);
GO
CREATE TABLE Area_Municipal (
    id_area          INT          NOT NULL IDENTITY(1,1),
    id_municipalidad INT          NOT NULL,
    nombre_area      NVARCHAR(50) NOT NULL,
    tipo_area        NVARCHAR(50) NOT NULL,

    PRIMARY KEY (id_area),
    FOREIGN KEY (id_municipalidad) REFERENCES Municipalidad (id_municipalidad)
);
GO
CREATE TABLE Ciudadano (
    id_persona INT NOT NULL UNIQUE,
    
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona)
);
GO
CREATE TABLE Personal_Administrativo (
    id_persona INT NOT NULL UNIQUE,
    id_area    INT NOT NULL,
    
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona),
    FOREIGN KEY (id_area) REFERENCES Area_Municipal (id_area)
);
GO
CREATE TABLE Personal_Tecnico (
    id_persona     INT NOT NULL UNIQUE,
    disponibilidad BIT NOT NULL DEFAULT 1,
    id_area        INT NOT NULL,

    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona),
    FOREIGN KEY (id_area) REFERENCES Area_Municipal (id_area),

    CONSTRAINT CK_Disponibilidad CHECK (disponibilidad IN (0,1))
);
GO
CREATE TABLE Tecnico_Especialidad (
    id_persona_tecnico INT NOT NULL,
    id_especialidad    INT NOT NULL,

    PRIMARY KEY (id_persona_tecnico, id_especialidad),
    FOREIGN KEY (id_persona_tecnico) REFERENCES Personal_Tecnico (id_persona),
    FOREIGN KEY (id_especialidad) REFERENCES Especialidad (id_especialidad)
);
GO
CREATE TABLE Ubicacion_Reporte (
  id_ubicacion INT           NOT NULL IDENTITY(1,1),
  direccion    NVARCHAR(150) NOT NULL,
  latitud      NVARCHAR(20)  NOT NULL,
  longitud     NVARCHAR(20)  NOT NULL,
  PRIMARY KEY (id_ubicacion)
);
GO
CREATE TABLE Reporte (
    id_reporte           INT           NOT NULL IDENTITY(1,1),
    id_categoria         INT           NOT NULL,
    id_persona_ciudadano INT           NOT NULL,
    id_municipalidad     INT           NOT NULL,
    id_ubicacion         INT           NOT NULL,
    id_estado_reporte    INT           NOT NULL,
    titulo               NVARCHAR(50)  NOT NULL,
    descripcion          NVARCHAR(500) NOT NULL,
    nivel_urgencia       NVARCHAR(20)  NOT NULL,
    es_anonimo           BIT           NOT NULL DEFAULT 0,
    fecha_reporte        DATE          NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (id_reporte),
    FOREIGN KEY (id_categoria) REFERENCES Categoria_incidente (id_categoria),
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion_Reporte (id_ubicacion),
    FOREIGN KEY (id_estado_reporte) REFERENCES Estado_Reporte (id_estado_reporte),
    FOREIGN KEY (id_municipalidad) REFERENCES Municipalidad (id_municipalidad),
    FOREIGN KEY (id_persona_ciudadano) REFERENCES Ciudadano (id_persona),

    CONSTRAINT CK_Reporte_nivel_urgencia CHECK (nivel_urgencia IN ('baja', 'media', 'alta')),
    CONSTRAINT CK_Reporte_es_anonimo CHECK (es_anonimo IN (0, 1))
);
GO
CREATE TABLE Historial_Estado_Reporte (
    id_historial       INT      NOT NULL IDENTITY(1,1),
    id_reporte         INT      NOT NULL,
    id_estado_anterior INT      NOT NULL,
    id_estado_nuevo    INT      NOT NULL,
    fecha_cambio       DATETIME NOT NULL DEFAULT GETDATE(),

    PRIMARY KEY (id_historial),
    FOREIGN KEY (id_reporte) REFERENCES Reporte (id_reporte),
    FOREIGN KEY (id_estado_anterior) REFERENCES Estado_Reporte (id_estado_reporte),
    FOREIGN KEY (id_estado_nuevo) REFERENCES Estado_Reporte (id_estado_reporte)
);
GO
CREATE TABLE Evidencia_Multimedia (
    id_evidencia INT           NOT NULL IDENTITY(1,1),
    id_reporte   INT           NOT NULL,
    tipo_archivo NVARCHAR(20)  NOT NULL,
    url_archivo  NVARCHAR(150) NOT NULL,
    fecha_carga  DATETIME      NOT NULL DEFAULT GETDATE(),

    PRIMARY KEY (id_evidencia),
    FOREIGN KEY (id_reporte) REFERENCES Reporte (id_reporte),

    CONSTRAINT CK_Evidencia_Multimedia_tipo_archivo CHECK (tipo_archivo IN ('Foto', 'Video'))
);
GO
CREATE TABLE Asignacion_Trabajo (
    id_asignacion      INT            NOT NULL IDENTITY(1,1),
    id_reporte         INT            NOT NULL,
    id_persona_tecnico INT            NOT NULL,
    id_persona_admin   INT            NOT NULL,
    fecha_asignacion   DATE           NOT NULL,
    fecha_inicio       DATE           NOT NULL DEFAULT GETDATE(),
    fecha_fin          DATE           NOT NULL,
    instrucciones      NVARCHAR(1000) NOT NULL,
    
    PRIMARY KEY (id_asignacion),
    FOREIGN KEY (id_reporte) REFERENCES Reporte (id_reporte),
    FOREIGN KEY (id_persona_tecnico) REFERENCES Personal_Tecnico (id_persona),
    FOREIGN KEY (id_persona_admin) REFERENCES Personal_Administrativo (id_persona)
);
GO
CREATE TABLE Notificacion (
    id_notificacion INT           NOT NULL IDENTITY(1,1),
    id_reporte      INT           NOT NULL,
    id_persona      INT           NOT NULL,
    mensaje         NVARCHAR(500) NOT NULL,
    fecha_envio     DATETIME      NOT NULL DEFAULT GETDATE(),

    PRIMARY KEY (id_notificacion),
    FOREIGN KEY (id_reporte) REFERENCES Reporte (id_reporte),
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona)
);
GO