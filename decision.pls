-- Exemplos de decisão
/* 
DECLARE
  a NUMBER;
  b NUMBER;
BEGIN
  a := 0; b := 0;
  IF a = b THEN
    DBMS_OUTPUT.PUT_LINE('a igual a b');
  ELSIF a > b THEN
    DBMS_OUTPUT.PUT_LINE('a maior que b');
  ELSIF a < b THEN
    DBMS_OUTPUT.PUT_LINE('a menor que b');
  ELSE
    DBMS_OUTPUT.PUT_LINE('oooops');
  END IF;
END;
/ 
*/

/*
DECLARE
  a NUMBER;
  b NUMBER;
BEGIN
  a := NULL; b := 10;
  CASE
    WHEN a = b THEN
      DBMS_OUTPUT.PUT_LINE('a igual a b');
    WHEN a > b THEN
      DBMS_OUTPUT.PUT_LINE('a maior que b');
    WHEN a < b THEN
      DBMS_OUTPUT.PUT_LINE('a menor que b');
    ELSE
      DBMS_OUTPUT.PUT_LINE('oooops');
    END CASE;
END;
/ 
*/

DECLARE
  dia NUMBER;
  nome VARCHAR2(100);
BEGIN
  dia := 5;
  nome := CASE dia 
    WHEN 1 THEN 'Hoje é domingo'
    WHEN 2 THEN 'Hoje é segunda-feira'
    WHEN 3 THEN 'Hoje é terça-feira'
    WHEN 4 THEN 'Hoje é quarta-feira'
    WHEN 5 THEN 'Hoje é quinta-feira'
    WHEN 6 THEN 'Hoje é sexta-feira'
    WHEN 7 THEN 'Hoje é sábado'
    ELSE 'Não é um número de dia válido'
  END;
  DBMS_OUTPUT.PUT_LINE(nome);
END;
/ 
