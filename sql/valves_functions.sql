/*
	qWat - QGIS Water Module
	
	SQL file :: valves_function table
*/
BEGIN;

DROP TABLE IF EXISTS distribution.valves_function CASCADE;
CREATE TABLE distribution.valves_function ( id SERIAL, CONSTRAINT "valves_function_pk" PRIMARY KEY (id));                          

/* Columns*/
ALTER TABLE distribution.valves_function ADD COLUMN "function" VARCHAR(30);

/* Constraints*/
ALTER TABLE distribution.valves_function ADD CONSTRAINT unique_function UNIQUE ("function");

/* Comment */
COMMENT ON TABLE distribution.valves_function IS 'Types of valves';

INSERT INTO distribution.valves_function ( function ) VALUES ('vanne de régulation');    /* 1  REG' */
INSERT INTO distribution.valves_function ( function ) VALUES ('ventouse');               /* 2  VE   */
INSERT INTO distribution.valves_function ( function ) VALUES ('vanne by-pass');          /* 3  VBP  */
INSERT INTO distribution.valves_function ( function ) VALUES ('vanne d''ouvrage');       /* 4  OUV  */
INSERT INTO distribution.valves_function ( function ) VALUES ('organe abonné');          /* 5  OA   */
INSERT INTO distribution.valves_function ( function ) VALUES ('prise de secours');       /* 6  SEC  */
INSERT INTO distribution.valves_function ( function ) VALUES ('vanne incendie');         /* 7  VIN  */
INSERT INTO distribution.valves_function ( function ) VALUES ('vanne d''hydrant');       /* 8  VH   */
INSERT INTO distribution.valves_function ( function ) VALUES ('inconnu');                /* 9 I     */
INSERT INTO distribution.valves_function ( function ) VALUES ('vidange');                /* 10 VID  */
INSERT INTO distribution.valves_function ( function ) VALUES ('organe réseau');          /* 11 VR   */
INSERT INTO distribution.valves_function ( function ) VALUES ('vidange-ventouse');       /* 12 VIVE */

COMMIT;
