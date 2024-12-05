--Exemplos com CURSOR--

-- Exemplo com cursor implicíto;
/*
VARIABLE linhas_deletadas VARCHAR2(30);
DECLARE
    v_deptno NUMBER:= 10;
BEGIN
    DELETE FROM EMP
    WHERE deptno = v_deptno;
    :linhas_deletadas := (SQL%ROWCOUNT || ' linhas deletadas');
END;
/

PRINT linhas_deletadas
rollback;
*/



-- Exemplo cursor explicíto
/*
ACCEPT p_cargo_func PROMPT 'Digite o cargo do funcionario'

VARIABLE g_n_ocorrencias NUMBER;
CREATE TABLE sal_tot (ename VARCHAR2(30), sal_mes NUMBER(7, 2), sal_tot NUMBER(7, 2));

DECLARE
    v_cargo_func emp.job%TYPE := UPPER('&p_cargo_func');
    v_nome_func emp.ename%TYPE;
    v_sal_mes := emp.sal%TYPE;
    v_sal_tot NUMBER(7, 2);

    CURSOR sal_func_cursor IS
        SELECT ename, sal, sal * 12
        FROM emp
        WHERE job = v_cargo_func;
BEGIN
    OPEN sal_func_cursor;
    LOOP
    FETCH sal_func_cursor INTO v_nome_func, v_sal_mes, v_sal_tot;
    EXIT WHEN sal_func_cursor%NOTFOUND;
    INSERT INTO sal_tot (ename, sal_mes, sal_tot) VALUES (v_nome_func, v_sal_mes, v_sal_tot);
    END LOOP;
        g_n_ocorrencias := sal_func_cursor%ROWCOUNT;
        CLOSE sal_func_cursor;
END;
/

PRINT g_n_ocorrencias;
SELECT * FROM sal_tot;
*/



-- Exemplo com BULK COLLECT;
/*
CREATE OR REPLACE PROCEDURE bucket_exemplo IS
    CURSOR func_prod IS
    SELECT empno, ename 
    FROM emp
    ORDER BY ename;

TYPE empno_func IS TABLE OF emp.empno%TYPE
INDEX BY BINARY_INTEGER;

TYPE ename_func IS TABLE OF emp.ename%TYPE
INDEX BY BINARY_INTEGER;

v_codigo_func empno_func;
v_nome_func ename_func;
v_indice BINARY_INTEGER;

BEGIN
    OPEN func_prod;
    FETCH func_prod BULK COLLECT INTO v_codigo_func, v_nome_func;
    EXIT func_prod;

    FOR v_indice 1.. v_codigo_func.count LOOP
        DBMS_OUTPUT.PUT_LINE(v_codigo_func(v_indice) || '-' || v_nome_func(v_indice))
    END LOOP;
END;
/
*/



-- Exemplo com FORALL;
/*
CREATE OR REPLACE PROCEDURE pr_exemplo_mostra IS
    CURSOR func_prod IS
    SELECT empno, ename, sal
    FROM emp 
    ORDER BY ename;

    TYPE empno_func IS TABLE OF emp.empno%TYPE
    INDEX BY BINARY INTEGER;

    TYPE ename_func IS TABLE OF emp.ename%TYPE
    INDEX BY BINARY INTEGER;

    TYPE sal_func IS TABLE OF emp.sal%TYPE
    INDEX BY BINARY INTEGER;

    v_codigo_func empno_func;
    v_nome_func ename_func;
    v_sal_func sal_func;
    v_indice BINARY INTEGER;

    BEGIN
        OPEN func_prod;
        FETCH func_prod BULK COLLECT INTO v_codigo_func, v_nome_func, v_sal_func;
        CLOSE func_prod;

        FOR v_indice IN 1.. v_codigo_func.count LOOP
            DBMS_OUTPUT.PUT_LINE(v_codigo_func(v_indice) || '-' || v_nome_func(v_indice) || 'Salário' || v_sal_func(v_indice));
        END LOOP;
    END;
/

CREATE OR REPLACE PROCEDURE pr_exemplo_atualiza IS
    CURSOR func_prod IS
    SELECT empno, ename, sal
    FROM emp 
    ORDER BY ename;

    TYPE empno_func IS TABLE OF emp.empno%TYPE
    INDEX BY BINARY INTEGER;

    TYPE ename_func IS TABLE OF emp.ename%TYPE
    INDEX BY BINARY INTEGER;

    TYPE sal_func IS TABLE OF emp.sal%TYPE
    INDEX BY BINARY INTEGER;

    v_codigo_func empno_func;
    v_nome_func ename_func;
    v_sal_func sal_func;
    v_indice BINARY INTEGER;

    BEGIN
        OPEN func_prod;
        FETCH func_prod BULK COLLECT INTO v_codigo_func, v_nome_func, v_sal_func;
        CLOSE func_prod;

        FORALL v_indice IN 1.. v_codigo_func.count
        UPDATE emp
        SET sal = ((v_sal_func(v_indice) * 10 / 100) + v_sal_func(v_indice))
        WHERE empno = v_codigo_func(v_indice);
        DBMS_OUTPUT.PUT_LINE('ATUALIZANDO REGISTROS...')
    END;
/

EXECUTE pr_exemplo_mostra;
EXECUTE pr_exemplo_atualiza;
EXECUTE pr_exemplo_mostra;
*/



