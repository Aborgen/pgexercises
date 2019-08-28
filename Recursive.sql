-- Recursive Queries
-- https://pgexercises.com/questions/recursive/

-- Find the upward recommendation chain for member ID 27
-- Find the upward recommendation chain for member ID 27: that is, the member who recommended them, and the
-- member who recommended that member, and so on. Return member ID, first name, and surname. Order by descending member id.
WITH RECURSIVE recommendation AS
(
  SELECT memid, firstname, surname, recommendedby
  FROM cd.members
  WHERE memid = 27
  UNION ALL
  SELECT m.memid, m.firstname, m.surname, m.recommendedby
  FROM cd.members AS m
  JOIN recommendation AS r
  ON m.memid = r.recommendedby
)

SELECT memid, firstname, surname
FROM recommendation
WHERE memid <> 27;

/*
+-------+-----------+---------+
| memid | firstname | surname |
+-------+-----------+---------+
| 20    | Matthew   | Genting |
| 5     | Gerald    | Butters |
| 1     | Darren    | Smith   |
+-------+-----------+---------+
*/

-- Find the downward recommendation chain for member ID 1
-- Find the downward recommendation chain for member ID 1: that is, the members they recommended, the members those
-- members recommended, and so on. Return member ID and name, and order by ascending member id.
WITH RECURSIVE recommendation AS
(
  SELECT memid, firstname, surname, recommendedby
  FROM cd.members
  WHERE memid = 1
  UNION ALL
  SELECT m.memid, m.firstname, m.surname, m.recommendedby
  FROM cd.members AS m
  JOIN recommendation AS r
  ON m.recommendedby = r.memid
)

SELECT memid, firstname, surname
FROM recommendation

/*
+-------+-----------+-----------+
| memid | firstname | surname   |
+-------+-----------+-----------+
| 4     | Janice    | Joplette  |
| 5     | Gerald    | Butters   |
| 7     | Nancy     | Dare      |
| 10    | Charles   | Owen      |
| 11    | David     | Jones     |
| 14    | Jack      | Smith     |
| 20    | Matthew   | Genting   |
| 21    | Anna      | Mackenzie |
| 26    | Douglas   | Jones     |
| 27    | Henrietta | Rumney    |
+-------+-----------+-----------+
*/

-- Produce a CTE that can return the upward recommendation chain for any member
-- Produce a CTE that can return the upward recommendation chain for any member.
-- You should be able to select recommender from recommenders where member=x. Demonstrate it by
-- getting the chains for members 12 and 22. Results table should have member and recommender,
-- ordered by member ascending, recommender descending.
WITH RECURSIVE recommendation AS
(
  SELECT memid, recommendedby
  FROM cd.members
  UNION ALL
  SELECT r.memid, m.recommendedby
  FROM cd.members AS m
  JOIN recommendation AS r
  ON m.memid = r.recommendedby
)

SELECT r.memid, r.recommendedby, firstname, surname
FROM cd.members AS m
JOIN recommendation AS r
ON m.memid = r.recommendedby
WHERE r.memid IN (12, 22)
ORDER BY memid ASC, recommendedby DESC

/*
+-------+---------------+-----------+----------+
| memid | recommendedby | firstname | surname  |
+-------+---------------+-----------+----------+
| 12    | 9             | Ponder    | Stibbons |
| 12    | 6             | Burton    | Tracy    |
| 22    | 16            | Timothy   | Baker    |
| 22    | 13            | Jemima    | Farrell  |
+-------+---------------+-----------+----------+
*/

