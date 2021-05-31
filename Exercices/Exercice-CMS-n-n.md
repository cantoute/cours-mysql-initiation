# Exercice : un CMS relation n à n

```sql
DROP TABLE IF EXISTS `post_category`;
DROP TABLE IF EXISTS `post`;
DROP TABLE IF EXISTS `category`;

CREATE TABLE category (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `parent_id` int DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_category_parent_id
    FOREIGN KEY (parent_id)
    REFERENCES category (id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `post` (
  `id` int AUTO_INCREMENT PRIMARY KEY,
  `status` enum('Draft','Waiting','Published') NOT NULL DEFAULT 'Draft',
  `type` set('','Featured','News','Article','Video','Product') NOT NULL DEFAULT '',
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `comments_open` int NOT NULL DEFAULT 0,
  `comments_count` int DEFAULT NULL,
  `published_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `post_category` (
  id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
  post_id int NOT NULL,
  category_id int NOT NULL,
  CONSTRAINT fk_post_category_post_id
    FOREIGN KEY (post_id)
    REFERENCES post (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_post_category_category_id
    FOREIGN KEY (category_id)
    REFERENCES category (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

INSERT INTO `category` (
  `id`,
  `parent_id`,
  `slug`,
  `title`,
  `content`,
  `created_at`,
  `updated_at`
) VALUES
  (1, NULL, 'non-classe', 'Non Classé', '', '2021-05-30 16:46:52', NULL),
  (2, 2, 'cours', 'Cours', '', '2021-05-30 16:47:38', NULL),
  (3, 2, 'mysql', 'MySQL', '', '2021-05-30 16:48:18', NULL);

INSERT INTO `post` (
  `id`,
  `status`,
  `type`,
  `slug`,
  `title`,
  `content`,
  `comments_open`,
  `comments_count`,
  `published_at`,
  `created_at`,
  `updated_at`
) VALUES
  (1, 'Published', '', 'mysql-initiation', 'MySQL Initiation (3 jours)', '', 0, 0, '2021-05-30 17:56:16', '2021-05-30 17:56:16', '2021-05-30 18:54:21');

INSERT INTO `post_category` (
  post_id,
  category_id
) VALUES
  (1, 3),
  (1, 2);



--------------------------------------------------------
-- Exemples

SELECT
  p.id AS post_id,
  p.title AS post_title,
  c.title AS category_title
  FROM
    category AS c
    JOIN post_category AS pc ON (c.id = pc.category_id)
    JOIN post AS p ON (pc.post_id = p.id);
+----+----------------------------+----------------+
| id | post_title                 | category_title |
+----+----------------------------+----------------+
|  1 | MySQL Initiation (3 jours) | Cours          |
|  1 | MySQL Initiation (3 jours) | MySQL          |
+----+----------------------------+----------------+



SELECT
  p.id AS post_id,
  p.title AS post_title,
  c.title AS category_title
  FROM
    post AS p
    JOIN post_category AS pc ON (pc.post_id = p.id)
    JOIN category AS c ON (c.id = pc.category_id);
+---------+----------------------------+----------------+
| post_id | post_title                 | category_title |
+---------+----------------------------+----------------+
|       1 | MySQL Initiation (3 jours) | Cours          |
|       1 | MySQL Initiation (3 jours) | MySQL          |
+---------+----------------------------+----------------+

SELECT
  p.id AS post_id,
  p.title AS post_title,
  c.title AS category_title
  FROM
    post AS p
    LEFT OUTER JOIN post_category AS pc ON (pc.post_id = p.id)
    LEFT OUTER JOIN category AS c ON (c.id = pc.category_id);
+---------+----------------------------+----------------+
| post_id | post_title                 | category_title |
+---------+----------------------------+----------------+
|       1 | MySQL Initiation (3 jours) | MySQL          |
|       1 | MySQL Initiation (3 jours) | Cours          |
|    NULL | NULL                       | Non Classé     |
+---------+----------------------------+----------------+

SELECT
  p.id AS post_id,
  p.title AS post_title,
  c.title AS category_title,
  MAX(c.title) AS category_title1,
  MIN(c.title) AS category_title2,
  GROUP_CONCAT(c.title SEPARATOR ', ') AS categories_titles
  FROM
    post AS p
    JOIN post_category AS pc ON (pc.post_id = p.id)
    JOIN category AS c ON (c.id = pc.category_id)
  GROUP BY p.id;
+---------+----------------------------+----------------+-----------------+-----------------+------------------------+
| post_id | post_title                 | category_title | category_title1 | category_title2 | categories_titles      |
+---------+----------------------------+----------------+-----------------+-----------------+------------------------+
|       1 | MySQL Initiation (3 jours) | Cours          | MySQL / MariaDB | Cours           | Cours, MySQL / MariaDB |
+---------+----------------------------+----------------+-----------------+-----------------+------------------------+


SELECT
  c.id AS category_id,
  c.title AS category_title,
  COUNT(pc.id) AS nb_posts
  FROM
    category AS c
    LEFT JOIN post_category AS pc ON (pc.category_id = c.id)
  GROUP BY c.id;
+-------------+----------------+----------+
| category_id | category_title | nb_posts |
+-------------+----------------+----------+
|           1 | Non Classé     |        0 |
|           2 | Cours          |        1 |
|           3 | MySQL          |        1 |
+-------------+----------------+----------+

SELECT
  c.id AS category_id,
  c.title AS category_title,
  COUNT(pc.id) AS nb_posts
  FROM
    category AS c
    LEFT JOIN post_category AS pc ON (pc.category_id = c.id)
  GROUP BY c.id
  HAVING COUNT(pc.id) = 0;
+-------------+----------------+----------+
| category_id | category_title | nb_posts |
+-------------+----------------+----------+
|           1 | Non Classé     |        0 |
+-------------+----------------+----------+

-- find models that have no children
SELECT
  c.id AS category_id,
  c.title AS category_title
  FROM
    category AS c
    LEFT JOIN post_category AS pc ON (pc.category_id = c.id)
  WHERE
    pc.category_id IS NULL;
+-------------+----------------+
| category_id | category_title |
+-------------+----------------+
|           1 | Non Classé     |
+-------------+----------------+
```
