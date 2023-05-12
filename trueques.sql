/*Tablas*/
CREATE TABLE Categoria(
    codigo VARCHAR2(5) NOT NULL,
    nombre VARCHAR2(20),
    tipo VARCHAR2(1),
    minimo NUMBER(9),
    maximo NUMBER(9),
    codigo_nulo VARCHAR2(5) NULL
);

CREATE TABLE Articulo(
    id_articulo NUMBER(16) NOT NULL,
    descripcion VARCHAR2(20),
    estado VARCHAR2(1),
    foto VARCHAR2(22) NULL,
    precio NUMBER(9),
    disponible VARCHAR2(5) ,
    codigo_categoria VARCHAR2(5),
    codigo_usuario VARCHAR2(10),
    codigo_uni VARCHAR2(3) 
);

CREATE TABLE Ropa(
    id_articulo NUMBER(16) NOT NULL,
    talla VARCHAR2(2),
    material VARCHAR2(10),
    color VARCHAR2(10)
);

CREATE TABLE Perecedero(
    id_articulo NUMBER(16) NOT NULL,
    vencimiento DATE 
);

CREATE TABLE Caracteristica(
    id_articulo NUMBER(16) NOT NULL,
    caracteristica VARCHAR2(20) NOT NULL
);

CREATE TABLE ArticuloXComboOferta(
    id_articulo NUMBER(16) NOT NULL,
    numero NUMBER(9) NOT NULL
);

CREATE TABLE Combo_Oferta(
    numero NUMBER(9) NOT NULL,
    fecha DATE ,
    precio NUMBER(9) ,
    foto VARCHAR2(22) ,
    descripcion VARCHAR2(22) NULL,
    estado VARCHAR2(1) ,
    trueque VARCHAR2(1) NULL,
    codigo_usuario  VARCHAR2(10) ,
    codigo_uni VARCHAR2(3) 
);

CREATE TABLE Usuario(
    codigo_usuario  VARCHAR2(10) NOT NULL,
    codigo_uni VARCHAR2(3) NOT NULL,
    tid VARCHAR2(2) NULL,
    nid VARCHAR2(10) NULL,
    nombre VARCHAR2(50) ,
    programa VARCHAR2(20) ,
    correo VARCHAR2(50) ,
    registro DATE ,
    suspension DATE NULL,
    nSuspensiones NUMBER(3)  
);

CREATE TABLE Califica(
    codigo_usuario  VARCHAR2(10) NOT NULL ,
    codigo_uni VARCHAR2(3) NOT NULL,
    id_articulo  NUMBER(16) NOT NULL,
    estrellas NUMBER(1) 
);

CREATE TABLE Universidad(
    codigo_uni VARCHAR2(3) NOT NULL,
    nombre VARCHAR2(20) ,
    direccion VARCHAR2(50) ,
    codigo_usuario  VARCHAR2(10) NOT NULL
);

/*xTablas*/
DROP TABLE ArticuloXComboOferta;
DROP TABLE Combo_Oferta;
DROP TAblE Ropa;
DROP TABLE Perecedero;
DROP TABLE Caracteristica;
DROP TABLE Califica;
DROP TABLE Articulo;
DROP TABLE Categoria;
ALTER TABLE Usuario DROP CONSTRAINT FK_Usuario_Universidad;
DROP TABLE Universidad;
DROP TABLE Usuario;

/*Atributos*/
ALTER TABLE Categoria ADD CONSTRAINT CK_Categoria_tipo CHECK(tipo = 'A' OR tipo = 'R' OR tipo = 'L' OR tipo= 'T' OR tipo = 'O');
ALTER TABLE Categoria ADD CONSTRAINT CK_Categoria_Minimo CHECK(minimo >= 0);
ALTER TABLE Categoria ADD CONSTRAINT CK_Categoria_Maximo CHECK(maximo>= 0);

ALTER TABLE Articulo ADD CONSTRAINT CK_Articulo_estado CHECK(estado = 'U' OR estado = 'N');
ALTER TABLE Articulo ADD CONSTRAINT CK_Articulo_TURL CHECK(foto like '%https://%' and foto like '%pdf');
ALTER TABLE Articulo ADD CONSTRAINT CK_Articulo_precio CHECK(precio >= 0);
ALTER TABLE Articulo ADD CONSTRAINT CK_Articulo_Booleano CHECK(disponible = 'true' OR disponible = 'false');

