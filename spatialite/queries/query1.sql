-- Retrieve all nodes within a certain distance from a specific node using its node_id
SELECT
    COUNT(*)
FROM
    points AS p,
    (
        SELECT
            GEOMETRY
        FROM
            points
        WHERE
            osm_id = < osm_id >
    ) AS origin_geom
WHERE
    ST_Distance (p.GEOMETRY, origin_geom.GEOMETRY) <= 1000;