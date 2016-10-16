ALTER DATABASE db_tp DEFAULT CHARACTER SET cp1251 COLLATE cp1251_general_ci;

# noinspection SqlNoDataSourceInspectionForFile
CREATE TABLE `Users`(
	`id` MEDIUMINT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR (30),
	`about` TEXT,
	`name` VARCHAR (30),
  `email` VARCHAR (30) NOT NULL,
	`isAnonymous` BOOL NOT NULL DEFAULT False,
	PRIMARY KEY (`id`),
  UNIQUE KEY (`email`)
) ENGINE = MYISAM;


CREATE TABLE `Forums`(
	`id` MEDIUMINT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (50) NOT NULL,
  `slug` VARCHAR (50) NOT NULL,
  `user` VARCHAR (30) NOT NULL,
	PRIMARY KEY (`id`),
  UNIQUE KEY (`slug`),
    UNIQUE KEY (`name`),
    CONSTRAINT FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE
) ENGINE = MYISAM;


CREATE TABLE `Threads` (
    `id` MEDIUMINT(11) NOT NULL AUTO_INCREMENT,
    `forum` VARCHAR (30) NOT NULL,
    `title` VARCHAR (50) NOT NULL,
    `isClosed` BOOL NOT NULL DEFAULT False,
    `user` VARCHAR (30) NOT NULL,
    `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `message` TEXT NOT NULL,
    `slug` VARCHAR (50) NOT NULL,
    `isDeleted` BOOL NOT NULL DEFAULT False,
    `posts` MEDIUMINT(11) DEFAULT 0,
    `likes` MEDIUMINT(11) DEFAULT 0,
    `dislikes` MEDIUMINT(11) DEFAULT 0,
    `points` MEDIUMINT(11) DEFAULT 0,
    PRIMARY KEY (`id`),
    CONSTRAINT FOREIGN KEY (`forum`) REFERENCES `Forums` (`slug`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE
) ENGINE = MYISAM;

CREATE TABLE `Posts` (
	`id` MEDIUMINT(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `thread` MEDIUMINT(11) NOT NULL,
  `message` TEXT NOT NULL,
  `user` VARCHAR (30) NOT NULL,
  `forum` VARCHAR (30) NOT NULL,
	`parent` MEDIUMINT(11) DEFAULT -1,
	`isApproved` BOOL NOT NULL DEFAULT False,
	`isHighlighted` BOOL NOT NULL DEFAULT False,
	`isEdited` BOOL NOT NULL DEFAULT False,
	`isSpam` BOOL NOT NULL DEFAULT False,
	`isDeleted` BOOL NOT NULL DEFAULT False,
  `dislikes` SMALLINT NOT NULL DEFAULT 0,
  `likes` SMALLINT NOT NULL DEFAULT 0,
  `points` SMALLINT NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
  CONSTRAINT FOREIGN KEY (`forum`) REFERENCES `Forums` (`slug`) ON DELETE CASCADE,
  CONSTRAINT FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE,
  CONSTRAINT FOREIGN KEY (`thread`) REFERENCES `Threads` (`id`) ON DELETE CASCADE
) ENGINE = MYISAM;

CREATE TABLE `Followers` (
  `id` MEDIUMINT(11) NOT NULL AUTO_INCREMENT,
  `follower_mail` VARCHAR (30) NOT NULL,
  `following_mail` VARCHAR (30) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT FOREIGN KEY (`follower_mail`) REFERENCES `Users` (`email`) ON DELETE CASCADE,
  CONSTRAINT FOREIGN KEY (`following_mail`) REFERENCES `Users` (`email`) ON DELETE CASCADE
) ENGINE = MYISAM;

CREATE TABLE `Subscribe` (
  `id` MEDIUMINT(11) NOT NULL AUTO_INCREMENT,
  `user` VARCHAR (30) NOT NULL,
  `thread` MEDIUMINT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT FOREIGN KEY (`user`) REFERENCES `Users` (`email`) ON DELETE CASCADE,
  CONSTRAINT FOREIGN KEY (`thread`) REFERENCES `Threads` (`id`) ON DELETE CASCADE
) ENGINE = MYISAM;