ALTER TABLE Ropa ADD CHECK(talla = 'XS' OR talla = 'S' OR talla = 'M' OR talla = 'L' OR talla = 'XL');

ALTER TABLE Combo_Oferta ADD CONSTRAINT CK_ComboOferta_numero CHECK(numero>0);
ALTER TABLE Combo_Oferta ADD CONSTRAINT CK_ComboOferta_precio CHECK(precio=50 OR precio=100 OR precio=150 OR precio=200 OR precio=250);
ALTER TABLE Combo_Oferta ADD CONSTRAINT CK_ComboOferta_foto CHECK(foto like '%https://%' and foto like '%pdf');
ALTER TABLE Combo_Oferta ADD CONSTRAINT CK_ComboOferta_estado CHECK(estado = 'O' OR estado = 'A' OR estado = 'C');
ALTER TABLE Combo_Oferta ADD CONSTRAINT CK_ComboOferta_trueque CHECK(trueque ='A' OR trueque = 'C' OR trueque = 'I' OR trueque = 'E' OR trueque = 'R');

ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_tid CHECK(tid = 'CC'  OR tid = 'TI');
ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_correo CHECK (INSTR(correo, '@') > 0 AND INSTR(correo, '.') > 0);

ALTER TABLE Califica ADD CONSTRAINT CK_Califica_estrellas CHECK(estrellas>=1 AND estrellas<=5);
/*faltan 2*/

/*Primarias*/
ALTER TABLE Categoria ADD CONSTRAINT PK_Categoria PRIMARY KEY (codigo);
ALTER TABLE Articulo ADD CONSTRAINT PK_Articulo PRIMARY KEY (id_articulo);
ALTER TABLE Ropa ADD CONSTRAINT PK_Ropa PRIMARY KEY (id_articulo);
ALTER TABLE Perecedero ADD CONSTRAINT PK_Perecedero PRIMARY KEY (id_articulo);
ALTER TABLE Caracteristica ADD CONSTRAINT PK_Caracteristica PRIMARY KEY (id_articulo,caracteristica);
ALTER TABLE ArticuloXComboOferta ADD CONSTRAINT PK_ArticuloXComboOferta PRIMARY KEY (id_articulo,numero);
ALTER TABLE Combo_Oferta ADD CONSTRAINT PK_Combo_Oferta PRIMARY KEY (numero);
ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY (codigo_usuario,codigo_uni);
ALTER TABLE Califica ADD CONSTRAINT PK_Califica PRIMARY KEY (codigo_usuario,codigo_uni,id_articulo);
ALTER TABLE Universidad ADD CONSTRAINT PK_Universidad PRIMARY KEY (codigo_uni);

/*Unicas*/
ALTER TABLE Articulo ADD CONSTRAINT UK_Articulo_foto UNIQUE (foto);
ALTER TABLE Usuario ADD CONSTRAINT UK_Usuario_codigo_usuario UNIQUE (codigo_usuario);/*practico def de clave primaria que es unica pero generar una independencia
con la clave compuesta de Usuario*/
ALTER TABLE Usuario ADD CONSTRAINT UK_Usuario_tid_nid UNIQUE (tid,nid);
ALTER TABLE Universidad ADD CONSTRAINT UK_Universidad_direccion UNIQUE (direccion); /*Agregado 3)Es una restriccion de base de datos*/

/*Foraneas*/
ALTER TABLE Categoria ADD CONSTRAINT FK_Categoria_Categoria_C FOREIGN KEY (codigo_nulo) REFERENCES Categoria(codigo);

ALTER TABLE Articulo ADD CONSTRAINT FK_Articulo_Categoria FOREIGN KEY (codigo_categoria) REFERENCES Categoria(codigo);
ALTER TABLE Articulo ADD CONSTRAINT FK_Articulo_Usuario FOREIGN KEY (codigo_usuario,codigo_uni) REFERENCES Usuario(codigo_usuario,codigo_uni);

ALTER TABLE Ropa ADD CONSTRAINT FK_Ropa_Articulo FOREIGN KEY (id_articulo) REFERENCES Articulo(id_articulo);
ALTER TABLE Perecedero ADD CONSTRAINT FK_Perecedero_Articulo FOREIGN KEY (id_articulo) REFERENCES Articulo(id_articulo);

ALTER TABLE Caracteristica ADD CONSTRAINT FK_Caracteristica_Articulo FOREIGN KEY (id_articulo) REFERENCES Articulo(id_articulo);

