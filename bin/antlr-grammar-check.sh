#!/bin/bash -e

## antlr jar downloaded from
## http://www.antlr.org/download/antlr-4.6-complete.jar

CLASSPATH=${CLASSPATH}:/usr/local/lib/antlr-4.6-complete.jar
ANTLR4='java -jar /usr/local/lib/antlr-4.6-complete.jar'
GRUN="java -cp $CLASSPATH org.antlr.v4.gui.TestRig"

if [ -z $1 ]; then
    echo "Usage: $0 grammar rule [input-file]"
    exit 1
fi

if [ -z $2 ]; then
    echo "Usage: $0 grammar rule [input-file]"
    exit 2
fi

${ANTLR4} "${1}.g4"
find . -type f -name '*.java' -exec javac -cp /usr/local/lib/antlr-4.6-complete.jar -Xlint:all {} \+

GRAMMAR=$1
START_RULE=$2
shift; shift

${GRUN} $GRAMMAR $START_RULE $@

## antlr-grammar-check.sh ends here
