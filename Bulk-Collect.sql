Declare
    Type vr_Data Is Record ( FnOid   varchar2(100) );
    Type tt_Data Is Table Of vr_Data Index By binary_integer;
    vt_Data               tt_Data ;
    vc_Data  Sys_RefCursor;
Begin
   Open vc_Data
   For
      SELECT rowid
        FROM table1
       WHERE 1=1;
   Loop
      Fetch vc_Data Bulk Collect Into vt_Data Limit 10000 ;
      ForAll vs_PosVet In vt_Data.FIRST..vt_Data.LAST
         
         UPDATE table2
            SET field1 = x
          WHERE rowid = vt_Data(vs_PosVet).FnOid ;
         COMMIT;
         
         vt_Data.delete;
         
         Exit When vc_Data%NotFound;
   End Loop;
   Close vc_Data;
End;