ALTER TABLE ArticuloXComboOferta ADD CONSTRAINT FK_ArticuloxComboOferta_Articulo FOREIGN KEY (id_articulo) REFERENCES Articulo(id_articulo);
ALTER TABLE ArticuloXComboOferta ADD CONSTRAINT FK_ArticuloxComboOferta_ComboOferta FOREIGN KEY (numero) REFERENCES Combo_Oferta(numero);

ALTER TABLE Combo_Oferta ADD CONSTRAINT FK_ComboOferta_Usuario FOREIGN KEY (codigo_usuario,codigo_uni) REFERENCES Usuario(codigo_usuario,codigo_uni);

ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_Universidad FOREIGN KEY (codigo_uni) REFERENCES Universidad(codigo_uni);

ALTER TABLE Universidad ADD CONSTRAINT FK_Universidad_Usuario_codigoUsuario FOREIGN KEY (codigo_usuario) REFERENCES Usuario(codigo_usuario);

ALTER TABLE Califica ADD CONSTRAINT FK_Califica_Usuario FOREIGN KEY (codigo_usuario,codigo_uni) REFERENCES Usuario(codigo_usuario,codigo_uni);
ALTER TABLE Califica ADD CONSTRAINT FK_Califica_Articulo FOREIGN KEY (id_articulo) REFERENCES Articulo(id_articulo);


/*Poblar*/
/**/
insert into Categoria (codigo, nombre, tipo, minimo, maximo, codigo_nulo) values ('APC', 'Scallops - In Shell', 'A', 6, 4, null);
insert into Categoria (codigo, nombre, tipo, minimo, maximo, codigo_nulo) values ('ALB', 'Beans - Fava Fresh', 'A', 1, 7, null);
insert into Categoria (codigo, nombre, tipo, minimo, maximo, codigo_nulo) values ('TEN', 'Chicken - Whole', 'A', 2, 6, null);
insert into Categoria (codigo, nombre, tipo, minimo, maximo, codigo_nulo) values ('PFMT', 'Fingerling 4 Oz', 'A', 1,2 , null);
insert into Categoria (codigo, nombre, tipo, minimo, maximo, codigo_nulo) values ('BJZ', ' White', 'A', 1, 6, null);

/**/
INSERT INTO Universidad VALUES ('1','ECI','AK 45 (Autonorte) #205-59',NULL,NULL);
INSERT INTO Universidad VALUES ('2','Andes','Cra. 1 #18a-12',NULL,NULL);
INSERT INTO Universidad VALUES ('3','Javeriana', 'Cra. 7 #40 - 62',NULL,NULL);
INSERT INTO Universidad VALUES ('4','Militar','Cajica',NULL,NULL);
INSERT INTO Universidad VALUES ('5','Sabana','Chia',NULL,NULL);

/**/
insert into Usuario values (1, 1, 'CC', 'KSMF', 'Nerty Pickrill', 'sistemas','npickrill0@facebook.com', TO_DATE('2029/07/12','yyyy/mm/dd'), null, 1);
insert into Usuario values (4, 4, 'CC', 'KJCT', 'Aeriel Colebrook', 'sistemas', 'acolebrook3@t-online.de', TO_DATE('2029/07/12','yyyy/mm/dd'), null, 4);
insert into Usuario values (3, 3, 'TI', 'KCEF', 'Malinda Easum', 'sistemas', 'measum4@pen.io', TO_DATE('2029/07/12','yyyy/mm/dd'), null, 5);
insert into Usuario values (2, 2, 'CC', 'NZMO', 'Tuesday Bowry', 'sistemas', 'tbowry8@japanpost.jp', TO_DATE('2029/07/12','yyyy/mm/dd'), null, 9);
insert into Usuario values (5, 5, 'TI', 'MHLM', 'Everard Postans', 'sistemas', 'epostans9@t-online.de', TO_DATE('2029/07/12','yyyy/mm/dd'), null, 10);

/**/
insert into Articulo values (1, 'lomitos de atun x12', 'U', 'http://dyndns.org/augue/vel/accumsan.png', 100, 'true', 'APC', 1, 1);
insert into Articulo values (2,'lomitos de atun x10', 'N', 'https://163.com/duis/mattis/egestas/metus.png', 50, 'false', 'APC', 2, 2);
insert into Articulo values (3, 'lomitos de atun x5', 'U', 'https://theatlantic.com/montes/nascetur/ridiculus/mus/vivamus/vestibulum.png', 100, 'false', 'ALB', 3, 3);
insert into Articulo values (4, 'lomitos de atun x2', 'N', 'https://miitbeian.gov.cn/condimentum/id.png', 150, 'false', 'ALB', 4, 4);
insert into Articulo values (5, 'lomitos de atun x4', 'U', 'http://qq.com/nulla.png', 100, 'true', 'TEN', 5, 5);

