
#!/bin/bash -x

percentage(){
echo `awk -vH=$1 -vT=$2 'BEGIN{print( (H/( H + T ))*100 )}'`
}

declare -A dices
dices=( ["H"]=0 ["T"]=0 ["HH"]=0 ["TT"]=0 ["TH"]=0 ["TH"]=0 )
echo "Welcome to usecase 3"
ishead=0
counter=0
isHH=0
isHT=1
isTH=2
isTT=3

while [ $counter -lt 10 ]
do
        roll=$(( RANDOM%2 ))
	double_roll=$(( RANDOM%4 ))


        if [ $roll -eq $ishead ]
        then
		((dices["H"]++))
                coin="Heads"
        else
		((dices["T"]++))
                coin="Tails"
        fi

        echo "The coin is flipped and it is "$coin


	if [ $double_roll -eq $isHH ]
        then
		((dices["HH"]++))
                coin="Heads Heads"

        elif [ $double_roll -eq $isHT ]
	then
		((dices["HT"]++))
                coin="Heads Tails"

        elif [ $double_roll -eq $isTH ]
	then
		((dices["TH"]++))
                coin="Tails Heads"

        elif [ $double_roll -eq $isTT ]
	then
		((dices["TT"]++))
                coin="Tails Tails"
        fi

        echo "The coin is flipped two times and it is "$coin

        (( counter++ ))

done


head_per=$( percentage ${dices[H]} ${dices[T]} )
tail_per=$( percentage ${dices[T]} ${dices[H]} )
echo ${dices[@]} ${!dices[@]}

echo "${dices[HT]}${dices[TT]}${dices[TH]}${dices[HH]}"


HH_per=$( percentage ${dices[HH]} $(( ${dices[TH]}+${dices[TT]}+${dices[HT]} )) )
HT_per=$( percentage ${dices[HT]} $(( ${dices[TH]}+${dices[TT]}+${dices[HH]} )) )
TH_per=$( percentage ${dices[TH]} $(( ${dices[HH]}+${dices[TT]}+${dices[HT]} )) )
TT_per=$( percentage ${dices[TT]} $(( ${dices[TH]}+${dices[HH]}+${dices[HT]} )) )

echo
echo
echo "Percentage of singlets"
echo "The percentage of head falled is" $head_per
echo "The percentage of tails falled is" $tail_per

echo
echo
echo "Percentage of doublets"
echo "Head-H  Tail-T"
echo "The percentage of HH falled is" $HH_per
echo "The percentage of TT falled is" $TT_per
echo "The percentage of HT falled is" $HT_per
echo "The percentage of TH falled is" $TH_per
