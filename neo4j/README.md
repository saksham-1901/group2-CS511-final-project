## Steps to reproduce

- Download OSM data
- Install Neo4j using `sudo apt-get install neo4j=1:5.12.0`
- Make sure you have `java-1.17.0-openjdk-amd64` installed
- Start the Neo4j server using `sudo service neo4j start`
- Create  a new database
- Install APOC plugin in Neo4j
- Update the 'data_loader.py' with the authentication information of the database and the location of the OSM data.
- Run the Script.
- Port forward the Neo4j server to your local machine using `ssh -L 7474:localhost:7474 -L 7687:localhost:7687 username@server_ip`
- Open Neo4j Browser and run the queries.


### Benchmarking

- Update the 'benchmarking_script.py' with the authentication information of the database.
- Install the dependecies: `pip install neo4j py2neo`
- Run the script `python3 benchmarking_script.py`
- Modify the `num_runs` argument in `benchmark_query` function call to change the number of times you want to run the query.
