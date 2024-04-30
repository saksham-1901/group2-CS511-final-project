-- -- Find the path of a given attribute type from a given node:
SELECT
    *
FROM
    route
WHERE
    NodeFrom = <osm_id>
    AND Name LIKE '%<keyword>%';