/**/
INSERT INTO Caracteristica VALUES (1,'nutritivo');
INSERT INTO Caracteristica VALUES (2,'proteina');
INSERT INTO Caracteristica VALUES (3,'muy nutritivo');
INSERT INTO Caracteristica VALUES (4,'Altoproteina');
INSERT INTO Caracteristica VALUES (5,'Delicioso');

/**/
INSERT INTO Combo_Oferta VALUES (1,TO_DATE('2029/07/12','yyyy/mm/dd'),50,'https://dominio.pdf',NULL,'A','A','1','1');
INSERT INTO Combo_Oferta VALUES (2,TO_DATE('2034/11/30','yyyy/mm/dd'),100,'https://dominio.extensión/nomArch.pdf','','A','A','2','2');
INSERT INTO Combo_Oferta VALUES (3,TO_DATE('2034/11/30','yyyy/mm/dd'),200,'https://dominio.extensión/nomArch.pdf','','A','R','3','3');
INSERT INTO Combo_Oferta VALUES (4,TO_DATE('2034/11/30','yyyy/mm/dd'),100,'https://dominio.extensión/nomArch.pdf','','A','A','2','2');
INSERT INTO Combo_Oferta VALUES (5,TO_DATE('2034/11/30','yyyy/mm/dd'),200,'https://dominio.extensión/nomArch.pdf','','A','R','3','3');

/**/
INSERT INTO ArticuloXComboOferta VALUES (1,1);
INSERT INTO ArticuloXComboOferta VALUES (2,2);
INSERT INTO ArticuloXComboOferta VALUES (3,3);
INSERT INTO ArticuloXComboOferta VALUES (4,2);
INSERT INTO ArticuloXComboOferta VALUES (5,3);

/**/
insert into Califica  values (1, 1, 1, 4);
insert into Califica  values (2, 2, 2, 2);
insert into Califica  values (3, 3, 3, 3);
insert into Califica  values (4, 4, 4, 4);
insert into Califica  values (5, 5, 5, 5);


/* Registrar combo-ofertas*/
ALTER TABLE Universidad DROP CONSTRAINT FK_Universidad_Usuario_codigoUsuario;

/*Poblar*/
INSERT INTO Universidad  VALUES (123,'ECI','AK 45 (Autonorte) #205-59',1);
INSERT INTO Usuario values (1, 123, 'CC', 'KSMF', 'Nerty Pickrill', 'sistemas','npickrill0@facebook.com', TO_DATE('2029/07/12','yyyy/mm/dd'), null, 1);
INSERT INTO Combo_Oferta VALUES (1,TO_DATE('2029/07/12','yyyy/mm/dd'),50,'https://dominio.pdf',NULL,'O','A',1,123);
INSERT INTO Combo_Oferta VALUES (2,TO_DATE('2029/07/12','yyyy/mm/dd'),50,'https://dominio.pdf',NULL,'A','A',1,123);


------------------------------------------------------------------------------------------------------------------

/*PUNTO DOS. PREPARANDO CRUDs*/
/*CICLO 1: Registrar Combo_Oferta*/
/*CICLO 1: CRUD :COMBO_OFERTA*/
/*Ad*/

/*el número, fecha y estado de la combo-oferta es autogenerado*/
/*trueque inicia en desconocido*/
CREATE SEQUENCE numSeq_ComboOferta
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;



/
create or replace TRIGGER TR_COMBO_OFERTA_Insert_Auto
BEFORE INSERT ON Combo_oferta
FOR EACH ROW
BEGIN
    IF :NEW.numero IS NULL OR :NEW.fecha IS NULL OR :NEW.trueque IS NULL THEN
        :NEW.numero := numSeq_ComboOferta.NEXTVAL;
        :NEW.fecha := SYSDATE();
        :NEW.estado := 'O';
    END IF;
END;
/
/*trueque inicia en desconocido*/
create or replace TRIGGER TG_COMBO_OFERTA_Insert_Trueque
before INSERT ON COMBO_OFERTA
FOR EACH ROW
BEGIN
    if :new.trueque!=null THEN
        :new.trueque := NULL;
    END IF;
