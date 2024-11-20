/*
CREATE TABLE teste_loop(id NUMBER(10), nome VARCHAR2(10));

DECLARE
  v_counter NUMBER(10) := 1;
  v_nome VARCHAR2(10) := 'Teste Loop';
BEGIN
  LOOP
    INSERT INTO teste_loop(id, nome)
    VALUES (v_counter, v_nome);
    v_counter := v_counter + 1;
    EXIT WHEN v_counter > 5;
  END LOOP;
END;
/
*/

/*
CREATE TABLE item(ordId NUMBER(5), itemId NUMBER);

DECLARE
  v_ordId NUMBER := 601;
BEGIN
  FOR i IN 1..10 LOOP
    INSERT INTO item(ordId, itemId)
    VALUES(v_ordId, i);
  END LOOP;
END;
/ 
*/

ACCEPT p_voltas PROMPT 'Digite o número de voltas no laço: ';

DECLARE
  v_count NUMBER(10) := 1;
BEGIN
  WHILE v_count <= &p_voltas LOOP
    DBMS_OUTPUT.PUT_LINE('valor do contador: ' || v_count);
    v_count := v_count + 1;
  END LOOP;
END;
/
