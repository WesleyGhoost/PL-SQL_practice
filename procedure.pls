--Exemplo de PROCEDURE--

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
/