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

- query1: urbana
- query2: urbana-network
- query3: urbana-network
- query4: urbana-network
- query5: urbana

### Benchmarking

- To run benchmarks, run `./benchmark.sh <SQL_FILE>` where `<SQL_FILE>` is the name of the SQL file you want to run.
- Modify the `TIMES_TO_RUN` variable in `benchmark.sh` to change the number of times you want to run the query.
- The `TOTAL_TIME_MS` variable in `benchmark.sh` is used to calculate the average execution time.
- The `SESSION_NAME` variable in `benchmark.sh` is used to name the screen session where the query is executed.

### Reference

- [OSM Data Model](https://wiki.openstreetmap.org/wiki/Elements)
- [Spatialite Documentation](https://www.gaia-gis.it/gaia-sins/spatialite-sql-latest.html)
- [Spatialite Command Reference](https://www.gaia-gis.it/gaia-sins/spatialite-sql-latest.html#command-reference)
- [Spatialite SQLite Command Reference](https://www.gaia-gis.it/gaia-sins/spatialite-sql-latest.html#sqlite-command-reference)
