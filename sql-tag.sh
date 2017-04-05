#!/bin/bash


. ./sql-base.sh

SQL_MODULE=/SPENConnection/sqlScripts/oracle/updates/CR_RELEASE_7/PostQuoteCustomerMoodTag
REVISION=15368



DATE="04/03/2017"
declare -a TAG_NAMES=(PostQuoteContactMood ContactMood_fully_satisfied ContactMood_happy_with_issues Dissatisfaction_req_feedback Not_required Attempted Refused_CS_Survey)
declare -a DISPLAY_NAMES=('Post Quote Contact Mood' 'Successful – Fully satisfied' 'Successful – Happy but some issues' 'Successful – Dissatisfaction requiring feedback' 'Not required' 'Attempted' 'Refused any CS Survey')


SQL=$(generate_tag_sql $TAG_NAMES $DISPLAY_NAMES)

create_sql_module $SQL_MODULE $REVISION "$SQL"

