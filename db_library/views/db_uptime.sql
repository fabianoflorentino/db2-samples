--# Copyright IBM Corp. All Rights Reserved.
--# SPDX-License-Identifier: Apache-2.0

/*
 * Shows last time the database members were last restarted
 */

CREATE OR REPLACE VIEW DB_UPTIME AS
SELECT 
    DB2_STATUS
,   DB2START_TIME
,   TIMEZONEID
,   LISTAGG(MEMBER,',') WITHIN GROUP (ORDER BY MEMBER) AS MEMBERS
,          DAYS_BETWEEN(CURRENT_TIMESTAMP, DB2START_TIME)       AS DAYS
,   MOD(  HOURS_BETWEEN(CURRENT_TIMESTAMP, DB2START_TIME),24)   AS HOURS
,   MOD(MINUTES_BETWEEN(CURRENT_TIMESTAMP, DB2START_TIME),60) AS MINUTES
,   MOD(SECONDS_BETWEEN(CURRENT_TIMESTAMP, DB2START_TIME),60) AS SECONDS
FROM
    TABLE(MON_GET_INSTANCE(-2))
GROUP BY
    DB2_STATUS
,   DB2START_TIME
,   TIMEZONEID