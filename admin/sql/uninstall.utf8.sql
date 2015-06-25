/* drop tables with constraints */
DROP TABLE IF EXISTS `#__pv_reports`;
/*  pv_reports depends on c2e */

DROP TABLE IF EXISTS `#__pv_cycle_to_election`;
DROP TABLE IF EXISTS `#__pv_link_to_office`;
DROP TABLE IF EXISTS `#__pv_link_to_person`;
DROP TABLE IF EXISTS `#__pv_link_to_seat`;
DROP TABLE IF EXISTS `#__pv_address_to_office`;
DROP TABLE IF EXISTS `#__pv_address_to_person`;
DROP TABLE IF EXISTS `#__pv_address_to_seat`;
DROP TABLE IF EXISTS `#__pv_links`;
DROP TABLE IF EXISTS `#__pv_link_types`;
DROP TABLE IF EXISTS `#__pv_persons`;

/* ...then tables with no constraints */
DROP TABLE IF EXISTS `#__pv_addresses`;
DROP TABLE IF EXISTS `#__pv_candidates`;
DROP TABLE IF EXISTS `#__pv_cycles`;
DROP TABLE IF EXISTS `#__pv_elections`;
DROP TABLE IF EXISTS `#__pv_officers`;
DROP TABLE IF EXISTS `#__pv_offices`;
DROP TABLE IF EXISTS `#__pv_parties`;
DROP TABLE IF EXISTS `#__pv_votes`;

