## Steps to reproduce

- Download OSM data
- Install PostGres with PostGIS extension: `brew install postgresql` `brew install postgis`
- Convert OSM data into Postgres Tables: `osm2pgsql -c -d db_name -U user_name -W -H localhost osm_file` `osm2pgrouting --f osm_file -conf mapconfig.xml --dbname db_name  --username usen_name --clean --password pass`
- Alternatively, you can load in the tables in the databases folder using the command: `psql -U username -d database_name -f /path/to/dumpfile.sql`


## Databases

Use the following databases (change in the benchmark script) depending on the query you are running:

- query1: planet_osm_point
- query2: ways
- query3: ways,configuration
- query4: ways
- query5: planet_osm_point

### Benchmarking

- To run benchmarks, run `python bench.py` Comment out the queries you don't want to run.
- Modify the `num_runs` variable in `bench.py` to change the number of times you want to run the query.

### Reference

- [OSM Data Model](https://wiki.openstreetmap.org/wiki/Elements)
- [POSTGIS Reference](https://postgis.net/documentation/)
- [OSM2pgsql](https://pgrouting.org/docs/tools/osm2pgrouting.html)
- [MapConfig.xml source](https://github.com/pgRouting/osm2pgrouting/blob/main/mapconfig.xml)
