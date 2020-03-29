DECLARE
 
       Type tr_MOVI Is Record (    FIELD_1  RowId
                                 , FIELD_2  TYPE_FIELD1_TABLE %TYPE
                                 , FIELD_3  TYPE_FIELD2_TABLE %TYPE                                 
                                  );
      
      TYPE VT_DATA IS TABLE OF tr_MOVI INDEX BY BINARY_INTEGER;
      VS_DATA VT_DATA;
      VC_CURSOR SYS_REFCURSOR;
      VS_CONT   PLS_INTEGER := 1; 
      
   BEGIN      

      OPEN VC_CURSOR
      FOR SELECT   field FIELD_1,
                   field,
                   field FIELD_3
              FROM table1, table2
             WHERE 1=1;   
      LOOP

          FETCH VC_CURSOR BULK COLLECT INTO VS_DATA LIMIT 100;
          EXIT WHEN VS_DATA.COUNT = 0;
          
          FORALL I IN VS_DATA.FIRST..VS_DATA.LAST
             UPDATE table_x
                SET field = VS_DATA(I).FIELD_3
              WHERE ROWID = VS_DATA(I).FIELD_1;
                
              COMMIT;
                
      END LOOP;

      CLOSE VC_CURSOR;        

END;