END;
/
/*el estado inicial de una oferta es oculta*/
CREATE OR REPLACE TRIGGER TR_COMBO_OFERTA_Insert_estado_oculto
BEFORE INSERT ON Combo_oferta
FOR EACH ROW  
BEGIN 
    IF :NEW.estado NOT LIKE 'O' THEN
        RAISE_APPLICATION_ERROR(-20003,'Debe ser de stado (O)culta');
    END IF;
END;
/
/*los artículos incluídos deben pertenecer al usuario*/
ALTER TABLE Combo_oferta DROP CONSTRAINT FK_ComboOferta_Usuario;
ALTER TABLE Combo_oferta ADD CONSTRAINT FK_ComboOferta_Usuario FOREIGN KEY (codigo_usuario,codigo_uni)
REFERENCES Usuario(codigo_usuario,codigo_uni) ON DELETE CASCADE;

/*los artículos incluídos deben estar disponibles*/
CREATE OR REPLACE TRIGGER TR_COMBO_OFERTA_Insert_disp
BEFORE INSERT ON Combo_oferta
FOR EACH ROW
DECLARE
    disp VARCHAR2(5);   
BEGIN 
    
    IF disp != 'true' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta DISPONIBLE');
    END IF;
END;
/

/*el precio debe ser inferior a la suma de los precios de los artículos*/
CREATE OR REPLACE TRIGGER TR_COMBO_OFERTA_Insert_precios
BEFORE INSERT ON Combo_oferta
FOR EACH ROW
DECLARE
    suma NUMBER;   
BEGIN 
    SELECT SUM(precio) INTO suma FROM Articulo where disponible = 'true';
    IF :NEW.precio < suma THEN
        RAISE_APPLICATION_ERROR(-20003,'El precio debe ser inferior a la suma de los precios de los artículos');
    END IF;
END;
/

/*Mo*/

/*El estado se puede modificar de oculta a abierta y de abierta a cancelada*/
CREATE OR REPLACE TRIGGER TR_COMBO_OFERTA_Modificar_Estado
BEFORE UPDATE ON Combo_oferta
FOR EACH ROW
BEGIN 
    IF :OLD.estado = 'O' AND :NEW.estado != 'A' THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede pasar a estado abierto');
    ELSIF :OLD.estado = 'A' AND :NEW.estado != 'C' THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede pasar a estado oculto');
    END IF;
END;
/
/* Sólo se pueden modificar todos los datos de la combo-oferta si está en estado oculta*/
CREATE OR REPLACE TRIGGER TR_COMBO_OFERTA_Modificar_EstadoOculta
BEFORE UPDATE ON Combo_oferta
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'O' THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede modificar si el estado es oculto');
    END IF;
END;
/
/*El*/
/*-Solo se puede eliminar las combo-ofertas ocultas*/

ALTER TABLE ArticuloXComboOferta DROP CONSTRAINT FK_ArticuloxComboOferta_Articulo;
ALTER TABLE ArticuloXComboOferta ADD CONSTRAINT FK_ArticuloxComboOferta_Articulo  FOREIGN KEY (id_articulo)
REFERENCES Articulo(id_articulo) ON DELETE CASCADE;

ALTER TABLE ArticuloXComboOferta DROP CONSTRAINT FK_ArticuloxComboOferta_ComboOferta;
ALTER TABLE ArticuloXComboOferta ADD CONSTRAINT FK_ArticuloxComboOferta_ComboOferta FOREIGN KEY (numero)
REFERENCES Combo_Oferta(numero) ON DELETE CASCADE;

create or replace TRIGGER TR_COMBO_OFERTA_Eliminar_EstadoEnOculta
BEFORE DELETE ON Combo_oferta
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'O' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta en estado oculto');
    END IF;
END;
/

/*Construccion */
/*CK_CALIFICACION_NOMBRE*/

SELECT ca.califica , nm.usuario
FROM estrellas es JOIN nombre nm ON (codigo_usuario, codigo_uni = codigo_usuario, codigo_uni)
ORDER BY califica asc

/*Mantener Categoria*/
/*validar eliminacion de categoria*/
create or replace TRIGGER validar_eliminacion_categor1a
Before DELETE ON Categoria
FOR EACH ROW
DECLARE
    num_articulos NUMBER;