-- Exemplo de CURSOR com parâmetros
/*
CREATE TABLE dept10 AS (SELECT empno, ename, deptno, job from emp);
TRUNCATE table dept10;

ACCEPT p_cargo PROMPT 'Digite o cargo do funcionário';
ACCEPT p_deptno PROMPT 'Digite o departamento do funcionário';

DECLARE
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_deptno emp.deptno%TYPE;
    v_job emp.job%TYPE;

    CURSOR emp_cursor (p_deptno NUMBER, p_job VARCHAR2) IS
       SELECT empno, ename, deptno, job   
       FROM emp
       WHERE deptno = p_deptno AND job = p_job;
BEGIN
    IF NOT emp_cursor%isopen THEN
        OPEN emp_cursor(&p_deptno, upper('&p_job'));
    END IF;
    LOOP
        FETCH emp_cursor INTO v_empno, v_ename, v_deptno, v_job;
        EXIT WHEN emp_cursor%NOTFOUND;
        INSERT INTO dept10(empno, ename, deptno, job) 
        VALUES(v_empno, v_ename, v_deptno, v_job);
    END LOOP;
    CLOSE emp_cursor;
END;

SELECT * FROM dept10;
*/



-- Exemplo com FOR UPDATE e WHERE CURRENT OF;
/*
DECLARE
    CURSOR cursor_ex_atual IS
        SELECT ename, job, sal FROM emp
        FOR UPDATE of sal NOWAIT;
    reg_ex_atual cursor_ex_atual%rowtype;
BEGIN
    FOR reg_ex_atual IN cursor_ex_atual LOOP
        IF reg_ex_atual.job = 'CLERK' THEN
            UPDATE emp set sal = sal * 1.10
            WHERE CURRENT OF cursor_ex_atual;
        ELSIF reg_ex_atual.job = 'PRESIDENT' THEN
            UPDATE emp set sal = sal * sal
            WHERE CURRENT OF cursor_ex_atual;
        ELSIF reg_ex_atual.comm IS NULL THEN
            UPDATE emp set comm = sal * 0.10
            WHERE CURRENT OF cursor_ex_atual;
        ELSE
            DELETE from emp
            WHERE CURRENT OF cursor_ex_atual;
        END IF;
    END LOOP;
END;
/

SELECT job, sal, comm from emp;
ROLLBACK;
*/



--Exemplo de CURSOR com PACKAGE
CREATE OR REPLACE PACKAGE pkg_cursor
    PROCEDURE pr_exemplo_cursor;
end pkg_cursor;
/

CREATE OR REPLACE PACKAGE BODY pkg_cursor
    PROCEDURE pr_exemplo_cursor IS
        CURSOR my_cursor IS
            SELECT t1.deptno, t1.dname, t2.staff
            FROM dept t1 JOIN (SELECT deptno, count(*) staff FROM emp GROUP BY deptno) t2 
            ON t1.deptno = t2.deptno;
            reg_my_cursor my_cursor%rowtype;
        BEGIN
            FOR reg_my_cursor IN my_cursor LOOP
                DBMS_OUTPUT.PUT_LINE('O departamento ' || reg_my_cursor.dname || ' tem ' || reg_my_cursor.staff || ' funcionários.');
            END LOOP;
        END;
END pkg_cursor;
/
