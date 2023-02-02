#!/bin/bash
set -e

cmd=$*

if [[ "$cmd" == *--defaultsFile* ]] || [[ "$cmd" == *--defaults-file* ]]; then
    props=("$cmd")
    for prop in $props
    do
        if [[ "$prop" == *--defaultsFile* ]]; then

            file=$(echo $prop | sed 's/--defaultsFile=\(.*\).*/\1/g')
            fileEvaluated=/liquibase/$(basename $file).eval
            (eval "echo \"$(cat $file)\"") > $fileEvaluated

            cmd=$(echo $* | sed "s|${file}|${fileEvaluated}|g")

            #echo "NEW cmd: $cmd"
            #cat ${fileEvaluated}
        fi
        if [[ "$prop" == *--defaults-file* ]]; then

            file=$(echo $prop | sed 's/--defaults-file=\(.*\).*/\1/g')
            fileEvaluated=/liquibase/$(basename $file).eval
            (eval "echo \"$(cat $file)\"") > $fileEvaluated

            cmd=$(echo $* | sed "s|${file}|${fileEvaluated}|g")

            #echo "NEW cmd: $cmd"
            #cat ${fileEvaluated}
        fi
    done
fi


if [[ "$INSTALL_MYSQL" ]]; then
  lpm add mysql --global
fi

if type "$1" > /dev/null 2>&1; then
  ## First argument is an actual OS command. Run it
  exec "$@"
else
  if [[ "$cmd" == *--defaultsFile* ]] || [[ "$cmd" == *--defaults-file* ]] || [[ "$cmd" == *--version* ]]; then
    ## Just run as-is
    liquibase $cmd
  else
    ## Include standard defaultsFile
    liquibase "--defaultsFile=/liquibase/liquibase.docker.properties" "$@"
  fi
fi
