
#!/bin/bash -x

percentage(){
echo `awk -vH=$1 -vT=$2 'BEGIN{print( (H/( H + T ))*100 )}'`
}

declare -A dices
dices=( ["H"]=0 ["T"]=0 ["HH"]=0 ["TT"]=0 ["TH"]=0 ["TH"]=0 ["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["HTT"]=0 ["THH"]=0 ["THT"]=0 ["TTH"]=0 ["TTT"]=0 )

declare -A singlets doublets triplets
singlets=( ["H"]=0 ["T"]=0 )
doublets=( ["HH"]=0 ["TT"]=0 ["TH"]=0 ["TH"]=0 )
triplets=( ["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["HTT"]=0 ["THH"]=0 ["THT"]=0 ["TTH"]=0 ["TTT"]=0 )
echo "Welcome to usecase 5"
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


singlets["H"]=$( percentage ${dices[H]} ${dices[T]} )
singlets["T"]=$( percentage ${dices[T]} ${dices[H]} )
#echo ${dices[@]} ${!dices[@]}

#echo "${dices[HT]}${dices[TT]}${dices[TH]}${dices[HH]}"


doublets[HH]=$( percentage ${dices[HH]} $(( ${dices[TH]}+${dices[TT]}+${dices[HT]} )) )
doublets[HT]=$( percentage ${dices[HT]} $(( ${dices[TH]}+${dices[TT]}+${dices[HH]} )) )
doublets[TH]=$( percentage ${dices[TH]} $(( ${dices[HH]}+${dices[TT]}+${dices[HT]} )) )
doublets[TT]=$( percentage ${dices[TT]} $(( ${dices[TH]}+${dices[HH]}+${dices[HT]} )) )


triplets[HHH]=$( percentage ${dices[HHH]} $(( ${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
triplets[HHT]=$( percentage ${dices[HHT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
triplets[HTH]=$( percentage ${dices[HTH]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
triplets[HTT]=$( percentage ${dices[HTT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )

triplets[THH]=$( percentage ${dices[THH]} $(( ${dices[HHH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]}+${dices[TTH]} )) )
triplets[THT]=$( percentage ${dices[THT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[TTH]} )) )
triplets[TTH]=$( percentage ${dices[TTH]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[TTT]}+${dices[THT]} )) )
triplets[TTT]=$( percentage ${dices[TTT]} $(( ${dices[HHH]}+${dices[THH]}+${dices[HTT]}+${dices[HHT]}+${dices[HTH]}+${dices[THT]}+${dices[TTH]} )) )



echo
echo
echo "Percentage of singlets"
echo "The percentage of head falled is" ${singlets["H"]}
echo "The percentage of tails falled is" ${singlets["T"]}

echo
echo
echo "Percentage of doublets"
echo "Head-H  Tail-T"
echo "The percentage of HH falled is" ${doublets[HH]}
echo "The percentage of TT falled is" ${doublets[TT]}
echo "The percentage of HT falled is" ${doublets[HT]}
echo "The percentage of TH falled is" ${doublets[TH]}



echo
echo
echo "Percentage of Triplets"
echo "Head-H  Tail-T"
echo "The percentage of HHH falled is" ${triplets[HHH]}
echo "The percentage of HTT falled is" ${triplets[HTT]}
echo "The percentage of HHT falled is" ${triplets[HHT]}
echo "The percentage of HTH falled is" ${triplets[HTH]}

echo "The percentage of THH falled is" ${triplets[THH]}
echo "The percentage of TTT falled is" ${triplets[TTT]}
echo "The percentage of THT falled is" ${triplets[THT]}
echo "The percentage of TTH falled is" ${triplets[TTH]}



keys=${!singlets[@]}
values=${singlets[@]}
#echo $values $keys

flag=0

for key in "${!singlets[@]}"
do
	if [ $flag -eq 0 ]
	then

		x="${singlets[$key]} $key\n"
		flag=1

	else
		x="$x""${singlets[$key]} $key\n"

	fi
	#echo $key
done
echo
echo "Sorting combinations for singlets"
echo -e $x | sort -r
printf "Winning combination for singlets is "
echo -e $x | sort -r | head -1


flag=0

for key in "${!doublets[@]}"
do
	if [ $flag -eq 0 ]
	then

		x="${doublets[$key]} $key\n"
		flag=1

	else
		x="$x""${doublets[$key]} $key\n"

	fi
	#echo $key
done
echo
echo "Sorting combinations for doublets"
echo -e $x | sort -r
printf "Winning combination for doublets is "
echo -e $x | sort -r | head -1


flag=0

for key in "${!triplets[@]}"
do
	if [ $flag -eq 0 ]
	then

		x="${triplets[$key]} $key\n"
		flag=1

	else
		x="$x""${triplets[$key]} $key\n"

	fi
	#echo $key
done
echo
echo "Sorting combinations for triplets"
echo -e $x | sort -r
printf "Winning combination for triplets is "
echo -e $x | sort -r | head -1

