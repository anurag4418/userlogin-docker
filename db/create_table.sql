USE cicd;

CREATE TABLE USER_DETAILS (
  id int(10) NOT NULL auto_increment,
  firstname varchar(32),
  lastname varchar(32),
  email varchar(64),
  username varchar(32),
  password varchar(32),
  lastupdated date,
  PRIMARY KEY (id)
);
