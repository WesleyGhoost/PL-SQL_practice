--Exemplos com TRIGGER--

-- Exemplo com BEFORE
/*
CREATE OR REPLACE TRIGGER restringe_salario
    BEFORE INSERT OR UPDATE OF sal ON emp
    FOR EACH ROW
    BEGIN
        IF NOT (:new.job in('President', 'Sales')) AND :new.sal > 15000 THEN
            RAISE_APPLICATION_ERROR(-20202, 'O funcionário não pode receber um aumento');
        END IF;
    END;
    /

INSERT INTO emp(empno, ename, job, sal, deptno) VALUES (135, 'Erik', 'Clerk', 20000, 12);
INSERT INTO emp(empno, ename, job, sal, deptno) VALUES (135, 'Erik', 'Sales', 14000, 10);

UPDATE emp
SET sal = 20000
WHERE deptno = 12;
*/


/*
CREATE OR REPLACE seguro_emp
   BEFORE INSERT ON scott.emp
   BEGIN 
        IF (TO_CHAR(SYSDATE, 'DY') IN ('SAB', 'DOM')) OR (TO_CHAR(SYSDATE, 'HH24:MI') BETWEEN '08:00' AND '17:00') THEN
            RAISE_APPLICATION_ERROR(-20500, 'Inserções de funcionário somente fora do horário comercial');
        END IF;
    END;
    /

SELECT TO_CHAR(SYSDATE, 'dd/mm/yyyy-hh24:mi:ss') FROM DUAL;
*/



-- Exemplo com AFTER
/*
CREATE TABLE log_event (
    evento VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER log_logon
    AFTER LOGON ON DATABASE
    WHEN (USER = 'SYSTEM' OR USER = 'SCOTT')
    BEGIN
        INSERT INTO log_event 
        VALUES ('O usuário ' || USER || ' efetuou login no banco de dados em: ' || TO_CHAR(SYSDATE, 'yyyy/mm/dd hh24:mi:ss'));
    END;
    /
*/


/*
CREATE TABLE aud_emp (
    username VARCHAR2(100),
    data DATE,
    antigo_nome VARCHAR2(100),
    novo_nome VARCHAR2(100),
    antigo_salario NUMBER(7, 2),
    novo_salario NUMBER(7, 2)
);

CREATE OR REPLACE TRIGGER auditar_emp
    AFTER DELETE OR UPDATE OR INSERT ON scott.emp
    FOR EACH ROW
    BEGIN 
        INSERT INTO aud_emp (username, data, antigo_nome, novo_nome, antigo_salario, novo_salario)
        VALUES (USER, SYSDATE, :old.ename, :new.ename, :old.sal, :new.sal);
    END;
    /

INSERT INTO scott.emp(empno, ename, sal, deptno)
VALUES (7900, 'Eduarda', 1300, 10);

select username, TO_CHAR(data, 'dd/mm/yyyy-hh:mi:ss'), antigo_nome, novo_nome, antigo_salario, novo_salario from aud_emp;

UPDATE scott.emp
SET sal = 1500
WHERE ename = 'Eduarda';

select username, TO_CHAR(data, 'dd/mm/yyyy-hh:mi:ss'), antigo_nome, novo_nome, antigo_salario, novo_salario from aud_emp;
*/



-- Exemplo com RENAME e SCHEMA
CREATE TABLE empregado as (SELECT * from scott.emp);

CREATE OR REPLACE TRIGGER vigia
    AFTER RENAME ON SCHEMA
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Algo trocou de nome')
    END;
    /

RENAME empregado TO funcionario;