BEGIN
    SELECT COUNT (*) INTO num_articulos FROM Articulos WHERE cod_categoria = :OLD.codigo;
    IF num_articulos > O THEN
        RAISE_APPLICATION_ERROR (-20002, "No se puede eliminar la categoria porque tiene articulos asociados:");
    END IF;
END;
/
/*Mantener Usuario*/

/*Ad*/
/*El codigo, programa es autogenerado segun los datos suministrados por la universidad*/


/*El tid y nid son dados por el usuario*/

----------------------------------------------------------------------------------------------------------------------------------
--Laboratorio 6-05-2023--
------------------------------------------------------A. Extendiendo. Usuarios----------------------------------------------------
--5. Escriban las instrucciones necesarias para importar los datos de esa tabla a su base de datos. Los datos deben insertados en las tablas de su base de datos, considerando:
    --Todos los usuarios pertenecen al Programa de Ingenier�a de Sistemas de la ESCUELA
    --Todos los usuarios tienen como fecha de registro el dia de hoy
    --Todas las personas tienen la c�dula como tipo de documento

ALTER TABLE Universidad DROP CONSTRAINT FK_Universidad_Usuario_codigoUsuario;
INSERT INTO Universidad VALUES (123,'ECI','AK 45 (Autonorte) #205-59',1);
INSERT INTO Usuario VALUES (1,123,'CC','1000000000','Persona Representante','Sistemas','npickrill0@facebook.com',TO_DATE('2023/01/12','yyyy/mm/dd'),null,0);
ALTER TABLE Universidad ADD CONSTRAINT FK_Universidad_Usuario_codigoUsuario FOREIGN KEY (codigo_usuario) REFERENCES Usuario(codigo_usuario);
INSERT INTO usuario(codigo_usuario, codigo_uni, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones)
    SELECT codigo,'123','CC',cedula, nombres,'Sistemas', email, SYSDATE,null,0
    from mbda.data WHERE cedula IN (SELECT DISTINCT cedula from mbda.data) 
    AND LENGTH(codigo)<11 AND LENGTH(email)<51 AND LENGTH(nombres)<51 AND LENGTH(cedula)<11 AND INSTR(email, '@') > 0 AND INSTR(email, '.') > 0 AND nombres is not null
    GROUP BY codigo, cedula, nombres, email HAVING COUNT(*) = 1 OR COUNT(*)=2 OR COUNT(*)=3 OR COUNT(*)=4;

------------------------------------------------------C. Modelo fisico. Componentes.----------------------------------------------------
/*1.Diseñe e implemente el paquete correspondiente al CRUD COMBO-OFERTAS (PC_COMBOOFERTAS)
En los paquetes deben incluir los subprogramas necesarios para atender los escenarios de l
caso de uso de funciones y los casos de uso de las consultas asociadas a este gran
concepto.*/

/*CRUDE*/
create or replace PACKAGE PC_COMBO_OFERTAS AS
PROCEDURE adicionar_Combo(cb_precio IN NUMBER, cb_foto IN VARCHAR, cb_descripcion IN VARCHAR,cb_estado IN VARCHAR, cb_trueque IN VARCHAR, cb_codigo_usuario IN VARCHAR, cb_codigo_uni IN VARCHAR);
PROCEDURE modificar_Combo(cb_numero IN NUMBER, cb_fecha IN DATE, cb_precio IN NUMBER, cb_foto IN VARCHAR, cb_descripcion IN VARCHAR,cb_estado IN VARCHAR, cb_trueque IN VARCHAR, cb_codigo_usuario IN VARCHAR, cb_codigo_uni IN VARCHAR);
PROCEDURE eliminar_Combo(cb_numero IN NUMBER);
PROCEDURE consulta_Combo_Estado(cb_estado IN VARCHAR);
END;
/

