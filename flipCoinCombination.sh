
#!/bin/bash -x

random=$(( RANDOM%2 ))


if [ $random -eq 0 ]
then
        coin=heads
else
        coin=tails
fi

echo "The coin is flipped and it is "$coin

