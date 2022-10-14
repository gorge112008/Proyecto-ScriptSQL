CREATE SCHEMA IF NOT EXISTS proyecto_restaurante;
USE proyecto_restaurante ;

CREATE TABLE IF NOT EXISTS gerente (
  ID_GERENTE INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombreGerente VARCHAR(32) NOT NULL,
  apellidoGerente VARCHAR(32) NOT NULL,
  rucGerente VARCHAR(11) NOT NULL,
  dniGerente INT(8) NOT NULL,
  emailGerente VARCHAR(32) NOT NULL,
  celularGerente INT(9) NOT NULL
  );
  
  CREATE TABLE IF NOT EXISTS tipo_contrato (
  ID_TIPO_CONTRATO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cantidadMesesContrato INT NOT NULL,
  MensualPagoContrato INT NOT NULL,
  TotalPagoContrato INT NOT NULL
  );
  
  CREATE TABLE IF NOT EXISTS contrato(
  ID_CONTRATO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FK_ID_GERENTE INT NOT NULL,
  FK_TIPO_CONTRATO INT NOT NULL,
  fechaInicioContrato DATE NOT NULL,
  FOREIGN KEY(FK_TIPO_CONTRATO) REFERENCES tipo_contrato (ID_TIPO_CONTRATO),
  FOREIGN KEY(FK_ID_GERENTE) REFERENCES gerente (ID_GERENTE)
  );
  
  CREATE TABLE IF NOT EXISTS proveedor (
  ID_PROVEEDOR INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombreProveedor VARCHAR(45) NOT NULL,
  rucProveedor VARCHAR(11) NOT NULL,
  celularProveedor INT(9) NOT NULL,
  FK_ID_CONTRATO INT NOT NULL,
  FOREIGN KEY (FK_ID_CONTRATO) REFERENCES contrato(ID_CONTRATO)
  );
  
  CREATE TABLE IF NOT EXISTS bebida(
  ID_BEBIDA INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombreBebida VARCHAR(45) NOT NULL,
  detalleBebida VARCHAR(100) NOT NULL,
  precioBebida DOUBLE NOT NULL,
  stockBebida INT NOT NULL,
  FK_ID_PROVEEDOR INT NOT NULL,
  FOREIGN KEY (FK_ID_PROVEEDOR) REFERENCES proveedor (ID_PROVEEDOR)
  );
  
  CREATE TABLE IF NOT EXISTS cliente (
  ID_CLIENTE INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  nombreCliente VARCHAR(45) NOT NULL,
  apellidoCliente VARCHAR(45) NOT NULL,
  dniCliente INT(8) NOT NULL,
  rucCliente VARCHAR(11) NOT NULL,
  celularCliente INT(9) NULL DEFAULT NULL,
  correoCliente VARCHAR(45) NULL DEFAULT NULL,
  direccionCliente VARCHAR(45) NULL DEFAULT NULL
  );
  
  CREATE TABLE IF NOT EXISTS cocinero (
  ID_COCINERO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombreCocinero VARCHAR(45) NOT NULL,
  apellidoCocinero VARCHAR(45) NOT NULL,
  dniCocinero INT(8) NOT NULL,
  celularCocinero INT(9) NULL DEFAULT NULL,
  FK_ID_CONTRATO INT NOT NULL,
  FOREIGN KEY (FK_ID_CONTRATO) REFERENCES contrato (ID_CONTRATO)
  );
  
  CREATE TABLE IF NOT EXISTS insumo (
  ID_INSUMO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombreInsumo VARCHAR(25) NOT NULL,
  stockInsumo INT NOT NULL,
  precioInsumo DOUBLE NOT NULL,
  FK_ID_PROVEEDOR INT NOT NULL,
  FOREIGN KEY (FK_ID_PROVEEDOR) REFERENCES proveedor (ID_PROVEEDOR)
  );
  
  CREATE TABLE IF NOT EXISTS cocina (
  ID_COCINA INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FK_ID_COCINERO INT NOT NULL,
  FK_ID_INSUMO INT NOT NULL,
  tiempoCocina INT NOT NULL,
  recetaComida VARCHAR(250) NOT NULL,
  FOREIGN KEY (FK_ID_COCINERO) REFERENCES cocinero (ID_COCINERO),
  FOREIGN KEY (FK_ID_INSUMO) REFERENCES insumo (ID_INSUMO)
  );
  
  CREATE TABLE IF NOT EXISTS comida (
  ID_COMIDA INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombreComida VARCHAR(45) NOT NULL,
  detalleComida VARCHAR(250) NOT NULL,
  precioComida INT NOT NULL,
  StockComida INT NOT NULL,
  FK_ID_COCINA INT NOT NULL,
  FOREIGN KEY (FK_ID_COCINA) REFERENCES cocina (ID_COCINA)
  );
  
  CREATE TABLE IF NOT EXISTS comprobante_pago (
  ID_COMPROBANTE_PAGO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipoComprobantePago VARCHAR(45) NOT NULL
  );
  
  CREATE TABLE IF NOT EXISTS mesero (
  ID_MESERO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombreMesero VARCHAR(45) NOT NULL,
  apellidoMesero VARCHAR(45) NOT NULL,
  dniMesero INT(8) NOT NULL,
  celularMesero INT(9) NULL DEFAULT NULL,
  FK_ID_CONTRATO INT NOT NULL,
  FOREIGN KEY (FK_ID_CONTRATO) REFERENCES contrato (ID_CONTRATO)
  );
  
  CREATE TABLE IF NOT EXISTS metodo_pago (
  ID_METODO_PAGO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipoMetodoPago VARCHAR(20) NOT NULL
  );
   
  CREATE TABLE IF NOT EXISTS pedido (
  ID_PEDIDO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FK_ID_CLIENTE INT NOT NULL,
  FK_ID_MESERO INT NOT NULL,
  costoTotalPedido INT NOT NULL,
  fechaPedido DATE NOT NULL,
  FK_ID_COMIDA INT NOT NULL,
  FK_ID_BEBIDA INT NOT NULL,
  FOREIGN KEY (FK_ID_BEBIDA) REFERENCES bebida (ID_BEBIDA),
  FOREIGN KEY (FK_ID_CLIENTE) REFERENCES cliente (ID_CLIENTE),
  FOREIGN KEY (FK_ID_COMIDA) REFERENCES comida (ID_COMIDA),
  FOREIGN KEY (FK_ID_MESERO) REFERENCES mesero (ID_MESERO)
  );
  
  CREATE TABLE IF NOT EXISTS reporte (
  ID_REPORTE INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FK_ID_COMPROBANTE INT NOT NULL,
  FK_ID_METODO_PAGO INT NOT NULL,
  FK_ID_PEDIDO INT NOT NULL,
  detalleReporte VARCHAR(255) NULL DEFAULT NULL,
  FOREIGN KEY (FK_ID_COMPROBANTE) REFERENCES comprobante_pago (ID_COMPROBANTE_PAGO),
  FOREIGN KEY (FK_ID_METODO_PAGO) REFERENCES metodo_pago (ID_METODO_PAGO),
  FOREIGN KEY (FK_ID_PEDIDO) REFERENCES pedido (ID_PEDIDO)
  );

INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (1,'Luis','Gomez Ramirez',51395312,'10513953121',970184213,'luigom@gmail.com','Chimbote');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (2,'Cynthia','Ramirez Medina',73124214,'10731242142',995512462,'cyntra2@hotmail.com','Casma');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (3,'Ana','Cueva Vasquez',84312572,'10843125721',995139455,'anacue@hotmail.com','Samanco');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (4,'Randy','Briones Oliva',43678343,'10436783432',963105831,'randbrion@gmail.com','Moro');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (5,'Roxana','Bocanegra Castillo',17569726,'10175697262',995712342,'roxboc@hotmail.com','Lima');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (6,'Lucas','Zarate Moreno',97493792,'10974937921',963143852,'lucza@hotmail.com','Chiclayo');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (7,'Jose','Gomero Rey',19358069,'10193580692',655974358,'josegome@hotmail.com','Piura');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (8,'Marcos','Villavicencio Rincon',75114898,'10751148981',809397822,'marcovill@hotmail.com','Trujillo');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (9,'Julieta','Maldonado Lorente',88521493,'10885214932',544572648,'juliemal@hotmail.com','Lima');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (10,'Gabriel','Sarmiento Velasco',79661582,'10796615822',677673051,'gabrisar@gmail.com','Trujillo');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (11,'Rafaela','Riquelme Salmeron',94756613,'10947566131',736536263,'rafarique@gmail.com','Casma');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (12,'Isabel','Ledezma Carrasco',94756613,'10947566130',449281653,'isalede@hotmail.com','Lima');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (13,'Norma','Guevara Caballero',15670288,'10156702882',910519205,'normague@hotmail.com','Moro');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (14,'Jorge','Cervantes Barroso',15670288,'10156702882',943457396,'jorgecerva@gmail.com','Lima');
INSERT INTO cliente (`ID_CLIENTE`,`nombreCliente`,`apellidoCliente`,`dniCliente`,`rucCliente`,`celularCliente`,`correoCliente`,`direccionCliente`) VALUES (15,'Paola','Ochoa Vives',63743363,'10637433631',983895051,'paolaocho@hotmail.com','Trujillo');