/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_COMBO_OFERTAS AS
  PROCEDURE adicionar_Combo(cb_precio IN NUMBER, cb_foto IN VARCHAR, cb_descripcion IN VARCHAR,cb_estado IN VARCHAR,cb_trueque IN VARCHAR, cb_codigo_usuario IN VARCHAR, cb_codigo_uni IN VARCHAR) IS
  BEGIN
    INSERT INTO combo_oferta VALUES (123,null,cb_precio,cb_foto,cb_descripcion,cb_estado,null,cb_codigo_usuario,cb_codigo_uni);
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;
  
  PROCEDURE modificar_Combo(cb_numero IN NUMBER, cb_fecha IN DATE, cb_precio IN NUMBER, cb_foto IN VARCHAR, cb_descripcion IN VARCHAR,cb_estado IN VARCHAR, cb_trueque IN VARCHAR, cb_codigo_usuario IN VARCHAR, cb_codigo_uni IN VARCHAR) IS
  BEGIN
    UPDATE Combo_Oferta
    SET fecha = cb_fecha, precio = cb_precio, foto = cb_foto, descripcion = cb_descripcion, estado = cb_estado, codigo_usuario = cb_codigo_usuario, codigo_uni = cb_codigo_uni
    WHERE numero=cb_numero;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo modificar la tupla, porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;
  
  PROCEDURE eliminar_Combo(cb_numero IN NUMBER) IS
  BEGIN
    DELETE FROM combo_oferta WHERE numero=cb_numero;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo eliminar la tupla porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;
  
  PROCEDURE consulta_Combo_Estado(cb_estado IN VARCHAR) IS
  suma NUMBER;
BEGIN
  SELECT COUNT(*) INTO suma FROM combo_oferta WHERE estado = cb_estado;
  DBMS_OUTPUT.PUT_LINE('Cantidad de filas: ' || suma);
END;

END PC_COMBO_OFERTAS;
/

/*XCRUD*/
DROP PACKAGE PC_combo_ofertas;
DROP PACKAGE PC_USUARIO;
DROP PACKAGE PC_USUARIO_JUNTA;

/*2. Prueben los paquetes construidos con los casos más significativos: 5 éxito y 3 de
fracaso*/
INSERT INTO Combo_Oferta VALUES (1,TO_DATE('2029/07/12','yyyy/mm/dd'),50,'https://dominio.pdf',NULL,'O','A',1,123);
INSERT INTO Combo_Oferta VALUES (2,TO_DATE('2029/07/12','yyyy/mm/dd'),50,'https://dominio.pdf',NULL,'A','A',1,123);
/*CRUDOK*/
BEGIN
    PC_COMBO_OFERTAS.adicionar_Combo(50,'https://dominio.pdf','KFC','O',null,1,123);
END;

BEGIN
    PC_COMBO_OFERTAS.adicionar_Combo(50,'https://dominio.pdf','Ferrari Negro','O',null,1,123);
END;

BEGIN
    PC_COMBO_OFERTAS.modificar_Combo(1, TO_DATE('2023-05-10', 'YYYY-MM-DD'), 50, 'https://dominio.pdf', 'TACO BELL', 'A', 'A', 1,123);
END;

BEGIN
    PC_COMBO_OFERTAS.eliminar_Combo(2);
END;

BEGIN
    PC_COMBO_OFERTAS.consulta_Combo_Estado('true');
END;

/*CRUDNOOK*/
/*Columna extra*/
BEGIN
    PC_COMBO_OFERTAS.adicionar_Combo(123,50,'https://dominio.pdf','KFC','O',null,1,123);
END;
/*Fila no existe*/
BEGIN
    PC_COMBO_OFERTAS.eliminar_Combo(45);
END;
/*Fila no existe*/
BEGIN
    PC_COMBO_OFERTAS.modificar_Combo(45, TO_DATE('2023-05-10', 'YYYY-MM-DD'), 50, 'https://dominio.pdf', 'TACO BELL', 'A', 'A', 1,123);
END;
------------------------------------------------------D. Modelo fisico. Seguridad.----------------------------------------------------
/*1. Disenien e implementen los paquetes que ofrezcan las operaciones válidas para cada uno
de los siguientes actores:*/
/*ActoresE*/
CREATE ROLE PA_JUNTAA;
CREATE ROLE PA_USUARIOO;


/*ActoresI*/
/
CREATE OR REPLACE PACKAGE PC_USUARIO AS
    PROCEDURE aniadirUsuario(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR, u_tid IN VARCHAR, u_nid IN VARCHAR, u_nombre IN VARCHAR,u_programa IN VARCHAR, u_correo IN VARCHAR, u_registro IN DATE,u_suspension IN DATE,u_nsuspensiones IN NUMBER);
