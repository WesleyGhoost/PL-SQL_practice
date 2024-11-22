--Exemplo de FUNCTION
CREATE OR REPLACE FUNCTION descobrir_salario (p_id IN emp.empno%type)
RETURN NUMBER
IS
  v_salario emp.sal%type := 0;
BEGIN
  SELECT sal into v_salario
  FROM emp
  WHERE empno = p_id;
  RETURN v_salario;
END descobrir_salario;
/
