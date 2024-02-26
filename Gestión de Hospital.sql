CREATE DATABASE  IF NOT EXISTS `db_name`

USE  `db_name`;


--Doctor - Department - Enfermera --

CREATE TABLE Doctor (
    CC BIGINT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
);

CREATE TABLE Department (
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    manager_id BIGINT,
    FOREIGN KEY (manager_id) REFERENCES Doctor(CC)
);

ALTER TABLE Doctor ADD FOREIGN KEY (department_id) REFERENCES Department(ID);

CREATE TABLE PersonalEnfermeria (
    CC BIGINT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

--Paciente - Historial Médico - Seguro Médico--

CREATE TABLE Paciente (
    CC BIGINT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(50) NOT NULL, 
);

CREATE TABLE HistorialMedico (
    ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    patient_id BIGINT,
    consultation_date DATE,
    diagnosis VARCHAR(255),
    treatment VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Paciente(CC)
);

CREATE TABLE SeguroMedico (
    ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    company_name VARCHAR(100),
    insurance_type VARCHAR(50),
    policy_number VARCHAR(50),
    patient_id BIGINT,
    FOREIGN KEY (patient_id) REFERENCES Paciente(CC)
);


-- Cita --

CREATE TABLE Cita (
    ID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
    patient_id BIGINT,
    appointment_date DATETIME,
    doctor_id BIGINT,
    diagnosis VARCHAR(255),
    treatment VARCHAR(255),
    office_number VARCHAR(10),
    FOREIGN KEY (patient_id) REFERENCES Paciente(CC),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(CC)
);

-- Resultado de Laboratorio --

CREATE TABLE ResultadosLaboratorio (
    ID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
    patient_id BIGINT,
    appointment_date DATETIME,
    nurse_id BIGINT,
    resultado VARCHAR(255),
    FOREIGN KEY (nurse_id) REFERENCES PersonalEnfermeria(CC),
    FOREIGN KEY (patient_id) REFERENCES Paciente(CC)
);

-- Medicamentos --

CREATE TABLE Medicamento (
    ID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    stock INT    
);

-- Equipo Médico --

CREATE TABLE EquipoMedico (
    ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    stock INT
);

-- Procedimiento Médico --

CREATE TABLE ProcedimientoMedico (
    ID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,
    nurse_id BIGINT NOT NULL,
    appointment_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Paciente(CC),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(CC),
    FOREIGN KEY (nurse_id) REFERENCES PersonalEnfermeria(CC)
);

CREATE TABLE Medicina_ProcedimientoMedico (
    procedure_id UNIQUEIDENTIFIER NOT NULL,
    medicine_id UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (procedure_id, medicine_id),
    quantity INT NOT NULL,
    FOREIGN KEY (procedure_id) REFERENCES ProcedimientoMedico(ID),
    FOREIGN KEY (medicine_id) REFERENCES Medicamento(ID)
);

CREATE TABLE EquipoMedico_ProcedimientoMedico (
    procedure_id UNIQUEIDENTIFIER NOT NULL,
    medical_equipment_id INT NOT NULL,
    PRIMARY KEY (procedure_id, medical_equipment_id),
    quantity INT NOT NULL,
    FOREIGN KEY (procedure_id) REFERENCES ProcedimientoMedico(ID),
    FOREIGN KEY (medical_equipment_id ) REFERENCES EquipoMedico(ID)
);

-- Asignación de Horarios --

CREATE TABLE Turno (
    ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

CREATE TABLE AsignacionHorarios_Doctores (
    doctor_id BIGINT NOT NULL,
    shift_id INT NOT NULL,
    PRIMARY KEY (doctor_id, shift_id),
    week DATE NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(CC),
    FOREIGN KEY (shift_id) REFERENCES Turno(ID)
);

CREATE TABLE AsignacionHorarios_PersonalEnfermeria (
    nurse_id BIGINT NOT NULL,
    shift_id INT NOT NULL,
    PRIMARY KEY (nurse_id, shift_id),
    week DATE NOT NULL,
    FOREIGN KEY (nurse_id) REFERENCES PersonalEnfermeria(CC),
    FOREIGN KEY (shift_id) REFERENCES Turno(ID)
);







--CREACIÓN DE DEPARTAMENTOS--

INSERT INTO Department (name) VALUES ('General'), ('Cardiología'), ('Pediatría'), ('Neurología'), ('Odontología'); 

SELECT * FROM Department;



--CREACIÓN DE DOCTORES--

INSERT INTO Doctor (cc, name, last_name, email, department_id) VALUES 
(6666118325, 'José', 'Martínez', 'jose.martinez@example.com', 1),
(1710601892, 'María', 'López', 'maria.lopez@example.com', 3),
(1000045147, 'Pedro', 'García', 'pedro.garcia@example.com', 5),
(3056030532, 'Ana', 'Rodríguez', 'ana.rodriguez@example.com', 5),
(4755798944, 'Jorge', 'Hernández', 'jorge.hernandez@example.com', 4),
(4345968006, 'Laura', 'Gómez', 'laura.gomez@example.com', 3),
(5021736462, 'Carlos', 'Díaz', 'carlos.diaz@example.com', 2),
(4652353295, 'Luisa', 'Fernández', 'luisa.fernandez@example.com', 1);

SELECT * FROM Doctor;



--Asignar Manager--

UPDATE Department SET manager_id = 6666118325 WHERE ID = 1;
UPDATE Department SET manager_id = 5021736462 WHERE ID = 2;
UPDATE Department SET manager_id = 1710601892 WHERE ID = 3;
UPDATE Department SET manager_id = 4755798944 WHERE ID = 4;
UPDATE Department SET manager_id = 3056030532 WHERE ID = 5;

SELECT * FROM Department;



--CREACIÓN DE ENFERMERAS--

INSERT INTO PersonalEnfermeria (CC, name, last_name, email) VALUES 
(1827489562, 'Laura', 'Gómez', 'laura.gomez@example.com'),
(3267974731, 'Carlos', 'Martínez', 'carlos.martinez@example.com'),
(3495827750, 'Ana', 'López', 'ana.lopez@example.com'),
(8205806865, 'Pedro', 'García', 'pedro.garcia@example.com'),
(1170240404, 'María', 'Rodríguez', 'maria.rodriguez@example.com');



--Ingresar Pacientes--

INSERT INTO Paciente (CC, name, last_name, date_of_birth, address, phone, email)
VALUES 
(7519588214, 'Juan', 'Pérez', '1990-05-15', '123 Main St', '123-456-7890', 'juan@example.com'),
(6964653580, 'María', 'González', '1985-10-20', '456 Elm St', '987-654-3210', 'maria@example.com'),
(2526797307, 'Carlos', 'López', '1987-03-10', '789 Oak St', '111-222-3333', 'carlos@example.com'),
(3967521144, 'Ana', 'Martínez', '1995-08-25', '101 Pine St', '444-555-6666', 'ana@example.com'),
(9827623090, 'Pedro', 'Sánchez', '1976-11-05', '246 Maple St', '777-888-9999', 'pedro@example.com');

SELECT * FROM Paciente;



--Ingresar Seguro Médico--

INSERT INTO SeguroMedico (company_name, insurance_type, policy_number, patient_id)
VALUES 
('Seguro XYZ', 'Seguro de Salud', '123456', 7519588214),
('Seguro ABC', 'Seguro Médico', '987654', 6964653580),
('Seguro XYZ', 'Seguro de Salud', '111111', 2526797307),
('Seguro ABC', 'Seguro Médico', '222222', 3967521144),
('Seguro DEF', 'Seguro de Vida', '333333', 9827623090);

SELECT * FROM SeguroMedico 
    WHERE patient_id = (SELECT CC FROM Paciente WHERE name = 'Juan');



--Ingresar Citas--

INSERT INTO Cita (patient_id, appointment_date, doctor_id, diagnosis, treatment, office_number)
VALUES 
(7519588214, '2024-02-27 10:00:00', 6666118325, 'Common cold', 'Rest and fluids', 'Room 101'),
(2526797307, '2024-02-28 11:30:00', 6666118325, 'Headache', 'Painkillers', 'Room 102'),
(3967521144, '2024-02-29 09:45:00', 6666118325, 'Influenza', 'Prescription medication', 'Room 103');

SELECT * FROM Cita;
SELECT office_number FROM Cita
    WHERE patient_id = (SELECT CC FROM Paciente WHERE name = 'Juan') AND CAST(appointment_date AS DATE) = '2024-02-27';



-- Ingresar Resultados de Laboratorio --

-- Resultado para el paciente Juan Pérez
INSERT INTO ResultadosLaboratorio (patient_id, appointment_date, nurse_id, resultado)
VALUES 
(7519588214, '2024-02-27 10:00:00', 1170240404, 'Niveles de glucosa dentro del rango normal.');

-- Resultado para el paciente Carlos López
INSERT INTO ResultadosLaboratorio (patient_id, appointment_date, nurse_id, resultado)
VALUES 
(2526797307, '2024-02-28 11:30:00', 8205806865, 'Presión arterial elevada, se recomienda monitoreo regular.');

-- Resultado para el paciente Ana Martínez
INSERT INTO ResultadosLaboratorio (patient_id, appointment_date, nurse_id, resultado)
VALUES 
(3967521144, '2024-02-29 09:45:00', 3267974731, 'Recuento de glóbulos blancos anormalmente alto, se recomienda seguimiento médico.');

-- Otro ejemplo para el paciente Juan Pérez
INSERT INTO ResultadosLaboratorio (patient_id, appointment_date, nurse_id, resultado)
VALUES 
(7519588214, '2024-03-01 14:00:00', 3267974731, 'Resultado de prueba de COVID-19: negativo.');

-- Otro ejemplo para el paciente Carlos López
INSERT INTO ResultadosLaboratorio (patient_id, appointment_date, nurse_id, resultado)
VALUES 
(2526797307, '2024-03-02 10:15:00', 1827489562, 'Análisis de sangre: valores de colesterol alto, se recomienda cambios en la dieta y ejercicio.');

SELECT * FROM ResultadosLaboratorio;
SELECT * FROM ResultadosLaboratorio
    WHERE patient_id = (SELECT CC FROM Paciente WHERE name = 'Carlos' and last_name = 'López');


-- Ingresar Medicamentos --

INSERT INTO Medicamento (name, description, stock) VALUES 
('Paracetamol', 'Analgésico y antipirético comúnmente utilizado para aliviar el dolor y reducir la fiebre.', 100),
('Amoxicilina', 'Antibiótico utilizado para tratar una variedad de infecciones bacterianas.', 75),
('Omeprazol', 'Inhibidor de la bomba de protones utilizado para tratar úlceras gástricas y reflujo ácido.', 50),
('Ibuprofeno', 'Analgésico y antiinflamatorio no esteroideo (AINE) utilizado para aliviar el dolor y reducir la inflamación.', 80),
('Loratadina', 'Antihistamínico utilizado para tratar alergias como la fiebre del heno y la urticaria.', 60),
('Propofol', 'Anestésico general utilizado para inducir y mantener la anestesia durante cirugías y procedimientos médicos.', 25);

SELECT * FROM Medicamento;


-- Ingresar Equipos Médicos --

INSERT INTO EquipoMedico (name, description, stock) 
VALUES 
('Desfibrilador', 'Dispositivo utilizado para administrar una descarga eléctrica al corazón con el fin de restaurar un ritmo cardíaco normal en casos de paro cardíaco.', 5),
('Ventilador Mecánico', 'Dispositivo utilizado para ayudar o reemplazar la respiración espontánea de un paciente. Es comúnmente utilizado en casos de insuficiencia respiratoria.', 3),
('Monitor de Signos Vitales', 'Dispositivo utilizado para medir y mostrar las constantes vitales de un paciente, como la presión arterial, la frecuencia cardíaca y la saturación de oxígeno en la sangre.', 10),
('Equipo de Rayos X', 'Dispositivo utilizado para obtener imágenes internas del cuerpo humano con fines diagnósticos. Es comúnmente utilizado en hospitales y clínicas.', 2),
('Ecógrafo', 'Dispositivo utilizado para producir imágenes del interior del cuerpo mediante el uso de ondas sonoras de alta frecuencia. Es comúnmente utilizado para examinar órganos internos y tejidos blandos.', 4);

SELECT * FROM EquipoMedico;


-- Ingresar Procedimientos Médicos --

INSERT INTO ProcedimientoMedico (name, description, patient_id, doctor_id, nurse_id, appointment_date)
VALUES 
('Extracción de muelas de cordales', 'Procedimiento para extraer muelas cordales impactadas', 3967521144, 3056030532, 1170240404, '2024-03-02'),
('Reducción de fractura', 'Procedimiento para reducir una fractura ósea', 7519588214, 6666118325, 3267974731, '2024-02-28');

INSERT INTO Medicina_ProcedimientoMedico (procedure_id, medicine_id, quantity)
VALUES 
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 3967521144), (SELECT ID FROM Medicamento WHERE name = 'Propofol'), 2),
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 3967521144), (SELECT ID FROM Medicamento WHERE name = 'Ibuprofeno'), 1),
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 7519588214), (SELECT ID FROM Medicamento WHERE name = 'Propofol'), 1),
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 7519588214), (SELECT ID FROM Medicamento WHERE name = 'Ibuprofeno'), 3)
;

