--Exemplos com TYPE--

-- * A tabela filmes utilizada foi criada no arquivo DMLPractice.pls *
/*
CREATE OR REPLACE PACKAGE pkg_filmes AS
  TYPE tipo_reg_filmes IS RECORD (
    filme_id filmes.filme_id%TYPE,
    titulo filmes_titulo%TYPE,
    diretor filmes_diretor%TYPE,
    ano filmes_ano%TYPE,
    pais filmes_pais%TYPE,
    duracao filmes_duracao%TYPE
  );
  CAMPO_NULO EXCEPTION;
  PRAGMA EXCEPTION_INIT(CAMPO_NULO, -2290);
  PROCEDURE inclui_filme (
    registro IN pkg_filmes.tipo_reg_filmes,
    cod_erro OUT NUMBER,
    msg_erro OUT VARCHAR2
  );
END pkg_filmes;
/

CREATE OR REPLACE PACKAGE BODY pkg_filmes AS
  PROCEDURE inclui_filme (
    registro IN pkg_filmes.tipo_reg_filmes,
    cod_erro OUT NUMBER,
    msg_erro OUT VARCHAR2
  );
  IS
  BEGIN
    BEGIN
        cod_erro := 0;
        INSERT INTO filmes VALUES registro;
        EXCEPTION
            WHEN DUPLICATE THEN
                cod_erro := SQLCODE;
                msg_erro := 'id_filme ou titulo repetido';
            WHEN CAMPO_NULO THEN
                cod_erro := SQLCODE;
                msg_erro := 'diretor ou titulo nulo';
            WHEN OTHERS THEN
                cod_erro := SQLCODE;
                msg_erro := SQLERRM;
    END;
  END;
END pkg_filmes;
/

DECLARE
  registro pkg_filmes.tipo_reg_filmes;
  cod_erro NUMBER;
  msg_erro VARCHAR2(100);
BEGIN
  registro.filme_id := 4;
  registro.titulo := 'Jogador Nº1';
  registro.diretor := 'Steven Spielberg'
  registro.ano := 2018;
  registro.pais := 'EUA';
  registro.duracao := 140;
  pkg_filmes.inclui_filme(registro, cod_erro, msg_erro);
  IF cod_erro = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Inclusão bem sucedida');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Erro na inclusão: ' || TO_CHAR(cod_erro, '00000') || (msg_erro));
  END IF;
END;
/
*/



CREATE TABLE novo_dept AS (SELECT * FROM dept WHERE deptno = 0);

DECLARE
  TYPE tp_tab_dept
  IS TABLE of dept%rowtype
  INDEX BY BINARY_INTEGER;

  dept_tab1 tp_tab_dept;
  C BINARY_INTEGER;
  recdept dept%rowtype;
BEGIN
  C := 0;
  FOR recdept in (SELECT * FROM dept) LOOP
    dept_tab1(C).deptno = recdept.deptno;
    dept_tab1(C).dname = recdept.dname;
    dept_tab1(C).loc = recdept.loc;
    C = C + 1;
    DBMS_OUTPUT.PUT_LINE('Registro: ' || C || ' Codigo do Depto: ' || recdept.deptno || ' Nome do Depto: ' || recdept.dname || ' Local do Depto: ' || recdept.loc);
  END LOOP;

  FOR recdept in (SELECT * FROM dept) LOOP
    dept_tab1(C).deptno = recdept.deptno;
    dept_tab1(C).dname = recdept.dname;
    dept_tab1(C).loc = recdept.loc;
    IF dept_tab1(C).loc = 'New York' THEN
       INSERT INTO novo_dept (deptno, dname, loc)
       VALUES (C+1, recdept.dname, recdept.loc);
    END IF;
  END LOOP;
  COMMIT;
END;
/

SELECT * FROM novo_dept;

