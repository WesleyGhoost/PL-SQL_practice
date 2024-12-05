--Exemplos com EXCEPTION--

-- Exemplo com tratamento NO_DATA_FOUND E TOO_MANY_ROWS;
/*
ACCEPT p_nome PROMPT 'Digite o nome de um funcionário';
DECLARE
   v_nome emp.ename%TYPE := &p_nome;
   v_ename emp.ename%TYPE;
   v_sal emp.sal%TYPE;
BEGIN
   SELECT ename, sal        
   INTO v_ename, v_sal  
   FROM emp
   WHERE job = 'CLERK' AND ename = v_nome;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado');
    WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('Muitos funcionários possuem esse cargo');
    WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Erro desconhecido');
END;
/
*/



-- Exemplo com o tratamento ZERO_DIVIDE;
DECLARE
   x NUMBER := 0;
   y NUMBER := 5;
   resultado NUMBER;
BEGIN
   resultado := y / x;
EXCEPTION
   WHEN ZERO_DIVIDE THEN
       DBMS_OUTPUT.PUT_LINE('Não é possível dividir por zero!');
END;
/
