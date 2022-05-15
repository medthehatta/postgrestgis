CREATE OR REPLACE FUNCTION api.singlegeojsonparam(single_param json) RETURNS json

    LANGUAGE sql
    AS $_$
    SELECT single_param;

$_$;

CREATE OR REPLACE FUNCTION api.calc_length(linestring json) RETURNS numeric AS $$

    SELECT ST_Length(
        ST_Transform(ST_GeomFromGeoJSON(linestring), 54030)
    )/1000

$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION api.calc_area(featurecollection json) RETURNS numeric AS $$

    SELECT CAST(
      ST_Area(
        ST_GeomFromGeoJSON(
          featurecollection->'features'->0->'geometry'
        )
      ) AS numeric
    )

$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION api.calc_intersection(featurecollection json) RETURNS json AS $$

      SELECT ST_AsGeoJSON(
        ST_Intersection(
          ST_GeomFromGeoJSON(
            featurecollection->'features'->0->'geometry'
          ),
          ST_GeomFromGeoJSON(
            featurecollection->'features'->1->'geometry'
          )
        )
      )::json;

$$ LANGUAGE SQL;
