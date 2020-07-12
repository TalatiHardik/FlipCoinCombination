
#!/bin/bash -x

percantage(){
echo `awk -vH=$1 -vT=$2 'BEGIN{print( (H/( H + T ))*100 )}'`
}

declare -A dices
dices=( ["H"]=0 ["T"]=0 )
echo "Welcome to usecase 2"
ishead=0
counter=0
while [ $counter -lt 10 ]
do
        roll=$(( RANDOM%2 ))


        if [ $roll -eq $ishead ]
        then
		((dices["H"]++))
                coin="Heads"
        else
		((dices["T"]++))
                coin="Tails"
        fi

        echo "The coin is flipped and it is "$coin

        (( counter++ ))

done

head_per=$( percantage ${dices[H]} ${dices[T]} )
tail_per=$( percantage ${dices[T]} ${dices[H]} )

echo "The percentage of head falled is" $head_per
echo "The percentage of tails falled is" $tail_per
