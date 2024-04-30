-- Given 2 nodes, find the total path length between them
SELECT
    SUM(COST)
FROM
    route
WHERE
    NodeFrom = <osm_id>
    AND NodeTo = <osm_id>;