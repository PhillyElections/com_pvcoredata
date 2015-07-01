/* ==================== tables ==================== */
CREATE TABLE IF NOT EXISTS `#__pv_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `address3` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_address_to_office` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address_id` int(10) unsigned NOT NULL DEFAULT '0',
  `office_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_address_to_office_unique_id` (`address_id`,`office_id`),
  KEY `pv_address_to_office_address_id` (`address_id`),
  KEY `pv_address_to_office_office_id` (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_address_to_person` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address_id` int(10) unsigned NOT NULL DEFAULT '0',
  `person_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_address_to_person_unique_id` (`address_id`,`person_id`),
  KEY `pv_address_to_person_address_id` (`address_id`),
  KEY `pv_address_to_person_person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_candidates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `office_id` int(10) unsigned NOT NULL DEFAULT '0',
  `party_id` int(10) unsigned NOT NULL DEFAULT '0',
  `person_id` int(10) unsigned NOT NULL DEFAULT '0',
  `election_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `is_incumbent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_candidates_unique_id` (`office_id`,`person_id`,`party_id`),
  KEY `pv_candidates_office_id` (`office_id`),
  KEY `pv_candidates_person_id` (`person_id`),
  KEY `pv_candidates_party_id` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_cycles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_cycle_year` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cycle_id` int(10) unsigned NOT NULL DEFAULT '0',
  `year` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_cycle_to_election_unique_id` (`cycle_id`,`year`),
  KEY `pv_cycle_year_cycle_id` (`cycle_id`),
  KEY `pv_cycle_year_year` (`year`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_elections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_id` int(10) unsigned NOT NULL DEFAULT '0',
  `old_table` varchar(255) DEFAULT NULL,
  `year` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `is_special` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_current` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `date` date NOT NULL DEFAULT '0000-00-00',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_elections_year` (`year`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) DEFAULT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_links_type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_to_office` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(10) unsigned NOT NULL DEFAULT '0',
  `office_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_link_to_office_uniqe_id` (`link_id`,`office_id`),
  KEY `pv_link_to_office_link_id` (`link_id`),
  KEY `pv_link_to_office_office_id` (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_to_person` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(10) unsigned NOT NULL DEFAULT '0',
  `person_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_link_to_person_unique_id` (`link_id`,`person_id`),
  KEY `pv_link_to_person_link_id` (`link_id`),
  KEY `pv_link_to_person_person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `limit` int(10) DEFAULT '0' COMMENT '0 for no limit, 1 or greater for a specific limit',
  `name` varchar(255) DEFAULT NULL,
  `symbol` varchar(20) DEFAULT NULL COMMENT 'html code',
  `glyph` varchar(20) DEFAULT NULL COMMENT 'favicon definition',
  `image` varchar(255) DEFAULT NULL,
  `prefer` enum('symbol','glyph','image') DEFAULT 'symbol',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_officers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `office_id` int(10) unsigned NOT NULL DEFAULT '0',
  `party_id` int(10) unsigned NOT NULL DEFAULT '0',
  `person_id` int(10) unsigned NOT NULL DEFAULT '0',
  `election_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_officers_uniqe_id` (`office_id`,`person_id`,`party_id`,`election_id`),
  KEY `pv_officers_office_id` (`office_id`),
  KEY `pv_officers_person_id` (`person_id`),
  KEY `pv_officers_party_id` (`party_id`),
  KEY `pv_officers_election_id` (`election_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_offices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` int(10) unsigned NOT NULL DEFAULT '0',
  `old_id` int(10) unsigned NOT NULL DEFAULT '0',
  `old_table` varchar(100) NOT NULL DEFAULT '',
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `attributes` text NOT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_offices_term_id` (`term_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_parties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `abbr` varchar(10) DEFAULT NULL,
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_persons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_id` int(10) unsigned NOT NULL DEFAULT '0',
  `old_table` varchar(100) NOT NULL DEFAULT '',
  `current_party_id` int(10) unsigned NOT NULL DEFAULT '0',
  `image` varchar(255) DEFAULT NULL,
  `prefix` varchar(25) DEFAULT NULL,
  `first_name` varchar(40) DEFAULT NULL,
  `middle_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `suffix` varchar(25) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `marital_status` char(1) DEFAULT NULL,
  `bio` text NOT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_persons_current_party_id` (`current_party_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `candidate_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cycle_to_election_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pv_reports_unique_id` (`candidate_id`,`cycle_to_election_id`),
  KEY `pv_reports_candidate_id` (`candidate_id`),
  KEY `pv_reports_cycle_to_election_id` (`cycle_to_election_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_terms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `offset` int(10) unsigned NOT NULL DEFAULT '0',
  `length` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

/* ==================== FK relationships ==================== */
SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE `jos_pv_address_to_office`
  ADD CONSTRAINT `jos_pv_address_to_office_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `jos_pv_addresses` (`id`),
  ADD CONSTRAINT `jos_pv_address_to_office_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `jos_pv_offices` (`id`);

ALTER TABLE `jos_pv_address_to_person`
  ADD CONSTRAINT `jos_pv_address_to_person_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `jos_pv_addresses` (`id`),
  ADD CONSTRAINT `jos_pv_address_to_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `jos_pv_persons` (`id`);

ALTER TABLE `jos_pv_candidates`
  ADD CONSTRAINT `jos_pv_candidates_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `jos_pv_offices` (`id`),
  ADD CONSTRAINT `jos_pv_candidates_ibfk_2` FOREIGN KEY (`party_id`) REFERENCES `jos_pv_parties` (`id`),
  ADD CONSTRAINT `jos_pv_candidates_ibfk_3` FOREIGN KEY (`person_id`) REFERENCES `jos_pv_persons` (`id`);

ALTER TABLE `jos_pv_cycle_year`
  ADD CONSTRAINT `jos_pv_cycle_year_ibfk_1` FOREIGN KEY (`cycle_id`) REFERENCES `jos_pv_cycles` (`id`),
  ADD CONSTRAINT `jos_pv_cycle_year_ibfk_2` FOREIGN KEY (`year`) REFERENCES `jos_pv_elections` (`year`);

ALTER TABLE `jos_pv_links`
  ADD CONSTRAINT `jos_pv_links_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `jos_pv_link_types` (`id`);

ALTER TABLE `jos_pv_link_to_office`
  ADD CONSTRAINT `jos_pv_link_to_office_ibfk_1` FOREIGN KEY (`link_id`) REFERENCES `jos_pv_links` (`id`),
  ADD CONSTRAINT `jos_pv_link_to_office_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `jos_pv_offices` (`id`);

ALTER TABLE `jos_pv_link_to_person`
  ADD CONSTRAINT `jos_pv_link_to_person_ibfk_1` FOREIGN KEY (`link_id`) REFERENCES `jos_pv_links` (`id`),
  ADD CONSTRAINT `jos_pv_link_to_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `jos_pv_persons` (`id`);

ALTER TABLE `jos_pv_officers`
  ADD CONSTRAINT `jos_pv_officers_ibfk_1` FOREIGN KEY (`election_id`) REFERENCES `jos_pv_elections` (`id`),
  ADD CONSTRAINT `jos_pv_officers_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `jos_pv_offices` (`id`),
  ADD CONSTRAINT `jos_pv_officers_ibfk_3` FOREIGN KEY (`party_id`) REFERENCES `jos_pv_parties` (`id`),
  ADD CONSTRAINT `jos_pv_officers_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `jos_pv_persons` (`id`);

ALTER TABLE `jos_pv_offices`
  ADD CONSTRAINT `jos_pv_offices_ibfk_1` FOREIGN KEY (`term_id`) REFERENCES `jos_pv_terms` (`id`);

ALTER TABLE `jos_pv_persons`
  ADD CONSTRAINT `jos_pv_persons_ibfk_1` FOREIGN KEY (`current_party_id`) REFERENCES `jos_pv_parties` (`id`);

ALTER TABLE `jos_pv_reports`
  ADD CONSTRAINT `jos_pv_reports_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `jos_pv_candidates` (`id`),
  ADD CONSTRAINT `jos_pv_reports_ibfk_2` FOREIGN KEY (`cycle_to_election_id`) REFERENCES `jos_pv_cycle_year` (`id`);



/* ==================== constants ==================== */
SET @tnow = NOW();
SET @tnl  = '0000-00-00 00:00:00';
SET @tns  = '0000-00-00';

/* ==================== static data ==================== */
/* ------------ pv_cycles ------------ */
INSERT INTO `#__pv_cycles` values
  ('', 1, 'First Cycle', '', 1, '', @tnl, @tnow, @tnow),
  ('', 2, 'Second Cycle', '', 2, '', @tnl, @tnow, @tnow),
  ('', 3, 'Third Cycle', '', 3, '', @tnl, @tnow, @tnow),
  ('', 4, 'Fourth Cycle', '', 4, '', @tnl, @tnow, @tnow),
  ('', 5, 'Fifth Cycle', '', 5, '', @tnl, @tnow, @tnow),
  ('', 6, 'Sixth Cycle', '', 6, '', @tnl, @tnow, @tnow),
  ('', 7, 'Seventh Cycle', '', 7, '', @tnl, @tnow, @tnow);

/* ------------ pv_link_types ------------ */
INSERT INTO `#__pv_link_types` VALUES
  ('', 3,'phone','','','','symbol', '', @tnl, @tnow, @tnow),
  ('', 1,'cell','','','','symbol', '', @tnl, @tnow, @tnow),
  ('', 1,'fax','','','','symbol', '', @tnl, @tnow, @tnow),
  ('', 1,'email','','','','symbol', '', @tnl, @tnow, @tnow),
  ('', 1,'homepage','','','','symbol', '', @tnl, @tnow, @tnow),
  ('', 1,'twitter','','','','symbol', '', @tnl, @tnow, @tnow),
  ('', 1,'facebook','','','','symbol', '', @tnl, @tnow, @tnow),
  ('', 1,'linkdin','','','','symbol', '', @tnl, @tnow, @tnow);

/* ------------ pv_parties ------------ */
INSERT INTO `#__pv_parties` VALUES
  ('', 'None', 'None', '', @tnl, @tnow, @tnow),
  ('', 'Democratic', 'Dem', '', @tnl, @tnow, @tnow),
  ('', 'Republican', 'Rep', '', @tnl, @tnow, @tnow),
  ('', 'Libertarian', 'Lib', '', @tnl, @tnow, @tnow),
  ('', 'Green', 'Gre', '', @tnl, @tnow, @tnow),
  ('', 'Constitution', 'Con', '', @tnl, @tnow, @tnow),
  ('', 'Justice', 'Jus', '', @tnl, @tnow, @tnow),
  ('', 'Socialization & Liberation', 'Lib', '', @tnl, @tnow, @tnow);

/* ------------ pv_terms ------------ */
INSERT INTO `#__pv_terms` VALUES
  ('', 0, 2, '2-year, no offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 0, 6, '4-year, no offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 1, 4, '4-year, 1year offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 2, 4, '4-year, 2year offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 3, 4, '4-year, 3year offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 0, 6, '6-year, no offset', 1, 0, @tnl, @tnow, @tnow),
  ('', 4, 6, '6-year, 4year offset', 1, 0, @tnl, @tnow, @tnow);

/* ==================== dynamic data ==================== */
/* ------------ pv_elections ------------ */
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

/* ------------ pv_cycles_year ------------ */
/* there are up to 7 cycles per office in an active election year */
INSERT INTO `#__pv_cycle_year` VALUES
  ('', 1, 2015, 1, @tnow, @tnow),
  ('', 2, 2015, 1, @tnow, @tnow),
  ('', 3, 2015, 1, @tnow, @tnow),
  ('', 4, 2015, 1, @tnow, @tnow),
  ('', 5, 2015, 1, @tnow, @tnow),
  ('', 6, 2015, 1, @tnow, @tnow),
  ('', 7, 2015, 1, @tnow, @tnow);


/* ------------ pv_offices ------------ */
SET @rank=0;
INSERT INTO `#__pv_offices`
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
    @rank:=@rank+1 AS `order`,
    `office` AS `name`,
    '' AS `description`,
    CONCAT(
   	  'level:',
      `office_level`,
      ';district:',
      CONCAT_WS('',TRIM(`congressional_district`),TRIM(`state_senate_district`),TRIM(`state_representative_district`),TRIM(`council_district`)),
      ';body:',
      CASE `office` 
        WHEN "U.S. Senate" THEN "senate" 
        WHEN "U.S. Representative" THEN "house" 
        WHEN "Governor" THEN "executive" 
        WHEN "Lieutenant Governor" THEN "executive" 
        WHEN "Attorney General" THEN "executive" 
        WHEN "Auditor General" THEN "executive" 
        WHEN "State Treasurer" THEN "executive" 
        WHEN "State Senator" THEN "senate" 
        WHEN "State Representative" THEN "house" 
        WHEN "Mayor" THEN "executive" 
        WHEN "District Attorney" THEN "executive" 
        WHEN "City Controller" THEN "executive" 
        WHEN "Register of Wills" THEN "executive" 
        WHEN "Sheriff" THEN "executive" 
        WHEN "City Commissioner" THEN "commission" 
        WHEN "City Council" THEN "council" 
        WHEN "City Council At-Large" THEN "council" 
        WHEN "President of the United States" THEN "executive" 
      END,
      ';'
    ) AS `attributes`,
    1 AS `published`,
    0 AS `checked_out`,
    @tnl AS checked_out_time,
    @tnow AS `created`,
    @tnow AS `updated`
    FROM `#__electedofficials` group by `id`;

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
    TRIM(`first_name`) AS `first_name`,
    REPLACE(TRIM(`middle_name`),'\.','') AS `middle_name`,
    TRIM(`last_name`) AS `last_name`,
    REPLACE(TRIM(`suffix`),'\.','') AS `suffix`,
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
    GROUP BY `id`;

/* correct some specific existing names */
UPDATE #__pv_persons
  SET
    `first_name` = LEFT(TRIM(`first_name`),1),
    `middle_name` = RIGHT(TRIM(`first_name`), LENGTH(TRIM(`first_name`))-3)
  WHERE
    `first_name` IN ('W. Wilson','R. Seth','W. Curtis');

INSERT INTO #__pv_persons VALUES 
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Abbe'), TRIM(''), TRIM('Fletman'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='R'), '', 'Mr', TRIM('Al'), TRIM(''), TRIM('Taubenberger'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Alice'), TRIM('Beck'), TRIM('Dubow'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Allan'), TRIM(''), TRIM('Domb'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Anthony'), TRIM(''), TRIM('Kyriakakis'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Betsy'), TRIM(''), TRIM('Wahl'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Bill'), TRIM(''), TRIM('Green'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Brett'), TRIM(''), TRIM('Mandell'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Carla'), TRIM(''), TRIM('Cain'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Carol'), TRIM(''), TRIM('Jenkins'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='G'), '', 'Mr', TRIM('Cheri'), TRIM(''), TRIM('Honkala'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Chris'), TRIM(''), TRIM('Mallios'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Christine'), TRIM(''), TRIM('Hope'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Christopher'), TRIM(''), TRIM('Sawyer'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='R'), '', 'Mr', TRIM('Daniel'), TRIM(''), TRIM('Tinney'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Dennis'), TRIM(''), TRIM('Lee'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Derek'), TRIM(''), TRIM('Green'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Donna'), TRIM(''), TRIM('DeRose'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Doug'), TRIM(''), TRIM('Oliver'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Edward'), TRIM(''), TRIM('Louden'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Frances'), TRIM(''), TRIM('Fattah'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Frank'), TRIM(''), TRIM('Rizzo'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('George'), TRIM(''), TRIM('Matysik'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Helen'), TRIM(''), TRIM('Gym'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Isaiah'), TRIM(''), TRIM('Thomas'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('James'), TRIM(''), TRIM('Berardinelli'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='R'), '', 'Mr', TRIM('James'), TRIM(''), TRIM('Williams'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Jenne'), TRIM(''), TRIM('Ayers'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Jennifer'), TRIM(''), TRIM('Schultz'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Jodi'), TRIM(''), TRIM('Lobel'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Joffie'), TRIM(''), TRIM('Pittman'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Joseph'), TRIM(''), TRIM('Guerra'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Joshua'), TRIM(''), TRIM('Hill'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Kai'), TRIM(''), TRIM('Scott'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Ken'), TRIM(''), TRIM('Trujillo'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Kenneth'), TRIM(''), TRIM('Powell'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Kevin'), TRIM('M'), TRIM('Dougherty'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='R'), '', 'Mr', TRIM('Kevin'), TRIM(''), TRIM('Strickland'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Kristin'), TRIM(''), TRIM('Combs'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Larry'), TRIM(''), TRIM('Farnese'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Leon'), TRIM(''), TRIM('Goodman'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Lillian'), TRIM(''), TRIM('Turner'), TRIM(''), 'f', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Lisa'), TRIM(''), TRIM('Deeley'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Lou'), TRIM(''), TRIM('Lanni'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Lucretia'), TRIM(''), TRIM('Clemons'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Lynne'), TRIM(''), TRIM('Abraham'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Lyris'), TRIM(''), TRIM('Younge'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Manny'), TRIM(''), TRIM('Morales'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Maria'), TRIM(''), TRIM('Quinones-Sanchez'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Mark'), TRIM(''), TRIM('Zecca'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Marnie'), TRIM('Aument'), TRIM('Loughery'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Matt'), TRIM(''), TRIM('Wolfe'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Matthew'), TRIM(''), TRIM('Perks'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Melissa'), TRIM('Murray'), TRIM('Bailey'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Michael'), TRIM(''), TRIM('Galganski'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='R'), '', 'Mr', TRIM('Michelle'), TRIM(''), TRIM('Brownlee'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Mike'), TRIM(''), TRIM('Fanning'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Milton'), TRIM(''), TRIM('Street'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Nelson'), TRIM(''), TRIM('Diaz'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Omar'), TRIM(''), TRIM('Sabir'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Ori'), TRIM(''), TRIM('Feibush'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Paul'), TRIM(''), TRIM('Steinke'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Rainy'), TRIM(''), TRIM('Papademetriou'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Ronald'), TRIM(''), TRIM('Waters'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Ross'), TRIM(''), TRIM('Feinberg'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Sabriya'), TRIM(''), TRIM('Bilal'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Scott'), TRIM(''), TRIM('Diclaudio'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Shanese'), TRIM(''), TRIM('Johnson'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Sharon'), TRIM('William'), TRIM('Lozier'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Sherman'), TRIM(''), TRIM('Toppin'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Sherrie'), TRIM(''), TRIM('Cohen'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Stephen'), TRIM(''), TRIM('Kinsey'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('T'), TRIM('Milton'), TRIM('Street'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Terry'), TRIM(''), TRIM('Gillen'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Terry'), TRIM(''), TRIM('Tracy'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Tom'), TRIM(''), TRIM('Wyatt'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Tracey'), TRIM(''), TRIM('Gordon'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Vince'), TRIM(''), TRIM('Melchiorre'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Vincent'), TRIM(''), TRIM('Furlong'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Wayne'), TRIM(''), TRIM('Bennett'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Will'), TRIM(''), TRIM('Mega'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('William'), TRIM(''), TRIM('Ciancaglini'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
 ('', 0, '', (SELECT `id` FROM `#__pv_parties` p WHERE `party`='D'), '', 'Mr', TRIM('Wilson'), TRIM(''), TRIM('Alexander'), TRIM(''), 'm', 'm', '', 1, 0, '0000-00-00 00:00:00', NOW(), NOW());


/* ------------ pv_officers ------------ */
/* TODO: refactor the next two into one... 
    will require an outer join to pv_persons and inner to electedofficials */
SET @rank=0; /* `order` needs to be incremented */
INSERT INTO `#__pv_officers` 
  SELECT 
    '' AS `id`,
    o.`id` AS `office_id`,
    p.`current_party_id` AS `party_id`,
    p.`id` AS `person_id`,
    31 AS `election_id`,
    @rank:=@rank+1 AS `order`,
    @tnow AS `created`,
    @tnow AS `updated`
    FROM 
      `#__pv_offices` o, 
      `#__pv_persons` p 
    WHERE
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
    TRIM(e.`first_name`) LIKE "VACANT"

/* TODO: Migrate office addresses */

/* TODO: Migrate officers addresses */

