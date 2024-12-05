--Exemplo com RETURNING--

CREATE TABLE pessoa (codigo NUMBER(5), nome VARCHAR2(50), status CHAR(1));

INSERT INTO pessoa VALUES (1, 'Ricardo', 'A');
INSERT INTO pessoa VALUES (2, 'Joares', 'A');
INSERT INTO pessoa VALUES (3, 'Roberto', 'A');
INSERT INTO pessoa VALUES (4, 'Williams', 'A');

COMMIT
/

SET SERVEROUTPUT ON;
DECLARE
  v_nome pessoa.nome%TYPE;
BEGIN
  UPDATE
  SET status = 'I'
  WHERE codigo = 1;
  RETURNING nome INTO v_nome;
  DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
END;
/

SELECT * FROM pessoa;