INSERT INTO gerente (`ID_GERENTE`,`nombreGerente`,`apellidoGerente`,`rucGerente`,`dniGerente`,`emailGerente`,`celularGerente`) VALUES (1,'Vilma','Chancafe Chu','1012432133',70234235,'vimacha@hotmail.com',31356234);

INSERT INTO tipo_contrato (`ID_TIPO_CONTRATO`,`cantidadMesesContrato`,`MensualPagoContrato`,`TotalPagoContrato`) VALUES (1,1,1000,1000);
INSERT INTO tipo_contrato (`ID_TIPO_CONTRATO`,`cantidadMesesContrato`,`MensualPagoContrato`,`TotalPagoContrato`) VALUES (2,3,1500,4500);
INSERT INTO tipo_contrato (`ID_TIPO_CONTRATO`,`cantidadMesesContrato`,`MensualPagoContrato`,`TotalPagoContrato`) VALUES (3,6,2000,12000);

INSERT INTO contrato (`ID_CONTRATO`,`FK_ID_GERENTE`,`FK_TIPO_CONTRATO`,`fechaInicioContrato`) VALUES (1,1,1,'2022-10-01');
INSERT INTO contrato (`ID_CONTRATO`,`FK_ID_GERENTE`,`FK_TIPO_CONTRATO`,`fechaInicioContrato`) VALUES (2,1,2,'2022-10-01');
INSERT INTO contrato (`ID_CONTRATO`,`FK_ID_GERENTE`,`FK_TIPO_CONTRATO`,`fechaInicioContrato`) VALUES (3,1,3,'2022-10-01');

INSERT INTO proveedor (`ID_PROVEEDOR`,`nombreProveedor`,`rucProveedor`,`celularProveedor`,`FK_ID_CONTRATO`) VALUES (1,'PALMA','10324523411',984718211,3);
INSERT INTO proveedor (`ID_PROVEEDOR`,`nombreProveedor`,`rucProveedor`,`celularProveedor`,`FK_ID_CONTRATO`) VALUES (2,'BACKUS S.A.','20100113610',3113000,3);
INSERT INTO proveedor (`ID_PROVEEDOR`,`nombreProveedor`,`rucProveedor`,`celularProveedor`,`FK_ID_CONTRATO`) VALUES (3,'ARQUI','10458124191',988312312,3);
INSERT INTO proveedor (`ID_PROVEEDOR`,`nombreProveedor`,`rucProveedor`,`celularProveedor`,`FK_ID_CONTRATO`) VALUES (4,'QUIJANDRIA','10571294281',970129381,3);
INSERT INTO proveedor (`ID_PROVEEDOR`,`nombreProveedor`,`rucProveedor`,`celularProveedor`,`FK_ID_CONTRATO`) VALUES (5,'SANTOS','10394912831',963182812,3);
INSERT INTO proveedor (`ID_PROVEEDOR`,`nombreProveedor`,`rucProveedor`,`celularProveedor`,`FK_ID_CONTRATO`) VALUES (6,'ANTEROS','10218347191',972131482,3);

INSERT INTO cocinero (`ID_COCINERO`,`nombreCocinero`,`apellidoCocinero`,`dniCocinero`,`celularCocinero`,`FK_ID_CONTRATO`) VALUES (1,'Cristina','Araujo Molina',52343351,962564423,2);
INSERT INTO cocinero (`ID_COCINERO`,`nombreCocinero`,`apellidoCocinero`,`dniCocinero`,`celularCocinero`,`FK_ID_CONTRATO`) VALUES (2,'Roxana','Gomez Rivera',12323433,956342345,2);
INSERT INTO cocinero (`ID_COCINERO`,`nombreCocinero`,`apellidoCocinero`,`dniCocinero`,`celularCocinero`,`FK_ID_CONTRATO`) VALUES (3,'Ilda','Castro Galvez',97334223,945131521,2);
INSERT INTO cocinero (`ID_COCINERO`,`nombreCocinero`,`apellidoCocinero`,`dniCocinero`,`celularCocinero`,`FK_ID_CONTRATO`) VALUES (4,'Rocio','Palacios Reyes',65234597,956234235,2);