INSERT INTO EquipoMedico_ProcedimientoMedico (procedure_id, medical_equipment_id, quantity)
VALUES 
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 7519588214), (SELECT ID FROM EquipoMedico WHERE name = 'Equipo de Rayos X'), 1),
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 7519588214), (SELECT ID FROM EquipoMedico WHERE name = 'Monitor de Signos Vitales'), 1)
;

SELECT * FROM ProcedimientoMedico;

SELECT * FROM Medicina_ProcedimientoMedico
    WHERE procedure_id = (SELECT ID FROM ProcedimientoMedico WHERE patient_id = 3967521144);

SELECT name FROM EquipoMedico 
    WHERE ID IN (
            SELECT medical_equipment_id FROM EquipoMedico_ProcedimientoMedico 
                WHERE procedure_id IN (
                    SELECT ID FROM ProcedimientoMedico WHERE doctor_id = 6666118325));


INSERT INTO ProcedimientoMedico (name, description, patient_id, doctor_id, nurse_id, appointment_date)
VALUES 
('Cirugía de apendicectomía', 'Procedimiento quirúrgico para extirpar el apéndice', 9827623090, 6666118325, 3495827750, '2024-03-05');

INSERT INTO Medicina_ProcedimientoMedico (procedure_id, medicine_id, quantity)
VALUES 
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 9827623090), (SELECT ID FROM Medicamento WHERE name = 'Propofol'), 1),
((SELECT ID FROM ProcedimientoMedico WHERE patient_id = 9827623090), (SELECT ID FROM Medicamento WHERE name = 'Amoxicilina'), 3);

