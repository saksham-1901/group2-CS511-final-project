from py2neo import Graph
import time

graph = Graph("bolt://localhost:7687", auth=("neo4j", "testadmin123"), name="neo5j")

queries = {
    "Query 1": "WITH 0.0001 AS given_distance_squared, 37945950 AS given_node_id MATCH (origin:OSMNode {id: given_node_id}), (target:OSMNode) WHERE origin <> target AND 2 * 6371 * asin(sqrt(haversin(radians( origin.latitude - target.latitude )) + cos(radians( origin.latitude )) * cos(radians( target.latitude )) * haversin(radians( origin.longitude - target.longitude )))) <= given_distance_squared RETURN target.id AS TargetNodeID, target.latitude AS Latitude, target.longitude AS Longitude",
    "Query 2": "MATCH (start:OSMNode {id: 37945237}), (end:OSMNode {id: 37945238}), path = shortestPath((start)-[:CONNECTS_TO*]-(end)) WITH path, relationships(path) AS rels RETURN  reduce(totalCost = 0, r in rels | totalCost + r.path_length) AS totalPathLength",
    "Query 3": "MATCH (start:OSMNode {id: 37945950}) WITH start MATCH (end:OSMNode) WHERE end.tags CONTAINS 'cafe' WITH start, end MATCH path = shortestPath((start)-[:CONNECTS_TO*]-(end)) WITH path, relationships(path) AS rels RETURN path, reduce(totalCost = 0, r in rels | totalCost + r.path_length) AS totalPathLength ORDER BY totalPathLength LIMIT 1",
    "Query 4": "MATCH (start:OSMNode {id: 37945237}), (end:OSMNode {id: 37945238}), path = shortestPath((start)-[*]-(end)) RETURN path",
    "Query 5": "MATCH (origin:OSMNode {id: 9661883082}),(target:OSMNode) WHERE target.tags CONTAINS 'cafe' AND 2 * 6371 * asin(sqrt(haversin(radians( origin.latitude - target.latitude )) + cos(radians( origin.latitude )) * cos(radians( target.latitude )) * haversin(radians( origin.longitude - target.longitude )))) < 1000 RETURN target"
}

def benchmark_query(query, num_runs=10):
    times = []
    for _ in range(num_runs):
        start_time = time.time()  # Start time measurement
        graph.run(query)
        end_time = time.time()  # End time measurement
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
