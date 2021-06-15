# Exercice 1 : Solutions

```sql
-- 1
SELECT *
FROM villes_france_free
ORDER BY ville_population_2012 DESC
LIMIT 10;

-- 2
SELECT *
FROM villes_france_free
ORDER BY ville_surface ASC
LIMIT 50;

-- 3
SELECT *
FROM departement
WHERE departement_code LIKE '97%';

-- 4
SELECT *
FROM
  villes_france_free AS v
  JOIN departement AS d ON (d.departement_code = v.ville_departement)
ORDER BY v.ville_population_2012 DESC
LIMIT 10;

-- 5
SELECT departement_nom, ville_departement, COUNT(*) AS nb_items
  FROM villes_france_free AS v
  JOIN departement AS d ON (d.departement_code = v.ville_departement)
GROUP BY v.ville_departement
ORDER BY nb_items DESC;

-- 6
SELECT
  d.departement_nom,
  d.departement_code,
  SUM(ville_surface) AS dpt_surface
FROM
  villes_france_free AS v
  JOIN departement AS d ON (d.departement_code = v.ville_departement)
GROUP BY d.departement_code
ORDER BY dpt_surface  DESC
LIMIT 10

-- 7
SELECT COUNT(*) AS nb_villes_saint
FROM villes_france_free
WHERE ville_nom LIKE 'saint%';

-- 8
SELECT ville_nom, COUNT(*) AS nbt_item
FROM villes_france_free
GROUP BY ville_nom
ORDER BY nbt_item DESC;

-- 9
SELECT *
FROM villes_france_free
WHERE
  ville_surface > (
    SELECT AVG(ville_surface)
    FROM villes_france_free
  );

-- 9 alterative
SELECT *
FROM
  villes_france_free AS v1,
  (
    SELECT
      AVG(v2.ville_surface) AS surface_moyenne
    FROM
      villes_france_free AS v2
  ) AS v3
WHERE
  ville_surface > v3.surface_moyenne;

-- 10
SELECT
  ville_departement,
  SUM(ville_population_2012) AS population_2012
FROM
  villes_france_free
GROUP BY ville_departement
HAVING population_2012 > 2000000
ORDER BY population_2012 DESC;

-- 11
UPDATE villes_france_free
SET ville_nom = REPLACE(ville_nom, 'SAINT-', 'SAINT ')
WHERE ville_nom LIKE 'SAINT-%';
```
