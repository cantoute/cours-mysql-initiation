# Exercice : un CMS relation 1 à n

```sql
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
  `category_id` int NOT NULL,
  CONSTRAINT fk_post_category_id
    FOREIGN KEY (category_id)
    REFERENCES category (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `updated_at`,
  `category_id`
  )
  VALUES
  (1, 'Published', '', 'mysql-initiation', 'MySQL Initiation (3 jours)', '', 0, 0, '2021-05-30 17:56:16', '2021-05-30 17:56:16', '2021-05-30 18:54:21', 3);

```
