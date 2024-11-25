-- Exemplo com commit e rollback
CREATE TABLE tab1 (a1 NUMBER, a2 NUMBER);
CREATE TABLE tab2 (b1 NUMBER, b2 NUMBER);

CREATE OR REPLACE PROCEDURE exemplo_transacao (
    aa1 NUMBER,
    aa2 NUMBER,
    bb1 NUMBER,
    bb2 NUMBER,
    commit_ou_rollback NUMBER
);
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT INTO tab1 VALUES (aa1, bb1);
  INSERT INTO tab2 VALUES (aa2, bb2);
  IF commit_ou_rollback = 1 THEN
    COMMIT;
  ELSE 
    ROLLBACK;
  END IF;
END;
/

BEGIN
  exemplo_transacao (1, 2, 30, 40, 1);
  exemplo_transacao (2, 4, 40, 60, 0);
  exemplo_transacao (3, 6, 60, 100, 1);
END;
/

SELECT * FROM tab1;
SELECT * FROM tab2;