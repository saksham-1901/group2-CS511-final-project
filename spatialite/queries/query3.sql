-- Find the PATH LENGTH to a node of a given attribute type from a given node. 
SELECT
    SUM(COST)
FROM
    route
WHERE
    NodeFrom = <osm_id>
    AND Name LIKE '%<keyword>%';