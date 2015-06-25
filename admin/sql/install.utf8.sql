/* xref tables */
CREATE TABLE IF NOT EXISTS `#__pv_address_to_office`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `address_id` int(10) unsigned NOT NULL default 0,
  `office_id` int(10) unsigned NOT NULL default 0,
  `order` int(10) unsigned NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_address_to_office_fks_id` (`address_id`, `office_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_address_to_person`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `address_id` int(10) unsigned NOT NULL default 0,
  `person_id` int(10) unsigned NOT NULL default 0,
  `order` int(10) unsigned NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_address_to_person_fks_id` (`address_id`, `person_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_cycle_to_election`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `cycle_id` int(10) unsigned NOT NULL default 0,
  `election_id` int(10) unsigned NOT NULL default 0,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_cycle_to_election_fks_id` (`cycle_id`, `election_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_to_office`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `link_id` int(10) unsigned NOT NULL default 0,
  `office_id` int(10) unsigned NOT NULL default 0,
  `order` int(10) unsigned NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_link_to_office_fks_id` (`link_id`, `office_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_to_person`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `link_id` int(10) unsigned NOT NULL default 0,
  `person_id` int(10) unsigned NOT NULL default 0,
  `order` int(10) unsigned NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_link_to_person_fks_id` (`link_id`, `person_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_candidates`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `office_id` int(10) unsigned NOT NULL default 0,
  `party_id` int(10) unsigned NOT NULL default 0,
  `person_id` int(10) unsigned NOT NULL default 0,
  `election_id` int(10) unsigned NOT NULL default 0,
  `order` int(10) unsigned NOT NULL default 0,
  `is_incumbent` tinyint(1) unsigned NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_candidates_fks_id` (`office_id`, `person_id`, `party_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_officers`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `office_id` int(10) unsigned NOT NULL default 0,
  `party_id` int(10) unsigned NOT NULL default 0,
  `person_id` int(10) unsigned NOT NULL default 0,
  `election_id` int(10) unsigned NOT NULL default 0,
  `order` int(10) unsigned NOT NULL default 0,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_officers_fks_id` (`office_id`, `person_id`, `party_id`, `election_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* entity tables */
CREATE TABLE IF NOT EXISTS `#__pv_addresses`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `address1` varchar(100) default NULL,
  `address2` varchar(100) default NULL,
  `address3` varchar(100) default NULL,
  `city` varchar(100) default NULL,
  `region` varchar(100) default NULL,
  `postcode` varchar(100) default NULL,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_cycles`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text NOT NULL,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_elections`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `old_id` int(10) unsigned NOT NULL default 0,
  `old_table` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `description` text NOT NULL,
  `is_special` tinyint(1) unsigned NOT NULL default 0,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `is_current` tinyint(1) unsigned NOT NULL default 0,
  `date` date NOT NULL default '0000-00-00',
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_link_types`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `limit` int(10) default 0 COMMENT '0 for no limit, 1 or greater for a specific limit',
  `name` varchar(255) default NULL,
  `symbol` varchar(20) default NULL COMMENT 'html code',
  `glyph` varchar(20) default NULL COMMENT 'favicon definition',
  `image` varchar(255) default NULL,
  `prefer` enum('symbol', 'glyph', 'image') default 'symbol',
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_links`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `type_id` int(10) unsigned NOT NULL default 0,
  `order` int(10) unsigned NOT NULL default 0,
  `value` varchar(255) default NULL,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_offices`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `term_id` int(10) unsigned NOT NULL default 0,
  `old_id` int(10) unsigned NOT NULL default 0,
  `old_table` varchar(100) NOT NULL default '',
  `order` int(10) unsigned NOT NULL default 0,
  `name` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `attributes` text NOT NULL,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `pv_offices_fks_id` (`term_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE if NOT EXISTS `#__pv_parties`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `abbr` varchar(10) default NULL,
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_persons`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `old_id` int(10) unsigned NOT NULL default 0,
  `old_table` varchar(100) NOT NULL default '',
  `current_party_id` int(10) unsigned Not NULL default 0,
  `image` varchar(255) default null,
  `prefix` varchar(25) default NULL,
  `first_name` varchar(40) default NULL,
  `middle_name` varchar(40) default NULL,
  `last_name` varchar(40) default NULL,
  `suffix` varchar(25) default NULL,
  `gender` char(1) default NULL,
  `marital_status` char(1) default NULL,
  `bio` text NOT NULL,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_reports`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `candidate_id` int(10) unsigned NOT NULL default 0,
  `cycle_to_election_id` int(10) unsigned NOT NULL default 0,
  `name` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `coe_id` (`candidate_id`, `cycle_to_election_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__pv_terms`(
  `id` int(10) unsigned NOT NULL auto_increment,
  `offset` int(10) unsigned NOT NULL default 0,
  `length` int(10) unsigned NOT NULL default 0,
  `name` varchar(255) default NULL,
  `published` tinyint(1) unsigned NOT NULL default 0,
  `checked_out` int(10) NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

/* insert data */
INSERT INTO `#__pv_terms` VALUES
  ('', 0, 2, '2-year, no offset', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 0, 6, '4-year, no offset', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1, 4, '4-year, 1year offset', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 2, 4, '4-year, 2year offset', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 3, 4, '4-year, 3year offset', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 0, 6, '6-year, no offset', 1, 0, '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 4, 6, '6-year, 4year offset', 1, 0, '0000-00-00 00:00:00', NOW(), NOW());

INSERT INTO `#__pv_parties` VALUES
  ('', 'Democratic', 'Dem', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 'Republican', 'Rep', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 'Libertarian', 'Lib', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 'Green', 'Gre', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 'Constitution', 'Con', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 'Justice', 'Jus', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 'Socialization & Liberation', 'Lib', '', '0000-00-00 00:00:00', NOW(), NOW());

INSERT INTO `#__pv_link_types` VALUES
  ('', 3,'phone','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1,'cell','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1,'fax','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1,'email','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1,'homepage','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1,'twitter','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1,'facebook','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 1,'linkdin','','','','symbol', '', '0000-00-00 00:00:00', NOW(), NOW());

INSERT INTO `#__pv_cycles` values
  ('', 1, 'First Cycle', '', 1, '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 2, 'Second Cycle', '', 2, '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 3, 'Third Cycle', '', 3, '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 4, 'Fourth Cycle', '', 4, '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 5, 'Fifth Cycle', '', 5, '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 6, 'Sixth Cycle', '', 6, '', '0000-00-00 00:00:00', NOW(), NOW()),
  ('', 7, 'Seventh Cycle', '', 7, '', '0000-00-00 00:00:00', NOW(), NOW());

INSERT INTO `#__pv_elections`
  SELECT
    '' AS `id`,
    `id` AS `old_id`,
    'jos_rt_election_year' AS `old_table`,
    `e_year` AS `name`,
    '' AS `description`,
    0 AS `is_special`,
    1 AS `published`,
    0 AS `is_current`,
    `election_date` AS `date`,
    0 AS `checked_out`,
    '0000-00-00 00:00:00' AS `checked_out_time`,
    NOW() AS `created`,
    NOW() AS `updated`
  FROM `#__rt_election_year`
  ORDER BY `election_date` ASC;

INSERT INTO `#__pv_elections`
  SELECT
    '' AS `id`,
    `id` AS `old_id`,
    'jos_rt_election' AS `old_table`,
    `name` AS `name`,
    '' AS `description`,
    `special_election` AS `is_special`,
    1 AS `published`,
    0 AS `is_current`,
    `election_date` AS `date`,
    0 AS `checked_out`,
    '0000-00-00 00:00:00' AS `checked_out_time`,
    NOW() AS `created`,
    NOW() AS `updated`
  FROM `#__rt_election`
  ORDER BY `election_date` ASC;

/*
Federal	President of the United States	2008	2016	4
federal	U.S. Representative	2014	2018	4
federal	U.S. Senate	2010	2018	6	class 1
federal U.S. Senate 1234    1234	6	class 3
state	State Representative	2015	2014
state	State Senator	2015	2016
state	State Treasurer	2008	2016
state	Governor	2014	2018
state	Lieutenant Governor	2014	2018
state	Attorney General	2012	2016
state	Auditor General	2012	2016
local	City Commissioner	2011	2015
local	Mayor	2007	2015
local	City Council	2011	2015
local	City Council At-Large	2014	2015
local	Register of Wills	1979	2015
local	Sheriff	2011	2015
local	City Controller	2005	2013
local	District Attorney	2009	2013

    1 - 2-yr us reps, state reps
    2 - 4-yr presidential, state senate odd, state treasurer, state atty,state auditor
    3 - 4-yr+1 city controller, city DA,
    4 - 4-yr+2 state senate even, governor, lietenant governor
    5 - 4-yr+3 city comms, city council (all), mayor, register of wills, sheriff
    6 - 6-year us senate class 1
    7 - 6-year+4 us senate class 3
*/

SET @rank=0;
INSERT INTO `#__pv_offices`
  SELECT
    '' AS `id`,
    CASE `office`
      WHEN "Attorney General" THEN 2
      WHEN "Auditor General" THEN 2
      WHEN "City Commissioner" THEN 5
      WHEN "City Controller" THEN 3
      WHEN "City Council At-Large" THEN 5
      WHEN "City Council" THEN 5
      WHEN "District Attorney" THEN 3
      WHEN "Governor" THEN 4
      WHEN "Lieutenant Governor" THEN 4
      WHEN "Mayor" THEN "executive"
      WHEN "President of the United States" THEN 2
      WHEN "Register of Wills" THEN 5
      WHEN "Sheriff" THEN 5
      WHEN "State Representative" THEN 1
      WHEN "State Senator" THEN IF(`state_senate_district` % 2, 2, 4)
      WHEN "State Treasurer" THEN 2
      WHEN "U.S. Representative" THEN 1
      WHEN "U.S. Senate" THEN IF(`next_election` % 3, 7, 6)
    end as term_id,
    `id` AS `old_id`,
    'jos_electedofficials' AS `old_table`,
    @rank:=@rank+1 AS `order`,
    `office` AS `name`,
    '' AS `description`,
    CONCAT(
   	  'level:',
      `office_level`,
      ';district:',
      CONCAT_WS('',`congressional_district`,`state_senate_district`,`state_representative_district`,`council_district`),
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
      end,
      ';'
    ) AS `attributes`,
    1 AS `published`,
    0 AS `checked_out`,
    '0000-00-00 00:00:00' AS checked_out_time,
    NOW() AS `created`,
    NOW() AS `updated`
    FROM `#__electedofficials` group by `id`;

SET @current_election_id = LAST_INSERT_ID();

/* there are up to 7 cycles per office in an active election year */
INSERT INTO `#__pv_cycle_to_election` VALUES
  ('', 1, @current_election_id, 1, NOW(), NOW()),
  ('', 2, @current_election_id, 1, NOW(), NOW()),
  ('', 3, @current_election_id, 1, NOW(), NOW()),
  ('', 4, @current_election_id, 1, NOW(), NOW()),
  ('', 5, @current_election_id, 1, NOW(), NOW()),
  ('', 6, @current_election_id, 1, NOW(), NOW()),
  ('', 7, @current_election_id, 1, NOW(), NOW());

INSERT INTO `#__pv_persons`
  SELECT
    '' AS `id`,
    `id` AS `old_id`,
    'jos_electedofficials' AS `old_table`,
    (SELECT `id` FROM `#__pv_parties` p WHERE `party`=LEFT(`p`.`name`,1)) AS `current_party_id`,
    '' AS `image`,
    '' AS `prefix`,
    TRIM(`first_name`) AS `first_name`,
    REPLACE(TRIM(`middle_name`),'\.','') AS `middle_name`,
    TRIM(`last_name`) AS `last_name`,
    REPLACE(TRIM(`suffix`),'\.','') as `suffix`,
    CASE `first_name`
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
    '0000-00-00 00:00:00' AS checked_out_time,
    NOW() AS `created`,
    NOW() AS `updated`
    FROM `#__electedofficials` group by `id`;

UPDATE #__pv_persons
  SET
    `first_name` = LEFT(`first_name`,1),
    `middle_name` = RIGHT(`middle_name`, LENGTH(`middle_name`)-3)
  WHERE
    `first_name` IN ('W. Wilson','R. Seth','W. Curtis');

SET @rank=0;
INSERT INTO `#__pv_officers` 
  SELECT 
    '' as `id`,
    `o`.`id` as `office_id`,
    `p`.`current_party_id` as `party_id`,
    `p`.`id` as `person_id`,
    0 as `election_id`,
    @rank:=@rank+1 AS `order`,
    '0000-00-00 00:00:00' as `created`,
    '0000-00-00 00:00:00' as `updated`
    FROM 
      `#__pv_offices` `o`, 
      `#__pv_persons` `p` 
    WHERE
      `p`.`old_id` = `o`.`old_id`;