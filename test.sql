SELECT @@VERSION;
CREATE DATABASE db_SalesClothes;
USE db_SalesClothes;

/*==============================================================*/
/* Table: client                                                */
/*==============================================================*/
CREATE TABLE client
(
   id                   INT                  NOT NULL,
   type_document        CHAR(3)              NULL,
   number_document      CHAR(15)             NULL,
   names                VARCHAR(60)          NULL,
   last_name            VARCHAR(90)          NULL,
   email                VARCHAR(80)          NULL,
   cell_phone           CHAR(9)              NULL,
   birthdate            DATE                 NULL,
   active               BIT                  NULL,
   CONSTRAINT client_pk PRIMARY KEY (id)
);

/*==============================================================*/
/* Table: seller                                                */
/*==============================================================*/
CREATE TABLE seller
(
   id                   INT                  NOT NULL,
   type_document        CHAR(3)              NULL,
   number_document      CHAR(15)             NULL,
   names                VARCHAR(60)          NULL,
   last_name            VARCHAR(90)          NULL,
   salary               DECIMAL(8,2)         NULL,
   cell_phone           CHAR(9)              NULL,
   email                VARCHAR(80)          NULL,
   active               BIT                  NULL,
   CONSTRAINT seller_pk PRIMARY KEY (id)
);

/*==============================================================*/
/* Table: clothes                                               */
/*==============================================================*/
CREATE TABLE clothes
(
   id                   INT                  NOT NULL,
   descriptions         VARCHAR(60)          NULL,
   brand                VARCHAR(60)          NULL,
   amount               INT                  NULL,
   size                 VARCHAR(10)          NULL,
   price                DECIMAL(8,2)         NULL,
   active               BIT                  NULL,
   CONSTRAINT clothes_pk PRIMARY KEY (id)
);

/*==============================================================*/
/* Table: sale                                                  */
/*==============================================================*/
CREATE TABLE sale
(
   id                   INT                  NOT NULL,
   date_time            DATETIME             NULL,
   seller_id            INT                  NULL,
   client_id            INT                  NULL,
   active               BIT                  NULL,
   CONSTRAINT sale_pk PRIMARY KEY (id),
   CONSTRAINT sale_seller_fk FOREIGN KEY (seller_id)
      REFERENCES seller (id),
   CONSTRAINT sale_client_fk FOREIGN KEY (client_id)
      REFERENCES client (id)
);

/*==============================================================*/
/* Table: sale_detail                                           */
/*==============================================================*/
CREATE TABLE sale_detail
(
   id                   INT                  NOT NULL,
   sale_id              INT                  NULL,
   clothes_id           INT                  NULL,
   amount               INT                  NULL,
   CONSTRAINT sale_detail_pk PRIMARY KEY (id),
   CONSTRAINT detail_sale_fk FOREIGN KEY (sale_id)
      REFERENCES sale (id),
   CONSTRAINT detail_clothes_fk FOREIGN KEY (clothes_id)
      REFERENCES clothes (id)
);

/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
   ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
      REFERENCES client (id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
GO


/* Eliminar una relación */
ALTER TABLE sale
   DROP CONSTRAINT sale_client
GO

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT
   fk.name [Constraint],
   OBJECT_NAME(fk.parent_object_id) [Tabla],
   COL_NAME(fc.parent_object_id, fc.parent_column_id) [Columna FK],
   OBJECT_NAME(fk.referenced_object_id) AS [Tabla base],
   COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM
   sys.foreign_keys fk
   INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO


/* Relacionar la tabla 'sale' con 'client' */
ALTER TABLE sale
   ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
      REFERENCES client (id);
GO

/* Relacionar la tabla 'sale' con 'seller' */
ALTER TABLE sale
   ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
      REFERENCES seller (id);
GO

/* Relacionar la tabla 'sale_detail' con 'clothes' */
ALTER TABLE sale_detail
   ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
      REFERENCES clothes (id);
GO

/* Relacionar la tabla 'sale_detail' con 'sale' */
ALTER TABLE sale_detail
   ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
      REFERENCES sale (id);
GO


/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT
   fk.name AS [Constraint],
   OBJECT_NAME(fk.parent_object_id) AS [Tabla],
   COL_NAME(fc.parent_object_id, fc.parent_column_id) AS [Columna FK],
   OBJECT_NAME(fk.referenced_object_id) AS [Tabla base],
   COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM
   sys.foreign_keys AS fk
   INNER JOIN sys.foreign_key_columns AS fc ON fk.OBJECT_ID = fc.constraint_object_id
ORDER BY
   fk.name;
GO

DROP DATABASE db_SalesClothes;
GO
USE master;

ALTER DATABASE db_SalesClothes
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO