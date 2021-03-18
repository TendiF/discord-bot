-- Adminer 4.7.7 PostgreSQL dump

DROP TABLE IF EXISTS "items";
DROP SEQUENCE IF EXISTS items_id_seq;
CREATE SEQUENCE items_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "trade_sch"."items" (
    "id" integer DEFAULT nextval('items_id_seq') NOT NULL,
    "id_user" integer NOT NULL,
    "name" text NOT NULL,
    "qty" integer NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "items_id" PRIMARY KEY ("id"),
    CONSTRAINT "items_id_user_fkey" FOREIGN KEY (id_user) REFERENCES users(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "items" ("id", "id_user", "name", "qty", "created_at") VALUES
(1,	1,	'fish',	50,	'2021-03-18 14:48:04.010418'),
(2,	2,	'gold',	500,	'2021-03-18 14:48:20.890658');

DROP TABLE IF EXISTS "offers";
DROP SEQUENCE IF EXISTS offers_id_seq;
CREATE SEQUENCE offers_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "trade_sch"."offers" (
    "id" integer DEFAULT nextval('offers_id_seq') NOT NULL,
    "id_item" integer NOT NULL,
    "id_trade" integer NOT NULL,
    "qty" smallint NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "offers_id" PRIMARY KEY ("id"),
    CONSTRAINT "offers_id_item_fkey" FOREIGN KEY (id_item) REFERENCES items(id) NOT DEFERRABLE,
    CONSTRAINT "offers_id_trade_fkey" FOREIGN KEY (id_trade) REFERENCES trades(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "offers" ("id", "id_item", "id_trade", "qty", "created_at") VALUES
(1,	1,	1,	5,	'2021-03-18 14:51:33.401808'),
(2,	2,	1,	10,	'2021-03-18 14:52:07.379464');

DROP TABLE IF EXISTS "trades";
DROP SEQUENCE IF EXISTS id_trade_id_seq;
CREATE SEQUENCE id_trade_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "trade_sch"."trades" (
    "id" integer DEFAULT nextval('id_trade_id_seq') NOT NULL,
    "created_by" integer NOT NULL,
    "id_user" integer NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "status" text DEFAULT 'ENUM (''created'', ''executed'', ''cancel'')' NOT NULL,
    "executed_at" timestamp,
    CONSTRAINT "trades_id" PRIMARY KEY ("id"),
    CONSTRAINT "trades_created_by_fkey" FOREIGN KEY (created_by) REFERENCES users(id) NOT DEFERRABLE,
    CONSTRAINT "trades_id_user_fkey" FOREIGN KEY (id_user) REFERENCES users(id) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "trades" ("id", "created_by", "id_user", "created_at", "status", "executed_at") VALUES
(2,	2,	1,	'2021-03-18 14:51:04.326793',	'created',	NULL),
(1,	1,	2,	'2021-03-16 14:51:04.326793',	'cancel',	NULL);

DROP TABLE IF EXISTS "users";
DROP SEQUENCE IF EXISTS users_id_seq;
CREATE SEQUENCE users_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "trade_sch"."users" (
    "id" integer DEFAULT nextval('users_id_seq') NOT NULL,
    "name" text NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "users_id" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "users" ("id", "name", "created_at") VALUES
(1,	'user 1 ',	'2021-03-18 14:47:13.472066'),
(2,	'user 2',	'2021-03-18 14:47:19.66731');

-- 2021-03-18 15:30:36.883424+00