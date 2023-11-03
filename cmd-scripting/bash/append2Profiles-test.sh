#!/bin/bash
for dir in /export/home/*/
do
        dir=${dir}

        echo "${dir}" | grep testharness > /dev/null
        if [ $? -eq 1 ]; then
                name=${dir%*/}

                echo "\n"
                echo "\t""EXPORTS FOR ""${name##*/}"" :"
                ##echo "${dir}"
                cat "${dir}.profile" | grep "export PATH"

                # echo "\t""PATHS FOR ""${name##*/}"" :"
                # echo "\tJAVA_HOME : "
                # su - "${name##*/}" -c "echo '$JAVA_HOME'"
                # echo "\tM2 : "
                # su - "${name##*/}" -c "echo '$M2'"
                
                echo "\t""EXEC FOR ""${name##*/}"" :"
                echo "\tDETECT JAVA : "
                su - "${name##*/}" -c "java -version"
                echo "\tDETECT MVN : "
                su - "${name##*/}" -c "mvn -version"
                echo "\n"
        fi
##      ls -la "${dir}" | grep profile
done
