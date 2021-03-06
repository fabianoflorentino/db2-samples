--# Copyright IBM Corp. All Rights Reserved.
--# SPDX-License-Identifier: Apache-2.0

/*
 * Lists user CREATEd and DECLAREd global temporary tables
 */

CREATE OR REPLACE VIEW DB_TEMP_TABLES AS
SELECT 
    TABSCHEMA
,   TABNAME
,   INSTANTIATOR        AS OWNER
,   TEMPTABTYPE         AS TYPE
,   INSTANTIATION_TIME
,   COLCOUNT
,   PARTITION_MODE
,   ONCOMMIT
,   ONROLLBACK
,   LOGGED
,   TAB_ORGANIZATION    AS TABLEORG
FROM
    TABLE(ADMIN_GET_TEMP_TABLES(null,null,null))
UNION ALL
SELECT 
    TABSCHEMA
,   TABNAME
,   OWNER
,   'CGTT'              AS TYPE
,   NULL                AS INSTANTIATION_TIME
,   COLCOUNT
,   PARTITION_MODE
,   ONCOMMIT
,   ONROLLBACK
,   LOGGED
,   TABLEORG
FROM
    SYSCAT.TABLES
WHERE
    TYPE = 'G'
