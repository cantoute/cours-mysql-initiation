## Question 1

Écrivez une requête qui retourne les noms des différents types de train.

```sql
SELECT nom
FROM modele;

+------+
| nom  |
+------+
| TGV  |
| TER  |
| Fret |
+------+
```

## Question 2

Écrivez une requête qui retourne les `ID` des trajets dont l’heure de départ est plus grande que l’heure d’arrivée (le train arrive le jour suivant).

```sql
SELECT id
FROM trajet
WHERE heure_dep > heure_arr;

+----+
| id |
+----+
| 10 |
+----+
```

## Question 3

Écrivez une requête qui retourne les heures d’arrivée et les noms des villes correspondantes.

```sql
SELECT
  t.heure_arr,
  g.nom AS gare_arr
FROM
  trajet AS t
  INNER JOIN gare AS g ON
    (g.id = t.arr_gare_id);

+-----------+-----------+
| heure_arr | gare_arr  |
+-----------+-----------+
| 08:00:00  | Lille     |
| 19:00:00  | Lyon      |
| 14:00:00  | Marseille |
| 23:00:00  | Marseille |
| 18:00:00  | Toulouse  |
| 21:00:00  | Lille     |
| 22:00:00  | Lille     |
| 19:00:00  | Paris     |
| 00:00:00  | Marseille |
| 17:00:00  | Lyon      |
| 12:00:00  | Paris     |
| 20:00:00  | Lille     |
+-----------+-----------+
```

## Question 4

Écrivez une requête qui retourne pour chaque ville son nom et le nombre de trajets au départ de cette ville, dans l’ordre décroissant du nombre de départs.

```sql
SELECT
  COUNT(g_dep.id) AS nb_dep,
  g_dep.nom AS gare_dep
FROM
  trajet AS t
  INNER JOIN gare AS g_dep ON
    (g_dep.id = t.dep_gare_id)
GROUP BY g_dep.id
ORDER BY nb_dep DESC;

+--------+-----------+
| nb_dep | gare_dep  |
+--------+-----------+
|      3 | Paris     |
|      3 | Lyon      |
|      2 | Lille     |
|      2 | Marseille |
|      2 | Toulouse  |
+--------+-----------+
```

## Question 5

Écrivez une requête qui retourne pour chaque ville son nom et le nombre de trajets à l’arrivé de cette ville, dans l’ordre croissant du nombre d’arrivées.

```sql
SELECT
  COUNT(g_arr.id) AS nb_arr,
  g_arr.nom AS gare_arr
FROM
  trajet AS t
  INNER JOIN gare AS g_arr
    ON (g_arr.id = t.arr_gare_id)
GROUP BY g_arr.id
ORDER BY nb_arr;

+--------+-----------+
| nb_arr | gare_arr  |
+--------+-----------+
|      1 | Toulouse  |
|      2 | Paris     |
|      2 | Lyon      |
|      3 | Marseille |
|      4 | Lille     |
+--------+-----------+
```

## Question 6

Écrivez une requête qui retourne tous les trajets et leur durée. Pour cela il vous faudra utiliser les instructions `CASE`, `TIMEDIFF()` et `ADDTIME()`.

```sql
SELECT
  g_dep.nom AS gare_dep,
  g_arr.nom AS gare_arr,
  trajet.heure_dep,
  trajet.heure_arr,
  CASE
    WHEN heure_arr > heure_dep THEN
      TIMEDIFF(heure_arr, heure_dep)
    ELSE
      TIMEDIFF(ADDTIME(heure_arr, '24:00:00'), heure_dep)
  END AS duree_trajet,
  modele.nom AS modele
FROM
  trajet
  JOIN train ON (trajet.train_id = train.id)
  JOIN modele ON (modele.id = train.modele_id)
  JOIN gare AS g_arr ON (g_arr.id = trajet.arr_gare_id)
  JOIN gare AS g_dep ON (g_dep.id = trajet.dep_gare_id)
ORDER BY trajet.heure_dep;

+-----------+-----------+-----------+-----------+--------------+--------+
| gare_dep  | gare_arr  | heure_dep | heure_arr | duree_trajet | modele |
+-----------+-----------+-----------+-----------+--------------+--------+
| Lille     | Lyon      | 01:00:00  | 17:00:00  | 16:00:00     | Fret   |
| Paris     | Lille     | 02:00:00  | 08:00:00  | 06:00:00     | TER    |
| Paris     | Marseille | 03:00:00  | 14:00:00  | 11:00:00     | TER    |
| Lille     | Marseille | 04:00:00  | 00:00:00  | 04:00:00     | Fret   |
| Toulouse  | Paris     | 05:00:00  | 19:00:00  | 14:00:00     | TGV    |
| Lyon      | Paris     | 06:00:00  | 12:00:00  | 06:00:00     | Fret   |
| Lyon      | Lille     | 07:00:00  | 20:00:00  | 13:00:00     | Fret   |
| Paris     | Lyon      | 09:00:00  | 19:00:00  | 10:00:00     | TER    |
| Toulouse  | Lille     | 10:00:00  | 22:00:00  | 12:00:00     | TGV    |
| Marseille | Toulouse  | 13:00:00  | 18:00:00  | 05:00:00     | TGV    |
| Lyon      | Marseille | 15:00:00  | 23:00:00  | 08:00:00     | TER    |
| Marseille | Lille     | 16:00:00  | 21:00:00  | 05:00:00     | TGV    |
+-----------+-----------+-----------+-----------+--------------+--------+
```
