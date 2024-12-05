--exemplo com DML--

CREATE TABLE filmes (
    filme_id NUMBER(10) PRIMARY KEY,
    titulo VARCHAR2(100),
    diretor VARCHAR2(50),
    ano NUMBER (10),
    pais VARCHAR2(50),
    duracao NUMBER(10)
)

CREATE OR REPLACE PACKAGE pkg_filmes AS
  FILME_REPETIDO EXCEPTION;
  CAMPO_NULO EXCEPTION;
  PRAGMA EXCEPTION_INIT(FILME_REPETIDO, -1);
  PRAGMA EXCEPTION_INIT(CAMPO_NULO, -2290);
END pkg_filmes;
/

CREATE OR REPLACE FUNCTION inclui_filme (
    filme_id NUMBER,
    titulo VARCHAR2,
    diretor VARCHAR2,
    ano NUMBER,
    pais VARCHAR2,
    duracao NUMBER
)
RETURN NUMBER
IS
  ret NUMBER := 0;
  BEGIN
    BEGIN
        INSERT INTO filmes VALUES (filme_id, titulo, diretor, ano, pais, duracao);
        EXCEPTION
            WHEN pkg_filmes.FILME_REPETIDO THEN
                ret := -1;
            WHEN pkg_filmes.CAMPO_NULO THEN
                ret := -2290;
            WHEN OTHERS THEN
                ret := SQLCODE;
    END;
        RETURN ret;
END;
/

DECLARE
  ret NUMBER;
BEGIN
  ret := inclui_filme(1, 'Vingadores: Ultimato', 'Irmãos Russo', 2019, 'EUA', 260)
  IF ret = 0 THEN
  DBMS_OUTPUT.PUT_LINE('Inclusão bem sucedida')
  ELSE
  DBMS_OUTPUT.PUT_LINE('Erro na inclusão: Filme repetido')
  END IF;
END;
/