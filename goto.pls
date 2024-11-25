-- Exemplo de GOTO
DECLARE
  fatorial NUMBER := 1;
  n NUMBER;
  i NUMBER := 0;
BEGIN
  n := 6;
  i := n;
  <<inicio_loop>>
  IF i >= 1 THEN
    fatorial := fatorial * i;
    i := i -1;
    GOTO inicio_loop;
  END IF;
  DBMS_OUTPUT.PUT_LINE('O fatorial de 6 é: ' || fatorial);
END;
/
