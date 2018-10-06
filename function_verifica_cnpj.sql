CREATE OR REPLACE FUNCTION Verifica_CNPJ(cnpj IN CHAR)
  RETURN CHAR
  IS digito1  INTEGER := 0;
     digito2  INTEGER := 0;
     primeiro INTEGER := 0;
     conta    INTEGER := 0;
  BEGIN
    IF (cnpj IS NOT NULL AND REGEXP_REPLACE(cnpj,'[^0-9]') IS NULL) OR (LENGTH(cnpj) > 14 OR LENGTH(REGEXP_REPLACE(cnpj,'[^0-9]')) <> 14) THEN
      RETURN 'F';
    ELSE
      FOR y IN 1 .. 14 LOOP
        IF y = 1 THEN
          primeiro := SUBSTR(cnpj, y, 1);
        ELSE
          IF SUBSTR(cnpj, y, 1) = primeiro THEN
            conta := conta + 1;
          END IF;
        END IF;
      END LOOP;
      
      IF conta = 13 THEN
        RETURN 'F';
      END IF;
    
      FOR z IN 1 .. 12 LOOP
        IF z = 1 OR z = 9 THEN
          digito1 := digito1 + (5 * SUBSTR(cnpj, z, 1));
        END IF;
        IF z = 2 OR z = 10 THEN 
          digito1 := digito1 + (4 * SUBSTR(cnpj, z, 1));
        END IF;
        IF z = 3 OR z = 11 THEN 
          digito1 := digito1 + (3 * SUBSTR(cnpj, z, 1));
        END IF;
        IF z = 4 OR z = 12 THEN 
          digito1 := digito1 + (2 * SUBSTR(cnpj, z, 1));
        END IF;
        IF z = 5 THEN 
          digito1 := digito1 + (9 * SUBSTR(cnpj, z, 1));
        END IF;
        IF z = 6 THEN 
          digito1 := digito1 + (8 * SUBSTR(cnpj, z, 1));
        END IF;
        IF z = 7 THEN 
          digito1 := digito1 + (7 * SUBSTR(cnpj, z, 1));
        END IF;
        IF z = 8 THEN 
          digito1 := digito1 + (6 * SUBSTR(cnpj, z, 1));
        END IF;
      END LOOP;
      
      digito1 := MOD(digito1,11);
      
      IF digito1 < 2 THEN
        digito1 := 0;
      ELSE
        digito1 := 11 - digito1;
      END IF;
      
      FOR x IN 1 .. 13 LOOP
        IF x = 1 OR x = 9 THEN
          digito2 := digito2 + (6 * SUBSTR(cnpj, x, 1));
        END IF;
        IF x = 2 OR x = 10 THEN 
          digito2 := digito2 + (5 * SUBSTR(cnpj, x, 1));
        END IF;
        IF x = 3 OR x = 11 THEN 
          digito2 := digito2 + (4 * SUBSTR(cnpj, x, 1));
        END IF;
        IF x = 4 OR x = 12 THEN 
          digito2 := digito2 + (3 * SUBSTR(cnpj, x, 1));
        END IF;
        IF x = 5 OR x = 13 THEN 
          digito2 := digito2 + (2 * SUBSTR(cnpj, x, 1));
        END IF;
        IF x = 6 THEN 
          digito2 := digito2 + (9 * SUBSTR(cnpj, x, 1));
        END IF;
        IF x = 7 THEN 
          digito2 := digito2 + (8 * SUBSTR(cnpj, x, 1));
        END IF;
        IF x = 8 THEN 
          digito2 := digito2 + (7 * SUBSTR(cnpj, x, 1));
        END IF;
      END LOOP;
      
      digito2 := MOD(digito2,11);
      
      IF digito2 < 2 THEN
        digito2 := 0;
      ELSE
        digito2 := 11 - digito2;
      END IF;
      
      IF (digito1 = SUBSTR(cnpj,13,1)) AND (digito2 = SUBSTR(cnpj,14,1)) THEN
        RETURN 'V';
      END IF;
      
      RETURN 'F';
    END IF;
    
    RETURN 'F';
  END;