END PC_USUARIO;
/
CREATE OR REPLACE PACKAGE PC_USUARIO_JUNTA AS
    PROCEDURE aniadirUsuarioJunta(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR, u_tid IN VARCHAR, u_nid IN VARCHAR, u_nombre IN VARCHAR,u_programa IN VARCHAR, u_correo IN VARCHAR, u_registro IN DATE,u_suspension IN DATE,u_nsuspensiones IN NUMBER);
    PROCEDURE modificarUsuario(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR, u_tid IN VARCHAR, u_nid IN VARCHAR, u_nombre IN VARCHAR,u_programa IN VARCHAR, u_correo IN VARCHAR,u_registro IN DATE,u_suspension IN DATE,u_nsuspensiones IN NUMBER);
    PROCEDURE eliminarUsuario(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR);
END PC_USUARIO_JUNTA;
/
CREATE OR REPLACE PACKAGE BODY PC_USUARIO_JUNTA AS
    PROCEDURE aniadirUsuarioJunta(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR, u_tid IN VARCHAR, u_nid IN VARCHAR, u_nombre IN VARCHAR,u_programa IN VARCHAR, u_correo IN VARCHAR, u_registro IN DATE, u_suspension IN DATE, u_nsuspensiones IN NUMBER) IS
    BEGIN
        INSERT INTO usuario VALUES(u_codigo_usuario,u_codigo_uni,u_tid,u_nid,u_nombre,u_programa,u_correo,u_registro,u_suspension,u_nsuspensiones);
        IF(SQL%ROWCOUNT = 0) THEN
            RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
    END;
    
    PROCEDURE modificarUsuario(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR, u_tid IN VARCHAR, u_nid IN VARCHAR, u_nombre IN VARCHAR,u_programa IN VARCHAR, u_correo IN VARCHAR, u_registro IN DATE, u_suspension IN DATE, u_nsuspensiones IN NUMBER) IS
    BEGIN
        UPDATE Usuario
        SET codigo_usuario = u_codigo_usuario, codigo_uni = u_codigo_uni,tid=u_tid,nid=u_nid,nombre=u_nombre,programa=u_programa, correo=u_correo,registro=u_registro,suspension=u_suspension,nSuspensiones=u_nsuspensiones
        WHERE codigo_usuario=u_codigo_uni AND codigo_uni=u_codigo_uni; 
        IF(SQL%ROWCOUNT = 0) THEN
            RAISE_APPLICATION_ERROR(-20001,'No se pudo modificar la tupla, no existe la tupla');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20999,SQLERRM);
    END;
    
    PROCEDURE eliminarUsuario(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR) IS
    BEGIN
        DELETE FROM Usuario WHERE codigo_usuario=u_codigo_uni AND codigo_uni=u_codigo_uni; 
        IF(SQL%ROWCOUNT = 0) THEN
            RAISE_APPLICATION_ERROR(-20001,'No se pudo eliminar la tupla porque no existe');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20999,SQLERRM);
    END;
END PC_USUARIO_JUNTA;
/
CREATE OR REPLACE PACKAGE BODY PC_USUARIO AS
    PROCEDURE aniadirUsuario(u_codigo_usuario IN VARCHAR, u_codigo_uni IN VARCHAR, u_tid IN VARCHAR, u_nid IN VARCHAR, u_nombre IN VARCHAR,u_programa IN VARCHAR, u_correo IN VARCHAR, u_registro IN DATE, u_suspension IN DATE, u_nsuspensiones IN NUMBER) IS
    BEGIN
        INSERT INTO usuario VALUES(u_codigo_usuario,u_codigo_uni,u_tid,u_nid,u_nombre,u_programa,u_correo,u_registro,u_suspension,u_nsuspensiones);
        IF(SQL%ROWCOUNT = 0) THEN
            RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
    END;
END PC_USUARIO;
/*2. Creen el rol de usuario, otorguen los permisos correspondientes a ese rol.
Asignense ese rol. Prueben la ejecución la cuenta diferente a la que usaron para crear la BD.*/
/
GRANT EXECUTE 
ON PC_USUARIO 
TO PA_USUARIO;
/
GRANT EXECUTE
ON PC_USUARIO_JUNTA
TO PA_JUNTA;
/
/*3. Creen el rol de analista de experiencia de usuario, otorguen los permisos
correspondientes a ese rol. Asumiendo que uno de sus compañeros de curso (no del equipo)
es el analista de experiencia de ususaio asígnenle ese rol. Prueben la ejecución desde esa
cuenta.*/
/*Seguridad*/
GRANT PA_USUARIOO
TO bd1000001781;
/*XSeguridad*/
REVOKE PA_USUARIOO
FROM bd1000001781;




