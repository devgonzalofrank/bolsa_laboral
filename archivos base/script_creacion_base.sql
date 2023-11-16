-- Crear la secuencia para usuarios_candidatos
CREATE SEQUENCE seq_usuarios_candidatos START 1;

-- Crear la secuencia para usuarios_empleadores
CREATE SEQUENCE seq_usuarios_empleadores START 1;

-- Crear la secuencia para ofertas_laborales
CREATE SEQUENCE seq_ofertas_laborales START 1;

-- Crear la secuencia para postulaciones
CREATE SEQUENCE seq_postulaciones START 1;

-- Crear la secuencia para localidades_misiones
CREATE SEQUENCE seq_localidades_misiones START 1;

-- Crear la secuencia para categorias_empleos
CREATE SEQUENCE seq_categorias_empleos START 1;

-- Crear la secuencia para comentarios_sitio
CREATE SEQUENCE seq_comentarios_sitio START 1;

-- Crear la secuencia para usuarios_administradores
CREATE SEQUENCE seq_usuarios_administradores START 1;

-- Tabla localidades_misiones
CREATE TABLE localidades_misiones (
    id INT PRIMARY KEY DEFAULT nextval('seq_localidades_misiones'),
    nombre_localidad VARCHAR(100) NOT NULL
);

-- Tabla categorias_empleos
CREATE TABLE categorias_empleos (
    id INT PRIMARY KEY DEFAULT nextval('seq_categorias_empleos'),
    nombre_categoria VARCHAR(100) NOT NULL
);

-- Tabla usuarios_candidatos
CREATE TABLE usuarios_candidatos (
    dni BIGINT PRIMARY KEY DEFAULT nextval('seq_usuarios_candidatos'),
    email VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    localidad VARCHAR(100) NOT NULL,
    cv_pdf VARCHAR(255),
    fecha_ingreso TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Tabla usuarios_empleadores
CREATE TABLE usuarios_empleadores (
    cuit BIGINT PRIMARY KEY DEFAULT nextval('seq_usuarios_empleadores'),
    nombre_empresa VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    localidad VARCHAR(100) NOT NULL,
    estado BOOLEAN DEFAULT FALSE,
    fecha_ingreso TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Tabla ofertas_laborales
CREATE TABLE ofertas_laborales (
    id INT PRIMARY KEY DEFAULT nextval('seq_ofertas_laborales'),
    dni_cuit_empresa BIGINT REFERENCES usuarios_empleadores(cuit),
    id_categoria_empleo INT REFERENCES categorias_empleos(id),
    id_localidad INT REFERENCES localidades_misiones(id),
    nombre_puesto VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    activa BOOLEAN DEFAULT TRUE
);

-- Tabla postulaciones
CREATE TABLE postulaciones (
    id INT PRIMARY KEY DEFAULT nextval('seq_postulaciones'),
    dni_candidato BIGINT REFERENCES usuarios_candidatos(dni),
    id_oferta INT REFERENCES ofertas_laborales(id)
);

-- Tabla comentarios_sitio
CREATE TABLE comentarios_sitio (
    id INT PRIMARY KEY DEFAULT nextval('seq_comentarios_sitio'),
    usuario_candidato_dni BIGINT REFERENCES usuarios_candidatos(dni), 
    comentario TEXT, 
    fecha_creacion TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Tabla usuarios_administradores
CREATE TABLE usuarios_administradores (
    id INT PRIMARY KEY DEFAULT nextval('seq_usuarios_administradores'),
    email VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL
);
