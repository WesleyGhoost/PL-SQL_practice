--Exemplo de Recursão 
CREATE OR REPLACE FUNCTION calcular_fatorial(n IN NUMBER)
RETURN NUMBER
IS
BEGIN
  IF n = 2 THEN
    RETURN 2;
  ELSE 
    RETURN n * calcular_fatorial(n - 1);
  END IF;
END;
/