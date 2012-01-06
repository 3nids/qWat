/*
	qWat - QGIS Water Module
	
	SQL file :: print table and function
*/

/*----------------!!!---!!!----------------*/
BEGIN;
/* CREATE TABLE */
DROP TABLE IF EXISTS distribution.printable_maps CASCADE;
CREATE TABLE distribution.printable_maps (id serial NOT NULL);

ALTER TABLE distribution.printable_maps ADD COLUMN  short_name varchar(20);
ALTER TABLE distribution.printable_maps ADD COLUMN  long_name  text;
ALTER TABLE distribution.printable_maps ADD COLUMN  template  varchar(50);

SELECT AddGeometryColumn('distribution', 'printable_maps', 'wkb_geometry', 21781, 'POLYGON', 2);

/* ADD CONSTRAINTS */
/* primary key */
ALTER TABLE distribution.printable_maps ADD CONSTRAINT print_pkey PRIMARY KEY (id);

/* Comment */
COMMENT ON TABLE distribution.printable_maps IS 'This table is used for polygons for predefined printable maps. short_name would be used as label string, and long_mame would be used in the print composer.';


/*----------------!!!---!!!----------------*/
/* FUNCTION */
CREATE OR REPLACE FUNCTION distribution.get_map(geometry) RETURNS text AS '
	DECLARE
		geometry ALIAS FOR $1;
		result text;
	BEGIN
		SELECT left(distribution.tsum(printable_maps.short_name || '', ''),-2) INTO result
			FROM  distribution.printable_maps
			WHERE ST_Intersects(geometry,printable_maps.wkb_geometry) IS TRUE;
		RETURN result;
	END
' LANGUAGE 'plpgsql';
COMMENT ON FUNCTION distribution.get_map(geometry) IS 'Returns a string contaning all the short names of the polygons in table printable_maps which overlap the given geometry.';


CREATE OR REPLACE FUNCTION distribution.fill_pipes_map() RETURNS boolean AS '
	BEGIN
		UPDATE distribution.pipes SET _is_on_map = distribution.get_map(pipes.wkb_geometry);	
		RETURN true;
	END
' LANGUAGE 'plpgsql';
COMMENT ON FUNCTION distribution.fill_pipes_map() IS 'Populates the _is_on_map field in pipes table with all the short names of poylgons in table printable_maps which overlap the given pipe geometry.';

COMMIT;
