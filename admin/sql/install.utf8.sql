SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `#__pv_address_xrefs`;
DROP TABLE IF EXISTS `#__pv_addresses`;
DROP TABLE IF EXISTS `#__pv_cycle_year`;
DROP TABLE IF EXISTS `#__pv_cycles`;
DROP TABLE IF EXISTS `#__pv_elections`;
DROP TABLE IF EXISTS `#__pv_link_xrefs`;
DROP TABLE IF EXISTS `#__pv_link_types`;
DROP TABLE IF EXISTS `#__pv_links`;
DROP TABLE IF EXISTS `#__pv_officers`;
DROP TABLE IF EXISTS `#__pv_offices`;
DROP TABLE IF EXISTS `#__pv_parties`;
DROP TABLE IF EXISTS `#__pv_persons`;
DROP TABLE IF EXISTS `#__pv_seats`;
DROP TABLE IF EXISTS `#__pv_tables`;
DROP TABLE IF EXISTS `#__pv_terms`;

/* ==================== constants ==================== */
SET @tnow = NOW();
SET @tnl  = '0000-00-00 00:00:00';
SET @tns  = '0000-00-00';
SET @db   = DATABASE();

/* ==================== tables ==================== */
CREATE TABLE IF NOT EXISTS `#__pv_addresses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `address3` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=ARIA DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_address_xrefs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `address_id` int(11) unsigned NOT NULL DEFAULT 0,
  `right_id` int(11) unsigned NOT NULL DEFAULT 0,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_address_xrefs_address_id` (`address_id`),
  KEY `pv_address_xrefs_right_id` (`right_id`)
) ENGINE=ARIA DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_elections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `old_id` int(11) unsigned NOT NULL DEFAULT 0,
  `year` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL DEFAULT '',
  `is_special` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `is_current` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_elections_year` (`year`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_xrefs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(11) unsigned NOT NULL DEFAULT 0,
  `right_id` int(11) unsigned NOT NULL DEFAULT 0,
  `table_id` int(11) unsigned NOT NULL DEFAULT 0,
  `ordering` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=ARIA DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `limit` int(11) DEFAULT '0' COMMENT '0 for no limit, 1 or greater for a specific limit',
  `name` varchar(255) DEFAULT NULL,
  `symbol` varchar(20) DEFAULT NULL COMMENT 'html code',
  `glyph` varchar(20) DEFAULT NULL COMMENT 'favicon definition',
  `image` varchar(255) DEFAULT NULL,
  `prefer` enum('symbol','glyph','image') DEFAULT 'symbol',
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) unsigned NOT NULL DEFAULT 0,
  `value` varchar(255) DEFAULT NULL,
  `ordering` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_links_type_id` (`type_id`)
) ENGINE=ARIA DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_officers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `seat_id` int(11) unsigned NOT NULL DEFAULT 0,
  `party_id` int(11) unsigned NOT NULL DEFAULT 0,
  `person_id` int(11) unsigned NOT NULL DEFAULT 0,
  `attributes` text NOT NULL DEFAULT '',
  `first_elected_year` smallint(5) unsigned NOT NULL DEFAULT 0,
  `last_elected_year` smallint(5) unsigned NOT NULL DEFAULT 0,
  `ordering` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_officers_uniqe_id` (`seat_id`,`person_id`,`party_id`,`first_elected_year`),
  KEY `pv_officers_seat_id` (`seat_id`),
  KEY `pv_officers_person_id` (`person_id`),
  KEY `pv_officers_party_id` (`party_id`),
  KEY `pv_officers_first_year` (`first_elected_year`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_offices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL DEFAULT '',
  `level` enum('local','state','federal','ward') DEFAULT 'local',
  `ordering` int(11) unsigned NOT NULL DEFAULT 1,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_offices_level` (`level`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_parties` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `abbr` varchar(10) DEFAULT NULL,
  `ordering` int(11) unsigned NOT NULL DEFAULT 1,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_persons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `old_id` int(11) unsigned NOT NULL DEFAULT 0,
  `party_id` int(11) unsigned NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `prefix` varchar(25) DEFAULT NULL,
  `first_name` varchar(40) DEFAULT NULL,
  `middle_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `suffix` varchar(25) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `marital_status` char(1) DEFAULT NULL,
  `bio` text NOT NULL DEFAULT '',
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_persons_party_id` (`party_id`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_seats` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` int(11) unsigned NOT NULL DEFAULT 0,
  `office_id` int(11) unsigned NOT NULL DEFAULT 0,
  `old_id` int(11) unsigned NOT NULL DEFAULT 0,
  `district` text NOT NULL DEFAULT '',
  `description` text NOT NULL DEFAULT '',
  `ordering` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_seats_office_id` (`office_id`),
  KEY `pv_seats_term_id` (`term_id`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_tables` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_terms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `offset` int(11) unsigned NOT NULL DEFAULT 0,
  `length` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `ordering` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=ARIA  DEFAULT CHARSET=utf8;

INSERT INTO `#__pv_tables` 
  (`name`, `created`) 
  SELECT 
  `table_name` as `name`, 
  @tnow as `created` 
  FROM `information_schema`.`tables` 
  WHERE `table_schema`=@db AND `table_name` LIKE "%_pv_%";

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt

INSERT INTO `#__pv_link_types` 
  (`limit`, `name`, `prefer`, `created`)
VALUES
  (3,'phone','symbol', @tnow),
  (1,'cell','symbol', @tnow),
  (1,'fax','symbol', @tnow),
  (1,'email','symbol', @tnow),
  (1,'homepage','symbol', @tnow),
  (1,'twitter','symbol', @tnow),
  (1,'facebook','symbol', @tnow),
  (1,'linkdin','symbol', @tnow);

SET @year=1980;
SET @cycle=0;

INSERT INTO `#__pv_elections`
  (`old_id`, `year`, `name`, `is_special`, `is_current`, `published`, `date`, `created`)
  SELECT
    `id` AS `old_id`,
    LEFT(TRIM(`e_year`), 4) AS `year`,
    RIGHT(TRIM(`e_year`), LENGTH(TRIM(`e_year`)) -4 ) AS `name`,
    0 AS `is_special`,
    0 AS `is_current`,
    1 AS `published`,
    `election_date` AS `date`,
    @tnow AS `created`
  FROM `#__rt_election_year`
  ORDER BY `election_date` ASC;

INSERT INTO `#__pv_parties`
 (`name`, `abbr`, `published`, `created`)
VALUES
  ('None', 'None', 1, @tnow),
  ('Democratic Party', 'Dem', 1, @tnow),
  ('Republican Party', 'Rep', 1, @tnow),
  ('Constitution Party', 'Con', 1, @tnow),
  ('Free Dominion Party', 'Fre', 1, @tnow),
  ('Green Party', 'Gre', 1, @tnow),
  ('Independant', 'Ind', 1, @tnow),
  ('Justice Party', 'Jus', 1, @tnow),
  ('Libertarian Party', 'Lib', 1, @tnow),
  ('Socialization & Liberation Party', 'Soc', 1, @tnow);

UPDATE `#__pv_parties` set `ordering` = `id`;

/* persons depends on parties*/
INSERT INTO `#__pv_persons`
  (`old_id`, `party_id`, `first_name`, `published`, `created`)
VALUES 
  (0, 1, 'Vacant', 1, @tnow);

INSERT INTO `#__pv_persons`
  (`old_id`, `party_id`, `first_name`, `middle_name`, `last_name`, `suffix`, `gender`, `published`, `created`)
  SELECT
    `id` AS `old_id`,
    (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(p.`name`,1)=`party`) AS `party_id`,
    IFNULL(TRIM(`first_name`), '') AS `first_name`,
    IFNULL(REPLACE(TRIM(`middle_name`),'\.',''), '') AS `middle_name`,
    IFNULL(TRIM(`last_name`), '') AS `last_name`,
    IFNULL(REPLACE(TRIM(`suffix`),'\.',''), '') AS `suffix`,
    CASE TRIM(`first_name`)
      WHEN "Kathleen" THEN "f"
      WHEN "Christine" THEN "f"
      WHEN "Shirley" THEN "f"
      WHEN "Martina" THEN "f"
      WHEN "Maria" THEN "f"
      WHEN "Vanessa" THEN "f"
      WHEN "Louise" THEN "f"
      WHEN "Pamela" THEN "f"
      WHEN "Michelle" THEN "f"
      WHEN "Leslie" THEN "f"
      WHEN "Rosita" THEN "f"
      WHEN "Cherelle" THEN "f"
      WHEN "Stephanie" THEN "f"
      WHEN "Jannie" THEN "f"
      WHEN "Cindy" THEN "f"
      WHEN "Marian" THEN "f"
      ELSE "m"
    END AS `gender`,
    1 AS `published`,
    @tnow AS `created`
    FROM `#__electedofficials` 
    WHERE 
      TRIM(`first_name`) NOT LIKE "VACANT" AND
      TRIM(`first_name`) IS NOT NULL AND
      TRIM(`first_name`) != ''
    ORDER BY TRIM(`first_name`) ASC, TRIM(`last_name`) ASC;

/* correct some specific existing names */
UPDATE #__pv_persons SET
  `middle_name` = RIGHT(TRIM(`first_name`), LENGTH(TRIM(`first_name`))-3),
  `first_name` = LEFT(TRIM(`first_name`),1)
WHERE
  `first_name` IN ('W. Wilson','R. Seth','W. Curtis');

INSERT INTO `#__pv_offices`
(`name`, `level`, `published`, `created`)
  SELECT DISTINCT 
    `office` AS `name`, 
    lower(`office_level`) AS `level`, 
    1 AS `published`,
    @tnow AS `created`
  FROM `#__electedofficials`
  order by `level`, `name`;

INSERT INTO `#__pv_offices`
  (`name`, `level`, `published`, `created`)
VALUES
  ('Committeeperson', 'ward', 1, @tnow),
  ('Delegate', 'state', 1, @tnow),
  ('Alternate Delegate', 'state', 1, @tnow),
  ('Minority Inspector', 'ward', 1, @tnow),
  ('Majority Inspector', 'ward', 1, @tnow),
  ('Judge of the Commonwealth Court', 'state', 1, @tnow),
  ('Judge of the Court of Common Pleas', 'state', 1, @tnow),
  ('Judge of the Municipal Court', 'state', 1, @tnow),
  ('Judge of the Superior Court', 'state', 1, @tnow),
  ('Justice of the Supreme Court', 'state', 1, @tnow),
  ('Member of State Committee', 'state', 1, @tnow),
  ('Office of Judge of Election', 'ward', 1, @tnow);

UPDATE `#__pv_offices` set `ordering` = `id`;

/* ===================== pv_terms ===================== */
INSERT INTO `#__pv_terms` 
  (`offset`, `length`, `name`, `published`, `created` )
VALUES
  (0, 2, '2-year, no offset', 1, @tnow),
  (0, 6, '4-year, no offset', 1, @tnow),
  (1, 4, '4-year, 1year offset', 1, @tnow),
  (2, 4, '4-year, 2year offset', 1, @tnow),
  (3, 4, '4-year, 3year offset', 1, @tnow),
  (0, 6, '6-year, no offset', 1, @tnow),
  (4, 6, '6-year, 4year offset', 1, @tnow);

UPDATE `#__pv_terms` set `ordering` = `id`;

/* seats depends of offices and terms */
SET @rank=0;
INSERT INTO `#__pv_seats`
  (`term_id`, `old_id`, `office_id`, `ordering`, `district`, `published`, `created`)
  SELECT
    CASE TRIM(`office`)
      WHEN "Attorney General" THEN 2
      WHEN "Auditor General" THEN 2
      WHEN "City Commissioner" THEN 5
      WHEN "City Controller" THEN 3
      WHEN "City Council At-Large" THEN 5
      WHEN "City Council" THEN 5
      WHEN "District Attorney" THEN 3
      WHEN "Governor" THEN 4
      WHEN "Lieutenant Governor" THEN 4
      WHEN "Mayor" THEN 5
      WHEN "President of the United States" THEN 2
      WHEN "Register of Wills" THEN 5
      WHEN "Sheriff" THEN 5
      WHEN "State Representative" THEN 1
      WHEN "State Senator" THEN IF(`state_senate_district` % 2, 2, 4)
      WHEN "State Treasurer" THEN 2
      WHEN "U.S. Representative" THEN 1
      WHEN "U.S. Senate" THEN IF(`next_election` % 3, 7, 6)
    END AS `term_id`,
    `id` AS `old_id`,
    (SELECT `id` FROM `#__pv_offices` o where o.`name`=`office`) as `office_id`,
    @rank:=@rank+1 AS `ordering`,
    CONCAT_WS(
      '',
      TRIM(`congressional_district`),
      TRIM(`state_senate_district`),
      TRIM(`state_representative_district`),
      TRIM(`council_district`),
      IF(`office`='City Council At-Large','','')
    ) AS `district`,
    1 AS `published`,
    @tnow AS `created`
    FROM `#__electedofficials` group by `id`;

/* ==================== FK relationships ==================== */
SET FOREIGN_KEY_CHECKS=0;

/* ------------ pv_officers ------------ */
SET @rank=0; 

INSERT INTO `#__pv_officers` 
  (`seat_id`, `party_id`, `person_id`, `first_elected_year`, `ordering`, `created`)
  SELECT 
    s.`id` AS `seat_id`,
    p.`party_id` AS `party_id`,
    p.`id` AS `person_id`,
    e.`first_elected` as `first_elected_year`,
    @rank:=@rank+1 AS `ordering`,
    @tnow AS `created`
  FROM 
    `#__electedofficials` e,
    `#__pv_persons` p,
    `#__pv_seats` s
  WHERE
    e.`id` = s.`old_id` and
    e.`id` = p.`old_id`; 

/* TODO: Migrate office addresses */

/* TODO: Migrate officers addresses */

/* remove old_id */
ALTER TABLE `#__pv_elections`
  DROP COLUMN `old_id`;
ALTER TABLE `#__pv_persons`
  DROP COLUMN `old_id`;
ALTER TABLE `#__pv_seats`
  DROP COLUMN `old_id`;

/* ==================== FK relationships ==================== */

ALTER TABLE `#__pv_address_xrefs`
  ADD CONSTRAINT `fk_pv_address_xrefs_address_id`
  FOREIGN KEY (`address_id`) REFERENCES `#__pv_addresses`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
ALTER TABLE `#__pv_links`
  ADD CONSTRAINT `fk_pv_links_type_id`
  FOREIGN KEY (`type_id`) REFERENCES `#__pv_link_types`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
ALTER TABLE `#__pv_officers`
  ADD CONSTRAINT `fk_pv_officers_seats_id`
  FOREIGN KEY (`seat_id`) REFERENCES `#__pv_seats`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE
, ADD CONSTRAINT `fk_pv_officers_party_id`
  FOREIGN KEY (`party_id`) REFERENCES `#__pv_parties`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE
, ADD CONSTRAINT `fk_pv_officers_person_id`
  FOREIGN KEY (`person_id`) REFERENCES `#__pv_persons`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
ALTER TABLE `#__pv_persons`
  ADD CONSTRAINT `fk_pv_persons_party_id`
  FOREIGN KEY (`party_id`) REFERENCES `#__pv_parties`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
ALTER TABLE `#__pv_seats`
  ADD CONSTRAINT `fk_pv_seats_term_id`
  FOREIGN KEY (`term_id`) REFERENCES `#__pv_terms`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE
, ADD CONSTRAINT `fk_pv_seats_office_id`
  FOREIGN KEY (`office_id`) REFERENCES `#__pv_office`(`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;


/* ==================== Done ==================== */

SET FOREIGN_KEY_CHECKS=1;
