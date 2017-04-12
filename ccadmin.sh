#!/bin/sh

## resolve links - $0 may be a link to ant's home
PRG="$0"

# need this for relative symlinks
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done

CORE_HOME=`dirname "$PRG"`/..

# make it fully qualified
CORE_HOME=`cd "$CORE_HOME" > /dev/null && pwd`
ANT_HOME=$CORE_HOME/lib/ant
CCADMIN_HOSTNAME=`hostname | cut -f1 -d'.'`

[ -r $CORE_HOME/config/project.environment ] && . $CORE_HOME/config/project.environment
[ -r $HOME/.kana/ccadmin.environment ] && . $HOME/.kana/ccadmin.environment

if [ -z "$JAVA_HOME" ]; then
    echo "Please setup the environment variable JAVA_HOME to point to a valid Java installation"
    exit 1
fi

MEMORY="-Xmx512m -XX:MaxMetaspaceSize=384m"
if [ `uname -m` = 'x86_64' ]; then
  MEMORY="-Xmx768m -XX:MaxMetaspaceSize=1024m"
fi
ANT_OPTS="$MEMORY -Dfile.encoding=UTF-8 -Dsvnkit.http.keepCredentials=false $ANT_OPTS"
export ANT_OPTS
export JAVA_HOME

if [ "$1" = "help" ]; then
    TARGET="help"
    shift
else
    TARGET="run"
fi

COMMAND="$1"
COMMAND_FILE="$CORE_HOME/scripts/run-command.xml"

if [ "$#" -ge "1" ]; then
    shift
fi

if [ -e "$CORE_HOME"/lib/ccadmin_antlib/AntLogger.jar ]
then
    mv -f "$CORE_HOME"/lib/ccadmin_antlib/AntLogger.jar "$CORE_HOME"/lib/antlib
fi

if [ -e "$CORE_HOME/lib/antlib/AntLogger.jar" ]
then
    CUSTOM_LOGGER="-logger com.gtnet.ant.logger.ParallelLogger"
fi

$ANT_HOME/bin/ant -lib $CORE_HOME/lib/antlib $CUSTOM_LOGGER -f $COMMAND_FILE -Drun.command=$COMMAND -Drun.target=$TARGET -Ddefault.core.home=$CORE_HOME -Dccadmin.hostname=$CCADMIN_HOSTNAME $CCADMIN_OPTS "$@"
