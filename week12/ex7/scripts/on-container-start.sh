#!bin/bash

echo "Hello! The container is started successfully!"
echo "Let's count to 5 and it will stop."

COUNT_MAX=5
counter=0

while sleep 1
do 
    if [[ $counter == $COUNT_MAX ]]
    then
        break
    fi


    echo $(($counter + 1))
    ((counter++))
done

echo "Bye, bye!"

