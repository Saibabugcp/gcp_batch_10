CREATE TABLE CDE-B8.HISTORY_TEST_DEV.TEST_DEV( 
ID INT64 OPTIONS(DESCRIPTION = ' CUST_ID'),
NAME STRING OPTIONS(DESCRIPTION = 'CUST_NAME'),
DATE DATE ) 
OPTIONS ( DESCRIPTION = 'HISTORY TABLE FOT TEST PROJECT ') ;
------------------------------------------------------------------- -----
INSERT INTO history_test_dev.test_dev 
select 
cast( id as INT64 ) ,
name,
cast(date as date )  
from stage_test_dev.test_dev ;
--------------------------------------------------------------------------
create table audit_test_dev.stage_audit_test_dev( 
dataset_name string 
tablename string 
last_audit_tmstmp timestamp
total_records int64 ) as 
select 'stage_test_dev' asdataset_name,
'test_dev' as tablename,
current_timestamp() as last_audit_tmstmp,
select count(*) from stage_test_dev.test_dev ;
--------------------------------------------------------------------------
create view auth_views_test_dev.test_view_dev as select id,name,date from history_test_dev.test_dev ;


bq load --source_format=CSV --skip_leading_rows=1 cde-b8.stage_test_dev.test_dev
gs://buckname/filename 