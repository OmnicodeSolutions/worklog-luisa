#!/usr/bin/env zsh

today=${1:-$(date +%F)}
debug=$2

# TODO: validate if $today is a valid date in YYYY-MM-DD

new_file=content/blog/${today}.md
cp daily-template.md ${new_file}.temp

## Title
title="${today}"

# replace title
if [ -z $debug ]
then
   cat ${new_file}.temp | sed -e "s#TITLE#${title}#" > $new_file
    mv $new_file ${new_file}.temp
else   
  echo "TITLE = ${title}"
fi

# replace date
if [ -z $debug ]
then
    cat ${new_file}.temp | sed -e "s#DATE#${today}#" > $new_file
    mv $new_file ${new_file}.temp
fi 

## Day of the year
YEAR=$(date +%Y -d "$today")
WEEKDAY=$(date +%A -d "$today")
TOTAL_DAYS=$(date +%j -d "${YEAR}-12-31")
DAY_NO=$(date +%j -d "$today")
WEEK_NO=$(date +%V -d "$today")

# Handle special week number case
WEEKDAY_NO=$(date +%u -d "${YEAR}-01-01")
if [ "$WEEKDAY_NO" = "4" ] || 
   [ "$WEEKDAY_NO" = "5" ] || 
   [ "$WEEKDAY_NO" = "6" ]

then
    PREV_YEAR=$((YEAR-1))
    TOTAL_WEEKS=$(date +%V -d "${PREV_YEAR}-12-28")
else
    TOTAL_WEEKS=$(date +%V -d "${YEAR}-12-28")
fi

PORCENT_DAYS=$(bc -l <<< "scale=2; ${DAY_NO}*100/${TOTAL_DAYS}")
PORCENT_WEEKS=$(bc -l <<< "scale=2; ${WEEK_NO}*100/${TOTAL_WEEKS}")
headlight="Today is ${WEEKDAY}, day ${DAY_NO} of ${TOTAL_DAYS} (${PORCENT_DAYS}%). We're in week ${WEEK_NO} of ${TOTAL_WEEKS} (${PORCENT_WEEKS}%)."

# replace headlight
if [ -z $debug ]
then 
    cat ${new_file}.temp | sed -e "s#SUMMARY#${headlight}#" > $new_file
    rm ${new_file}.temp

    echo "Now edit ${new_file}"
else 
    echo "SUMMARY = ${headlight}" 
fi