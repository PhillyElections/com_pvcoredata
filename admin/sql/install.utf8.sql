SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `#__pv_address_xrefs`;
DROP TABLE IF EXISTS `#__pv_address_to_seat`;
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
DROP TABLE IF EXISTS `#__pv_terms`;

SET FOREIGN_KEY_CHECKS=1;

/* ==================== constants ==================== */
SET @tnow = NOW();
SET @tnl  = '0000-00-00 00:00:00';
SET @tns  = '0000-00-00';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_address_xrefs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `address_id` int(11) unsigned NOT NULL DEFAULT 0,
  `right_id` int(11) unsigned NOT NULL DEFAULT 0,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_cycles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `#__pv_cycles` values
  ('', 1, 'First Cycle', '', 1, '', @tnl, @tnow, @tnow),
  ('', 2, 'Second Cycle', '', 2, '', @tnl, @tnow, @tnow),
  ('', 3, 'Third Cycle', '', 3, '', @tnl, @tnow, @tnow),
  ('', 4, 'Fourth Cycle', '', 4, '', @tnl, @tnow, @tnow),
  ('', 5, 'Fifth Cycle', '', 5, '', @tnl, @tnow, @tnow),
  ('', 6, 'Sixth Cycle', '', 6, '', @tnl, @tnow, @tnow),
  ('', 7, 'Seventh Cycle', '', 7, '', @tnl, @tnow, @tnow);

