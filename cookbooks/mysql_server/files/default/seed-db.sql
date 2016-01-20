CREATE TABLE data_table(
  id INT NOT NULL AUTO_INCREMENT,
  value_a VARCHAR(64),
  value_b VARCHAR(64),
  value_c VARCHAR(64),
  PRIMARY KEY(id)
);

INSERT INTO data_table ( value_a, value_b, value_c ) VALUES ( 'xxx', 'yyy', 'zzz' );
INSERT INTO data_table ( value_a, value_b, value_c ) VALUES ( 'aaa', 'bbb', 'ccc' );
INSERT INTO data_table ( value_a, value_b, value_c ) VALUES ( 'a1b1', 'a2b2', 'x3z3' );
