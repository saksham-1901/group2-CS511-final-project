## Steps to reproduce

- Download OSM data
- Install sqlite3
- Convert OSM data into SQLite tables: `ogr2ogr -f SQLite -dsco SPATIALITE=YES <name>.sqlite <path>.osm `
- Install Spatialite: `brew install spatialite-tools`
- Create network data: `spatialite_osm_net -o datasets/urbana.osm -d databases/urbana-network.sqlite -T roads`
- Create routing data: `SELECT CreateRouting('route_data', 'route', 'roads', 'node_from', 'node_to', 'geometry', 'cost', 'name', 1, 1);`
- Run Spatialite: `spatialite databases/urbana.sqlite`
- ATTACH DATABASE 'databases/urbana-network.sqlite' AS network;
- Run queries: `.read queries/query1.sql`

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
