CREATE OR REPLACE FUNCTION Verifica_CPF(cpf IN CHAR)
  RETURN CHAR
  IS digito1  INTEGER := 0;
     digito2  INTEGER := 0;
     primeiro INTEGER := 0;
     conta    INTEGER := 0;
  BEGIN
    IF (cpf IS NOT NULL AND REGEXP_REPLACE(cpf,'[^0-9]') IS NULL) OR (LENGTH(cpf) > 11 OR LENGTH(REGEXP_REPLACE(cpf,'[^0-9]')) <> 11) THEN
      RETURN 'F';
    ELSE
      FOR z IN 1 .. 11 LOOP
        IF z = 1 THEN
          primeiro := SUBSTR(cpf, z, 1);
        ELSE
          IF SUBSTR(cpf, z, 1) = primeiro THEN
            conta := conta + 1;
          END IF;
        END IF;
      END LOOP;
        
      IF conta = 10 THEN
        RETURN 'F';
      END IF;
      
      FOR x IN 1 .. 9 LOOP
        digito1 := digito1 + (SUBSTR(cpf, x, 1) * (11 - x));
      END LOOP;
      
      digito1 := MOD(digito1,11);
        
      IF digito1 < 2 THEN
        digito1 := 0;
      ELSE
        digito1 := 11 - digito1;
      END IF;
        
      FOR y IN 1 .. 10 LOOP
        digito2 := digito2 + (SUBSTR(cpf, y, 1) *(12 - y));
      END LOOP;
        
      digito2 := MOD(digito2,11);
        
      IF digito2 < 2 THEN
        digito2 := 0;
      ELSE
        digito2 := 11 - digito2;
      END IF;
      
      IF (digito1 = SUBSTR(cpf,10,1)) AND (digito2 = SUBSTR(cpf,11,1)) THEN
        RETURN 'V';
      END IF;
        
      RETURN 'F';
    END IF;
    
    RETURN 'F';
  END;