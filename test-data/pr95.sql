CREATE TABLE IF NOT EXISTS vbox (
  id bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  foo varchar(40) NOT NULL,





  create_tm timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY(id));