INSERT INTO mesero (`ID_MESERO`,`nombreMesero`,`apellidoMesero`,`dniMesero`,`celularMesero`,`FK_ID_CONTRATO`) VALUES (1,'Nilda','Guerrero Milla',80234122,978424624,1);
INSERT INTO mesero (`ID_MESERO`,`nombreMesero`,`apellidoMesero`,`dniMesero`,`celularMesero`,`FK_ID_CONTRATO`) VALUES (2,'Claudia','Roque Valdez',12732357,970365244,1);
INSERT INTO mesero (`ID_MESERO`,`nombreMesero`,`apellidoMesero`,`dniMesero`,`celularMesero`,`FK_ID_CONTRATO`) VALUES (3,'Jorge','Ugarte Medina',97351823,995662462,1);
INSERT INTO mesero (`ID_MESERO`,`nombreMesero`,`apellidoMesero`,`dniMesero`,`celularMesero`,`FK_ID_CONTRATO`) VALUES (4,'Daniel','Guerra Alves',12463827,951245125,1);
INSERT INTO mesero (`ID_MESERO`,`nombreMesero`,`apellidoMesero`,`dniMesero`,`celularMesero`,`FK_ID_CONTRATO`) VALUES (5,'Mayerli','Fuentes Roble',35723336,996456241,1);

INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (1,'Inca Kola','Inca Kola 0.5L',4.00,18,1);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (2,'Inca Kola','Inca Kola 0.5L Gordita',5.00,24,1);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (3,'Inca Kola','Inca Kola 1L',8.00,36,1);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (4,'Coca Cola','Coca Cola 0.5L',4.00,18,1);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (5,'Coca Cola','Coca Cola 1L',8.00,36,1);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (6,'Pilsen','Cerveza Pilsen Callao',9.00,48,2);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (7,'Cristal','Cerveza Cristal',9.00,36,2);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (8,'Cusquenia','Cerveza Cusquenia Dorad',9.00,24,2);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (9,'Cusquenia','Cerveza Cusquenia Negr',9.00,48,2);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (10,'Cusquenia','Cerveza Cusquenia de Trig',9.00,48,2);
INSERT INTO bebida (`ID_BEBIDA`,`nombreBebida`,`detalleBebida`,`precioBebida`,`stockBebida`,`FK_ID_PROVEEDOR`) VALUES (11,'Guarana','Guarana 0.5L',4.00,18,1);

INSERT INTO insumo (`ID_INSUMO`,`nombreInsumo`,`stockInsumo`,`precioInsumo`,`FK_ID_PROVEEDOR`) VALUES (1,'Cuy entero',120,19,3);
INSERT INTO insumo (`ID_INSUMO`,`nombreInsumo`,`stockInsumo`,`precioInsumo`,`FK_ID_PROVEEDOR`) VALUES (2,'Chancho kg',60,22,6);
INSERT INTO insumo (`ID_INSUMO`,`nombreInsumo`,`stockInsumo`,`precioInsumo`,`FK_ID_PROVEEDOR`) VALUES (3,'Res kg',30,17,5);
INSERT INTO insumo (`ID_INSUMO`,`nombreInsumo`,`stockInsumo`,`precioInsumo`,`FK_ID_PROVEEDOR`) VALUES (4,'Pollo entero',30,25,4);
  
INSERT INTO cocina (`ID_COCINA`,`FK_ID_COCINERO`,`FK_ID_INSUMO`,`tiempoCocina`,`recetaComida`) VALUES (1,2,1,10,'Medio Cuy frito durante 10 minutos aderezado con aji amarillo. Acompañado de arroz y ajiaco de papas');
INSERT INTO cocina (`ID_COCINA`,`FK_ID_COCINERO`,`FK_ID_INSUMO`,`tiempoCocina`,`recetaComida`) VALUES (2,1,2,5,'8 presas de chancho fritas durante 5 minutos aderezadas en ajo. Acompañada de yuca-mote y camote');
INSERT INTO cocina (`ID_COCINA`,`FK_ID_COCINERO`,`FK_ID_INSUMO`,`tiempoCocina`,`recetaComida`) VALUES (3,4,3,15,'Bisteck de res frito durante 15 minutos aderezado con vinagre blanco. Acompañado de arroz y papas fritas');
INSERT INTO cocina (`ID_COCINA`,`FK_ID_COCINERO`,`FK_ID_INSUMO`,`tiempoCocina`,`recetaComida`) VALUES (4,3,4,10,'Bisteck de pollo frito durante 10 minutos. Acompañado de arroz y papas fritas');