CREATE TABLE IF NOT EXISTS `#__pv_cycle_year` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cycle_id` int(11) unsigned NOT NULL DEFAULT 0,
  `year` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_cycle_to_election_unique_id` (`cycle_id`,`year`),
  KEY `pv_cycle_year_cycle_id` (`cycle_id`),
  KEY `pv_cycle_year_year` (`year`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_elections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `old_id` int(11) unsigned NOT NULL DEFAULT 0,
  `old_table` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `#__pv_elections`
  SELECT
    '' AS `id`,
    `id` AS `old_id`,
    'jos_rt_election_year' AS `old_table`,
    LEFT(TRIM(`e_year`), 4) AS `year`,
    RIGHT(TRIM(`e_year`), LENGTH(TRIM(`e_year`)) -4 ) AS `name`,
    '' AS `description`,
    0 AS `is_special`,
    1 AS `published`,
    0 AS `is_current`,
    `election_date` AS `date`,
    0 AS `checked_out`,
    @tnl AS `checked_out_time`,
    @tnow AS `created`,
    @tnow AS `updated`
  FROM `#__rt_election_year`
  ORDER BY `election_date` ASC;

CREATE TABLE IF NOT EXISTS `#__pv_link_xrefs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(11) unsigned NOT NULL DEFAULT 0,
  `right_id` int(11) unsigned NOT NULL DEFAULT 0,
  `table_id` int(11) unsigned NOT NULL DEFAULT 0,
  `order` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `#__pv_link_types` VALUES
  ('', 3,'phone','','','','symbol', '','', @tnl, @tnow, @tnow),
  ('', 1,'cell','','','','symbol', '','', @tnl, @tnow, @tnow),
  ('', 1,'fax','','','','symbol', '','', @tnl, @tnow, @tnow),
  ('', 1,'email','','','','symbol', '','', @tnl, @tnow, @tnow),
  ('', 1,'homepage','','','','symbol', '','', @tnl, @tnow, @tnow),
  ('', 1,'twitter','','','','symbol', '','', @tnl, @tnow, @tnow),
  ('', 1,'facebook','','','','symbol','', '', @tnl, @tnow, @tnow),
  ('', 1,'linkdin','','','','symbol','', '', @tnl, @tnow, @tnow);

CREATE TABLE IF NOT EXISTS `#__pv_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) unsigned NOT NULL DEFAULT 0,
  `value` varchar(255) DEFAULT NULL,
  `order` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_links_type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_officers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `seat_id` int(11) unsigned NOT NULL DEFAULT 0,
  `party_id` int(11) unsigned NOT NULL DEFAULT 0,
  `person_id` int(11) unsigned NOT NULL DEFAULT 0,
  `attributes` text NOT NULL DEFAULT '',
  `first_elected_year` smallint(5) unsigned NOT NULL DEFAULT 0,
  `last_elected_year` smallint(5) unsigned NOT NULL DEFAULT 0,
  `order` int(11) unsigned NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_offices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL DEFAULT '',
  `level` enum('local','state','federal') DEFAULT 'local',
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `ordering` int(11) unsigned NOT NULL DEFAULT 1,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_offices_level` (`level`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `#__pv_offices`
(`name`, `level`, `published`, `created`)
  SELECT DISTINCT 
    `office` AS `name`, 
    lower(`office_level`) AS `level`, 
    1 AS `published`,
    @tnow AS `created`
  FROM `#__electedofficials`
  order by `level`, `name`;

UPDATE `#__pv_offices` set `ordering` = `id`;

CREATE TABLE IF NOT EXISTS `#__pv_parties` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `abbr` varchar(10) DEFAULT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `#__pv_parties` VALUES
  ('', 'None', 'None', '', '', @tnl, @tnow, @tnow),
  ('', 'Democratic Party', 'Dem', '', '', @tnl, @tnow, @tnow),
  ('', 'Republican Party', 'Rep', '', '', @tnl, @tnow, @tnow),
  ('', 'Constitution Party', 'Con', '', '', @tnl, @tnow, @tnow),
  ('', 'Free Dominion Party', 'Fre', '', '', @tnl, @tnow, @tnow),
  ('', 'Green Party', 'Gre', '', '', @tnl, @tnow, @tnow),
  ('', 'Independant', 'Ind', '', '', @tnl, @tnow, @tnow),
  ('', 'Justice Party', 'Jus', '', '', @tnl, @tnow, @tnow),
  ('', 'Libertarian Party', 'Lib', '', '', @tnl, @tnow, @tnow),
  ('', 'Socialization & Liberation Party', 'Soc', '', '', @tnl, @tnow, @tnow);

CREATE TABLE IF NOT EXISTS `#__pv_persons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `old_id` int(11) unsigned NOT NULL DEFAULT 0,
  `old_table` varchar(100) NOT NULL DEFAULT '',
  `current_party_id` int(11) unsigned NOT NULL DEFAULT 0,
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
  KEY `pv_persons_current_party_id` (`current_party_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_seats` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` int(11) unsigned NOT NULL DEFAULT 0,
  `office_id` int(11) unsigned NOT NULL DEFAULT 0,
  `old_id` int(11) unsigned NOT NULL DEFAULT 0,
  `old_table` varchar(100) NOT NULL DEFAULT '',
  `order` int(11) unsigned NOT NULL DEFAULT 0,
  `description` text NOT NULL DEFAULT '',
  `district` text NOT NULL DEFAULT '',
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_seats_term_id` (`term_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_terms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `offset` int(11) unsigned NOT NULL DEFAULT 0,
  `length` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `#__pv_terms` VALUES
  ('', 0, 2, '2-year, no offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 0, 6, '4-year, no offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 1, 4, '4-year, 1year offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 2, 4, '4-year, 2year offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 3, 4, '4-year, 3year offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 0, 6, '6-year, no offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 4, 6, '6-year, 4year offset', 1, 0, @tnl, @tnow, @tnow);

/* ==================== FK relationships ==================== */
SET FOREIGN_KEY_CHECKS=0;


/* ==================== dynamic data ==================== */
/* ------------ pv_elections ------------ */

/* ------------ pv_cycles_year ------------ */
/* there are up to 7 cycles per office in an active election year */
SET @year=1980;
SET @cycle=0;

/* ------------ pv_seats ------------ */
SET @rank=0;
INSERT INTO `#__pv_seats`
  SELECT
    '' AS `id`,
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
    END AS term_id,
    `id` AS `old_id`,
    'jos_electedofficials' AS `old_table`,
    0 as `office_id`,
    @rank:=@rank+1 AS `order`,
    '' AS `description`,
    CONCAT_WS(
      '',
      TRIM(`congressional_district`),
      TRIM(`state_senate_district`),
      TRIM(`state_representative_district`),
      TRIM(`council_district`),
      IF(`office`='City Council At-Large','','')
    ) AS `district`,
    1 AS `published`,
    0 AS `checked_out`,
    @tnl AS checked_out_time,
    @tnow AS `created`,
    @tnow AS `updated`
    FROM `#__electedofficials` group by `id`;

/*
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL DEFAULT '',
  `level` enum('local','state','federal') DEFAULT 'local',
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
*/

/* pv_offices */
SET @rder=0;
INSERT INTO `#__pv_offices`
  (`name`, `level`, `published`, `check_out`, `checked_out_time`, `created`, `updated`)
  SELECT DISTINCT
    IF(`office`='City Council At-Large','City Council',`office`) AS `name`,
    lower(`office_level`) AS `level`,
    1 as `published`,
    0 as `checked_out`,
    @tnl as `checked_out_time`,
    @tnow AS `created`,
    @tnow AS `updated`
  FROM 
    `#__pv_seats` s,
    `#__electedofficials` e
  WHERE
    s.old_id=e.id
  ORDER BY e.`office`;

/* ------------ pv_persons ------------ */
/* "Vacant" person will be id=1*/
INSERT INTO `#__pv_persons` VALUES 
 ('', 0, '', 1, '', '', 'Vacant', '', '', '', '', '', '', 1, 0, @tnl, @tnow, @tnow);

INSERT INTO `#__pv_persons`
  SELECT
    '' AS `id`,
    `id` AS `old_id`,
    'jos_electedofficials' AS `old_table`,
    (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(p.`name`,1)=`party`) AS `current_party_id`,
    '' AS `image`,
    '' AS `prefix`,
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
    '' AS `marital_status`,
    '' AS `bio`,
    1 AS `published`,
    0 AS `checked_out`,
    @tnl AS checked_out_time,
    @tnow AS `created`,
    @tnow AS `updated`
    FROM `#__electedofficials` 
    WHERE 
      TRIM(`first_name`) NOT LIKE "VACANT" AND
      TRIM(`first_name`) IS NOT NULL AND
      TRIM(`first_name`) != ''
    ORDER BY TRIM(`first_name`) ASC, TRIM(`last_name`) ASC;

/* correct some specific existing names */
UPDATE #__pv_persons
  SET
    `first_name` = LEFT(TRIM(`first_name`),1),
    `middle_name` = RIGHT(TRIM(`first_name`), LENGTH(TRIM(`first_name`))-3)
  WHERE
    `first_name` IN ('W. Wilson','R. Seth','W. Curtis');

INSERT INTO #__pv_persons VALUES 
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Abbe'), TRIM(''), TRIM('Fletman'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Al'), TRIM(''), TRIM('Taubenberger'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Alice'), TRIM('Beck'), TRIM('Dubow'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Allan'), TRIM(''), TRIM('Domb'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Anthony'), TRIM(''), TRIM('Kyriakakis'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Betsy'), TRIM(''), TRIM('Wahl'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Bill'), TRIM(''), TRIM('Green'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Brett'), TRIM(''), TRIM('Mandell'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Carla'), TRIM(''), TRIM('Cain'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Carol'), TRIM(''), TRIM('Jenkins'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='G'), '', '', TRIM('Cheri'), TRIM(''), TRIM('Honkala'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Chris'), TRIM(''), TRIM('Mallios'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Christine'), TRIM(''), TRIM('Hope'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Christopher'), TRIM(''), TRIM('Sawyer'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Daniel'), TRIM(''), TRIM('Tinney'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Dennis'), TRIM(''), TRIM('Lee'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Derek'), TRIM(''), TRIM('Green'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Donna'), TRIM(''), TRIM('DeRose'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Doug'), TRIM(''), TRIM('Oliver'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Edward'), TRIM(''), TRIM('Louden'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Frances'), TRIM(''), TRIM('Fattah'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Frank'), TRIM(''), TRIM('Rizzo'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('George'), TRIM(''), TRIM('Matysik'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Helen'), TRIM(''), TRIM('Gym'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Isaiah'), TRIM(''), TRIM('Thomas'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('James'), TRIM(''), TRIM('Berardinelli'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('James'), TRIM(''), TRIM('Williams'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Jenne'), TRIM(''), TRIM('Ayers'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Jennifer'), TRIM(''), TRIM('Schultz'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Jodi'), TRIM(''), TRIM('Lobel'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Joffie'), TRIM(''), TRIM('Pittman'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Joseph'), TRIM(''), TRIM('Guerra'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Joshua'), TRIM(''), TRIM('Hill'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Kai'), TRIM(''), TRIM('Scott'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Ken'), TRIM(''), TRIM('Trujillo'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Kenneth'), TRIM(''), TRIM('Powell'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Kevin'), TRIM('M'), TRIM('Dougherty'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Kevin'), TRIM(''), TRIM('Strickland'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Kristin'), TRIM(''), TRIM('Combs'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Leon'), TRIM(''), TRIM('Goodman'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='I'), '', '', TRIM('Lillian'), TRIM(''), TRIM('Turner'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Lisa'), TRIM(''), TRIM('Deeley'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Lou'), TRIM(''), TRIM('Lanni'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Lucretia'), TRIM(''), TRIM('Clemons'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Lynne'), TRIM(''), TRIM('Abraham'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Lyris'), TRIM(''), TRIM('Younge'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Manny'), TRIM(''), TRIM('Morales'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Mark'), TRIM(''), TRIM('Zecca'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Marnie'), TRIM('Aument'), TRIM('Loughery'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Matt'), TRIM(''), TRIM('Wolfe'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Matthew'), TRIM(''), TRIM('Perks'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Melissa'), TRIM('Murray'), TRIM('Bailey'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='F'), '', '', TRIM('Michael'), TRIM(''), TRIM('Galganski'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Michelle'), TRIM(''), TRIM('Brownlee'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Mike'), TRIM(''), TRIM('Fanning'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Nelson'), TRIM(''), TRIM('Diaz'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Omar'), TRIM(''), TRIM('Sabir'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Ori'), TRIM(''), TRIM('Feibush'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Paul'), TRIM(''), TRIM('Steinke'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Rainy'), TRIM(''), TRIM('Papademetriou'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Ronald'), TRIM(''), TRIM('Waters'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Ross'), TRIM(''), TRIM('Feinberg'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Sabriya'), TRIM(''), TRIM('Bilal'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Scott'), TRIM(''), TRIM('DiClaudio'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Shanese'), TRIM(''), TRIM('Johnson'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Sharon'), TRIM('Williams'), TRIM('Lozier'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Sherman'), TRIM(''), TRIM('Toppin'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Sherrie'), TRIM(''), TRIM('Cohen'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Stephen'), TRIM(''), TRIM('Kinsey'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('T'), TRIM('Milton'), TRIM('Street'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Terry'), TRIM(''), TRIM('Gillen'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='R'), '', '', TRIM('Terry'), TRIM(''), TRIM('Tracy'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Tom'), TRIM(''), TRIM('Wyatt'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Tracey'), TRIM(''), TRIM('Gordon'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Vince'), TRIM(''), TRIM('Melchiorre'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Vincent'), TRIM(''), TRIM('Furlong'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Wayne'), TRIM(''), TRIM('Bennett'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Will'), TRIM(''), TRIM('Mega'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('William'), TRIM(''), TRIM('Ciancaglini'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
	('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE LEFT(`name`,1)='D'), '', '', TRIM('Wilson'), TRIM(''), TRIM('Alexander'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW());


/* ------------ pv_officers ------------ */
  /*
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `seat_id` int(11) unsigned NOT NULL DEFAULT 0,
  `party_id` int(11) unsigned NOT NULL DEFAULT 0,
  `person_id` int(11) unsigned NOT NULL DEFAULT 0,
  `attributes` text NOT NULL DEFAULT '',
  `first_elected_year` smallint(5) unsigned NOT NULL DEFAULT 0,
  `last_elected_year` smallint(5) unsigned NOT NULL DEFAULT 0,
  `order` int(11) unsigned NOT NULL DEFAULT 0,
  `published` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `checked_out` int(11) unsigned NOT NULL DEFAULT 0,
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
*/
/* TODO: refactor the next two into one... 
    will require an outer join to pv_persons and inner to electedofficials */
SET @rank=0; 

INSERT INTO `#__pv_officers` 
  SELECT 
    '' AS `id`,
    o.`id` AS `seat_id`,
    p.`current_party_id` AS `party_id`,
    p.`id` AS `person_id`,
    e.`first_elected` as `first_elected_year`,
    @rank:=@rank+1 AS `order`,
    @tnow AS `created`,
    @tnow AS `updated`
    FROM 
      `#__pv_offices` o, 
      `#__pv_persons` p,
      `#__pv_seats` s
    WHERE
      e.`id` = p.`old_id` and 
      p.`old_id` = o.`old_id`;

/* had a problem getting id to correctly autoincrement
    -- specifying id using @rank from the previous query */
INSERT INTO `#__pv_officers`
  SELECT 
    @rank:=@rank+1 AS `id`,
    o.`id` AS `office_id`,
    (SELECT id FROM #__pv_parties where `name`='None') AS `party_id`,
    (SELECT id FROM #__pv_persons where `first_name`='Vacant') AS `person_id`,
    31 AS `election_id`,
    @rank AS `order`,
    @tnl AS `created`,
    @tnl AS `updated`    
  FROM
    `#__pv_offices` o, 
    `#__electedofficials` e
  WHERE 
    o.`old_id` = e.`id` AND
    TRIM(e.`first_name`) LIKE "VACANT";

/* candidates */
  
 
/* TODO: Migrate office addresses */

/* TODO: Migrate officers addresses */

