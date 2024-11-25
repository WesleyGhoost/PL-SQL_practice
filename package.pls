--Exemplos de PACKAGE
/*
CREATE OR REPLACE PACKAGE exemplo_pack
IS
  PROCEDURE reajuste(
    v_codigo_emp IN emp.empno%type,
    v_porcentagem IN NUMBER
  );
  FUNCTION descobrir_salario(p_id IN emp.empno%type)
  RETURN NUMBER;
END exemplo_pack;
/

CREATE OR REPLACE PACKAGE BODY exemplo_pack
IS
  CREATE OR REPLACE PROCEDURE reajuste (
    v_codigo_emp IN emp.empno%type,
    v_porcentagem IN NUMBER
  );
  IS
    BEGIN
        UPDATE emp
          SET sal = sal + (sal * (v_porcentagem / 100));
        WHERE empno = v_codigo_emp;
        COMMIT;
    END reajuste;

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
END exemplo_pack;
/
*/

--PACKAGE com variável no corpo
/*
CREATE OR REPLACE PACKAGE pkg_string_func AS
  FUNCTION get_cont_localiza
  RETURN NUMBER;
END pkg_string_func;
/

CREATE OR REPLACE PACKAGE BODY pkg_string_func AS
  chamadas_localiza NUMBER := 0
  FUNCTION get_cont_localiza
  RETURN NUMBER
    IS
      BEGIN
        chamadas_localiza := chamadas_localiza + 1;
        RETURN chamadas_localiza;
      END;
END pkg_string_func;
/

SET SERVEROUTPUT ON;
DECLARE
  v_recebe NUMBER;
BEGIN
  SELECT (pkg_string_func.get_cont_localiza) INTO v_recebe from dual;
  DBMS_OUTPUT.PUT_LINE('O valor da variável local é: ' || v_recebe);
END;
/
*/

--PACKAGE com EXCEPTION
CREATE OR REPLACE PACKAGE pkg_dividir AS
  FUNCTION divide
  RETURN NUMBER;
END pkg_dividir;
/

CREATE OR REPLACE PACKAGE BODY pkg_dividir AS
  FUNCTION divide
  RETURN NUMBER
  IS
    x NUMBER := 10;
    y NUMBER := 5;
    resultado NUMBER;
    BEGIN
      resultado := y / x;
      RETURN resultado;
      EXCEPTION
      WHEN resultado = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Não é possível dividir por zero!');
    END;
END pkg_dividir;
/

select (pkg_dividir.divide) from DUAL;



  