INSERT INTO comida (`ID_COMIDA`,`nombreComida`,`detalleComida`,`precioComida`,`StockComida`,`FK_ID_COCINA`) VALUES (1,'Picante de Cuy','Medio cuy frito, con o sin aderezo, guarnición de ajiaco de papas y arroz blanco',37,240,1);
INSERT INTO comida (`ID_COMIDA`,`nombreComida`,`detalleComida`,`precioComida`,`StockComida`,`FK_ID_COCINA`) VALUES (2,'Chicharron de Cerdo','Costillas y  pulpa de cerdo fritas, con guarnición de choclo desgranado, yuca sancochada, camote sancochado y zarza criolla',31,120,2);
INSERT INTO comida (`ID_COMIDA`,`nombreComida`,`detalleComida`,`precioComida`,`StockComida`,`FK_ID_COCINA`) VALUES (3,'Bisteck de Res','Cadera de res frita con guarnición de papas fritas, arroz blanco y ensalada.',31,90,3);
INSERT INTO comida (`ID_COMIDA`,`nombreComida`,`detalleComida`,`precioComida`,`StockComida`,`FK_ID_COCINA`) VALUES (4,'Milanesa de Pollo','Pechuga de pollo frito pasado por huevo y galleta molida, con guarnición de papas fritas, arroz blanco, ensalada y zarza criolla',27,60,4);

INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (1,2,2,36,'2022-10-02',4,6);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (2,14,3,42,'2022-10-02',1,2);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (3,12,1,40,'2022-10-03',3,7);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (4,1,2,34,'2022-10-04',3,1);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (5,13,4,39,'2022-10-04',2,3);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (6,6,5,41,'2022-10-05',1,11);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (7,4,1,40,'2022-10-06',3,6);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (8,5,4,45,'2022-10-07',1,5);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (9,11,2,36,'2022-10-08',4,10);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (10,8,3,36,'2022-10-09',2,2);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (11,10,2,41,'2022-10-10',1,1);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (12,15,1,36,'2022-10-11',4,6);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (13,9,5,36,'2022-10-12',3,2);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (14,3,4,40,'2022-10-13',2,8);
INSERT INTO pedido (`ID_PEDIDO`,`FK_ID_CLIENTE`,`FK_ID_MESERO`,`costoTotalPedido`,`fechaPedido`,`FK_ID_COMIDA`,`FK_ID_BEBIDA`) VALUES (15,7,3,40,'2022-10-14',3,10);

INSERT INTO metodo_pago (`ID_METODO_PAGO`,`tipoMetodoPago`) VALUES (1,'Efectivo');
INSERT INTO metodo_pago (`ID_METODO_PAGO`,`tipoMetodoPago`) VALUES (2,'Visa');
INSERT INTO metodo_pago (`ID_METODO_PAGO`,`tipoMetodoPago`) VALUES (3,'Yape');
INSERT INTO metodo_pago (`ID_METODO_PAGO`,`tipoMetodoPago`) VALUES (4,'Plin');
INSERT INTO metodo_pago (`ID_METODO_PAGO`,`tipoMetodoPago`) VALUES (5,'Transferencia');

INSERT INTO comprobante_pago (`ID_COMPROBANTE_PAGO`,`tipoComprobantePago`) VALUES (1,'Boleta Electronica');
INSERT INTO comprobante_pago (`ID_COMPROBANTE_PAGO`,`tipoComprobantePago`) VALUES (2,'Factura Electronica');

INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (1,1,4,1,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (2,1,1,2,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (3,1,1,3,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (4,2,4,4,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (5,1,1,5,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (6,1,2,6,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (7,2,1,7,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (8,1,1,8,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (9,2,3,9,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (10,2,3,10,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (11,1,1,11,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (12,2,4,12,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (13,2,2,13,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (14,1,4,14,NULL);
INSERT INTO reporte (`ID_REPORTE`,`FK_ID_COMPROBANTE`,`FK_ID_METODO_PAGO`,`FK_ID_PEDIDO`,`detalleReporte`) VALUES (15,2,1,15,NULL);