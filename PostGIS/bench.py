import psycopg2
import time

# Connect to the PostGIS database

conn = psycopg2.connect(
    dbname='osmdb',
    user='postgres',
    password='postgres',
    host='localhost'
)
cursor = conn.cursor()

# Define your queries
queries = {
    "Query 1": "WITH given_node AS (SELECT way FROM planet_osm_point WHERE osm_id = 7246058860), target_nodes AS (SELECT osm_id, ST_Transform(way, 4326) AS geom FROM planet_osm_point) SELECT target.osm_id AS TargetNodeID, ST_Y(target.geom) AS Latitude, ST_X(target.geom) AS Longitude FROM target_nodes AS target, given_node WHERE target.osm_id <> 7246058860 AND ST_Distance(target.geom::geography, ST_Transform(given_node.way, 4326)::geography) <= 1600;",
    "Query 2": "SELECT sum(cost) as total_cost FROM pgr_dijkstra('SELECT gid AS id, source, target, length AS cost FROM ways', 5, 2424, directed := false);",
    "Query 3" : "SELECT sum(cost) as total_cost FROM pgr_dijkstra('SELECT gid AS id, source, target, length AS cost FROM ways', 2424, (SELECT gid FROM ways WHERE tag_id = (SELECT tag_id FROM configuration WHERE tag_value LIKE '%residential%') LIMIT 1), directed := false);",
    "Query 4": "SELECT * FROM pgr_dijkstra('SELECT gid AS id, source, target, length AS cost FROM ways', 5, 2424, directed := false);",
    "Query 5" : "WITH given_node AS (SELECT way FROM planet_osm_point WHERE osm_id = 7246058860), target_nodes AS (SELECT osm_id, name, ST_Transform(way, 4326) AS geom FROM planet_osm_point WHERE name LIKE '%Fire Station%') SELECT target.osm_id AS TargetNodeID, ST_Y(target.geom) AS Latitude, ST_X(target.geom) AS Longitude FROM target_nodes AS target, given_node WHERE target.osm_id <> 7246058860 AND ST_Distance(target.geom::geography, ST_Transform(given_node.way, 4326)::geography) <= 10000;", 
}

# Function to run queries and measure performance
def benchmark_query(query, num_runs=10):
    times = []
    for _ in range(num_runs):
        start_time = time.time()
        cursor.execute(query)
        results = cursor.fetchall()
        end_time = time.time()
        times.append(end_time - start_time)
    average_time = sum(times) / len(times)
    return average_time

# Running benchmarks
results = {}
for name, query in queries.items():
    avg_time = benchmark_query(query, num_runs=100)  # Adjust num_runs as needed
    results[name] = avg_time

# Output the results
for name, avg_time in results.items():
    print(f"Average response time for {name}: {avg_time:.4f} seconds")

cursor.close()
conn.close()
