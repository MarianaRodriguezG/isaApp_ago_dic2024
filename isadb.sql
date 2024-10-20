-- RGML
-- SCRIPT DE LA BASE DE DATOS
CREATE DATABASE ISA_APP;
USE ISA_APP;

-- AQUI SE CREA LA TABLA CARRERA, POR AHORA SOLO FUNCIONA CON ISA
CREATE TABLE Carrera (
    claveCarrera CHAR(3) PRIMARY KEY,
    nombreCarrera VARCHAR(45) NOT NULL
);

-- CREACION DE LA TABLA CREDENCIAL
CREATE TABLE Credencial (
    nroControl VARCHAR(9) PRIMARY KEY,
    fotografia BLOB,
    fechaIngreso CHAR(4) NOT NULL,
    QR JSON NOT NULL
);

-- TABLA ALUMNOS 
CREATE TABLE Alumnos (
    nroControl VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    apellidoPaterno VARCHAR(45) NOT NULL,
    apellidoMaterno VARCHAR(45) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    carrera VARCHAR(45) NOT NULL,
    fotografia BLOB  NULL,
    fechaIngreso year NOT NULL, 
    tipoSangre CHAR(4) NOT NULL,
    discapacidad CHAR(2) NOT NULL,
    Carrera_claveCarrera CHAR(3) NOT NULL,
    Credencial_nroControl VARCHAR(9) NOT NULL,
    FOREIGN KEY (Carrera_claveCarrera) REFERENCES Carrera(claveCarrera),
    FOREIGN KEY (Credencial_nroControl) REFERENCES Credencial(nroControl)
);

-- Tabla UsuariosLogin 
CREATE TABLE UsuariosLogin (
    nroControl VARCHAR(9) PRIMARY KEY,
    usuario VARCHAR(45) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    pswd VARCHAR(255) NOT NULL,
    FOREIGN KEY (nroControl) REFERENCES Alumnos(nroControl)
);

-- Insertar en la tabla Carrera
INSERT INTO Carrera (claveCarrera, nombreCarrera)
VALUES ('ISC', 'Computacionales');

-- Insertar en la tabla Credencial
INSERT INTO Credencial (nroControl, fotografia, fechaIngreso, QR)
VALUES
('T24120236', NULL, '2024', JSON_OBJECT('nombre', 'Cheems', 'carrera', 'Computacionales', 'fechaNacimiento', '2000-01-01'));


-- Insertar en la tabla Alumnos con la clave de carrera ISC
INSERT INTO Alumnos (nroControl, nombre, apellidoPaterno, apellidoMaterno,
			fechaNacimiento, carrera, fotografia, fechaIngreso, tipoSangre, 
			discapacidad, Carrera_claveCarrera, Credencial_nroControl)
VALUES
('T24120236', 'Cheems', 'Doe', 'Dog', '2000-01-01', 'Computacionales', NULL, '2024', 'O+', 'NO', 'ISC', 'T24120236');



select * from Credencial;
select * from Alumnos;

-- Insertar un registro en la tabla UsuariosLogin 
INSERT INTO UsuariosLogin (nroControl, usuario, correo, pswd)
VALUES
('T24120236', 'cheems', 't24120236@alumnos.itsur.edu.mx', SHA2('34567890', 256));
