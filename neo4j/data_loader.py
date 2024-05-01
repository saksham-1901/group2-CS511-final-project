import osmium
import math
from neo4j import GraphDatabase
from concurrent.futures import ThreadPoolExecutor, as_completed


def haversine(lat1, lon1, lat2, lon2):
     
    # distance between latitudes
    # and longitudes
    dLat = (lat2 - lat1) * math.pi / 180.0
    dLon = (lon2 - lon1) * math.pi / 180.0
 
    # convert to radians
    lat1 = (lat1) * math.pi / 180.0
    lat2 = (lat2) * math.pi / 180.0
 
    # apply formulae
    a = (pow(math.sin(dLat / 2), 2) +
         pow(math.sin(dLon / 2), 2) *
             math.cos(lat1) * math.cos(lat2));
    rad = 6371
    c = 2 * math.asin(math.sqrt(a))
    return rad * c


def get_string(str):
    return str.split(":")[-1]


class OSMHandler(osmium.SimpleHandler):
    def __init__(self, uri, user, password, database):
        super().__init__()
        self.driver = GraphDatabase.driver(uri, auth=(user, password), database=database)
        self.nodes = {}
        self.rels = []

    def node(self, n):
        # Store node coordinates in a dictionary
        self.nodes[n.id] = (n.location.lat, n.location.lon)

    def way(self, w):
        nodes = w.nodes
        way_tags = {tag.k: tag.v for tag in w.tags}
        #print(way_tags)

        for i in range(len(nodes) - 1):
            node_a_id = nodes[i].ref
            node_b_id = nodes[i+1].ref

            if node_a_id in self.nodes and node_b_id in self.nodes:
                lat_a, lon_a = self.nodes[node_a_id]
                lat_b, lon_b = self.nodes[node_b_id]
                path_length = haversine(lat_a, lon_a, lat_b, lon_b)
                self.rels.append((node_a_id, lat_a, lon_a, node_b_id, lat_b, lon_b, path_length, way_tags))

    def flush(self):
        with self.driver.session() as session:
            for node_a_id, lat_a, lon_a, node_b_id, lat_b, lon_b, path_length, way_tags in self.rels:
                tags_a_str = ""
                tags_b_str = ""
                for key,value in way_tags.items():
                    tags_a_str += value

                query = (
                    "MERGE (a:OSMNode {id: $node_a_id}) "
                    "ON CREATE SET a.latitude = $lat_a, a.longitude = $lon_a, a.tags =  $tags "
                    "MERGE (b:OSMNode {id: $node_b_id}) "
                    "ON CREATE SET b.latitude = $lat_b, b.longitude = $lon_b, b.tags =  $tags "
                    "MERGE (a)-[r:CONNECTS_TO]->(b) "
                    "ON CREATE SET r.path_length = $path_length "
                )
                session.run(query, node_a_id=node_a_id, lat_a=lat_a, lon_a=lon_a, node_b_id=node_b_id, lat_b=lat_b, lon_b=lon_b, path_length=path_length, tags=tags_a_str)

    def close(self):
        self.driver.close()

uri = "bolt://localhost:7687/"
user = "neo4j"
password = "testadmin123"
database = "neo4j"
handler = OSMHandler(uri, user, password, database)
handler.apply_file("/Users/saksham/511Project/osm2graph-neo4j/urbana.osm")
handler.flush()
handler.close()
print("OSM data has been loaded into Neo4j.")


