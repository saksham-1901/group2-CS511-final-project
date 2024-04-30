-- This query identifies all the nodes within a given distance having a specified attribute value from a given node.
SELECT
    n2.*
FROM
    multipolygons AS n1,
    multipolygons AS n2
WHERE
    n1.osm_way_id = <osm_id>
    AND n2.building = <building_type>
    AND ST_Distance (n1.GEOMETRY, n2.GEOMETRY) <= 100000;