SELECT name, stock FROM Medicamento 
    WHERE ID IN (
        SELECT medicine_id FROM Medicina_ProcedimientoMedico
            WHERE procedure_id IN (
                SELECT ID FROM ProcedimientoMedico WHERE doctor_id = 6666118325));


-- Ingresar Turnos --

INSERT INTO Turno(name, start_time, end_time) VALUES
('Turno Mañana', '06:00:00', '14:00:00'),
('Turno Tarde', '14:00:00', '22:00:00'),
('Turno Noche', '22:00:00', '06:00:00');

SELECT * FROM Turno;


-- Ingresar Horarios para la Semana del 26 de Febrero al 3 de Marzo

DECLARE @fecha_semana1 DATE;
SET @fecha_semana1 = '2024-02-26';

INSERT INTO AsignacionHorarios_Doctores (doctor_id, shift_id, week)
VALUES 
(6666118325, 1, @fecha_semana1), 
(1710601892, 2, @fecha_semana1), 
(1000045147, 3, @fecha_semana1),
(3056030532, 1, @fecha_semana1), 
(4755798944, 2, @fecha_semana1), 
(4345968006, 3, @fecha_semana1),
(5021736462, 1, @fecha_semana1), 
(4652353295, 1, @fecha_semana1); 

SELECT * FROM Turno
    WHERE ID IN (
        SELECT shift_id FROM AsignacionHorarios_Doctores
            WHERE doctor_id IN(
                SELECT CC FROM Doctor WHERE name = 'Ana' AND last_name = 'Rodríguez'
            )
    );


DECLARE @fecha_semana1 DATE;
SET @fecha_semana1 = '2024-02-26';

INSERT INTO AsignacionHorarios_PersonalEnfermeria (nurse_id, shift_id, week)
VALUES 
(1827489562, 1, @fecha_semana1), 
(3267974731, 2, @fecha_semana1), 
(3495827750, 3, @fecha_semana1),
(8205806865, 2, @fecha_semana1), 
(1170240404, 1, @fecha_semana1); 

SELECT * FROM Turno
    WHERE ID IN (
        SELECT shift_id FROM AsignacionHorarios_PersonalEnfermeria
            WHERE nurse_id IN(
                SELECT CC FROM PersonalEnfermeria WHERE name = 'Pedro' AND last_name = 'García'
            )
    );