PostGIS with PostgREST
======================

Dockerization of the steps from:

https://gis-ops.com/postgrest-postgis-api-tutorial-geospatial-api-in-5-minutes/


Get started
-----------

Start the containers:

```bash
docker-compose up -d
```

Perform the initial setup (can't do this during container build because the DB
isn't fully operational yet):

```bash
docker exec -it postgrestgis-db-1 su -c "psql -d gis -f /scripts/setup.sql" postgres
```

Tips
----

If you want to populate some "starter" functions:

```bash
docker exec -it postgrestgis-db-1 su -c "psql -d gis -f /scripts/functions.sql" postgres
```

Example PostgREST call (need the "starter" functions from above):

```bash
curl -w"\n" -d@- -X POST -H "Prefer: params=single-object" -H "Content-Type: application/json" "http://localhost:3000/rpc/singlegeojsonparam" <<EOF
{
    "type":"FeatureCollection",
    "features":[
        {
            "type":"Feature",
            "geometry":{
                "type":"Polygon",
                "coordinates":[[[100.0,0.0],[101.0,0.0],100.0,0.0]]]},
                "properties":{"prop0":"value1","prop1":{"this":"that"}
            }
        },
        {
            "type":"Feature",
            "geometry":{
                "type":"Polygon",
                "coordinates":[[[100.0,0.0],[101.0,0.0],[100.0,1.0],[100.0,0.0]]]
            },
            "properties":{"prop0":"value2","prop1":{"this":"that"}}
        }
    ]
}
EOF
```

If you want to gain psql access:

```bash
docker exec -it postgrestgis-db-1 su -c psql postgres
```

Maintainer
----------

Med Mahmoud <medthehatta@gmail.com>
