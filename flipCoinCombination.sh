
#!/bin/bash -x

percentage(){
echo `awk -vH=$1 -vT=$2 'BEGIN{print( (H/( H + T ))*100 )}'`
}

declare -A dices
dices=( ["H"]=0 ["T"]=0 ["HH"]=0 ["TT"]=0 ["TH"]=0 ["TH"]=0 ["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["HTT"]=0 ["THH"]=0 ["THT"]=0 ["TTH"]=0 ["TTT"]=0 )
echo "Welcome to usecase 4"
ishead=0
counter=0
isHH=0
isHT=1
isTH=2
isTT=3
array1=( "HHH" "HHT" "HTH" "HTT" "THH" "THT" "TTH" "TTT" )

while [ $counter -lt 10 ]
do
        roll=$(( RANDOM%2 ))
	double_roll=$(( RANDOM%4 ))
	triple_roll=$(( RANDOM%8 ))


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

        case $triple_roll in
		0)
		((dices["HHH"]++))
                coin="Heads Heads Heads" ;;

		1)
		((dices["HHT"]++))
                coin="Heads Heads Tails" ;;

		2)
		((dices["HTH"]++))
                coin="Heads Tails Heads" ;;

		3)
		((dices["HTT"]++))
                coin="Heads Tails Tails" ;;

		4)
		((dices["THH"]++))
                coin="Tails Heads Heads" ;;

		5)
		((dices["THT"]++))
                coin="Tails Heads Tails" ;;

		6)
		((dices["TTH"]++))
                coin="Tails Tails Heads" ;;

		7)
		((dices["TTT"]++))
                coin="Tails Tails Tails" ;;

		*)
		echo "Error" ;;
	esac
        echo "The coin is flipped three times and it is "$coin

        (( counter++ ))

done


head_per=$( percentage ${dices[H]} ${dices[T]} )
tail_per=$( percentage ${dices[T]} ${dices[H]} )
#echo ${dices[@]} ${!dices[@]}

#echo "${dices[HT]}${dices[TT]}${dices[TH]}${dices[HH]}"


HH_per=$( percentage ${dices[HH]} $(( ${dices[TH]}+${dices[TT]}+${dices[HT]} )) )
HT_per=$( percentage ${dices[HT]} $(( ${dices[TH]}+${dices[TT]}+${dices[HH]} )) )
TH_per=$( percentage ${dices[TH]} $(( ${dices[HH]}+${dices[TT]}+${dices[HT]} )) )
TT_per=$( percentage ${dices[TT]} $(( ${dices[TH]}+${dices[HH]}+${dices[HT]} )) )


HHH_per=$( percentage ${dices[HHH]} $(( ${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
HHT_per=$( percentage ${dices[HHT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
HTH_per=$( percentage ${dices[HTH]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
HTT_per=$( percentage ${dices[HTT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )

THH_per=$( percentage ${dices[THH]} $(( ${dices[HHH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
THT_per=$( percentage ${dices[THT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[TTH]} )) )
TTH_per=$( percentage ${dices[TTH]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]} )) )
TTT_per=$( percentage ${dices[TTT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[THT]}+${dices[TTH]} )) )



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



echo
echo
echo "Percentage of Triplets"
echo "Head-H  Tail-T"
echo "The percentage of HHH falled is" $HHH_per
echo "The percentage of HTT falled is" $HTT_per
echo "The percentage of HHT falled is" $HHT_per
echo "The percentage of HTH falled is" $HTH_per

echo "The percentage of THH falled is" $THH_per
echo "The percentage of TTT falled is" $TTT_per
echo "The percentage of THT falled is" $THT_per
echo "The percentage of TTH falled is" $TTH_per



