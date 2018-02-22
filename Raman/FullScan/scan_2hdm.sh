#!/bin/bash


samples_2hdm=(ZpA0-600-300 ZpA0-600-400 ZpA0-800-300 ZpA0-800-400 ZpA0-800-500 ZpA0-800-600 ZpA0-1000-300 ZpA0-1000-400 ZpA0-1000-500 ZpA0-1000-600 ZpA0-1000-700 ZpA0-1000-800 ZpA0-1400-300 ZpA0-1400-400 ZpA0-1400-500 ZpA0-1400-600 ZpA0-1400-700 ZpA0-1400-800 ZpA0-1700-300 ZpA0-1700-400 ZpA0-1700-500 ZpA0-1700-600 ZpA0-1700-700 ZpA0-1700-800 ZpA0-2000-300 ZpA0-2000-400 ZpA0-2000-400 ZpA0-2000-500 ZpA0-2000-600 ZpA0-2000-700 ZpA0-2000-800 ZpA0-2500-300 ZpA0-2500-400 ZpA0-2500-500 ZpA0-2500-600 ZpA0-2500-700 ZpA0-2500-800)




#mzp=$1
#ma0=$2
#samples_2hdm=(ZpA0-2500-300)

#samples_2hdm=(ZpA0-1700)

echo "med dm twosigdown onesigdown exp onesigup twosigup" > limits_2hdm.txt


#for k in "${samples_2hdm[@]}"; do
#for (( i=800; i <= 4000; i=i+50 )); do
 #   for (( j=300; j <= 1025; j=j+25 )); do
i=1000
j=300	
	mh=125
        ma0=$j
        mzp=$i
	
        mt=$(($mh+$ma0))
        #echo "mass ="$mt
        if [[ $mzp -ge $mt ]]
            then
            echo "found"  $mzp, $ma0
            
	    
	    k=ZpA0-$i-$j
	    mediator=${k#'ZpA0-'}
	    dmmass=${mediator#*-}
	    mediator=${mediator%-*}
	    branchingratio='1.0'
	    
	    cp combined_tmpl.txt combined.txt
	    sed -i 's/XX-SIGNAL-XX/'${k}'/g' combined.txt
	    
    #Computing limits
	    combine -M Asymptotic -t -1 combined.txt  --rAbsAcc 0 --rMax 20 --verbose 3 | tee limits_tmp.txt
    #Parsing results into textfile
	    twosigdown=`cat limits_tmp.txt | grep 'Expected  2.5%: r <' | awk '{print $5}'`
	    onesigdown=`cat limits_tmp.txt | grep 'Expected 16.0%: r <' | awk '{print $5}'`
	    exp=`cat limits_tmp.txt | grep 'Expected 50.0%: r <' | awk '{print $5}'`
	    onesigup=`cat limits_tmp.txt | grep 'Expected 84.0%: r <' | awk '{print $5}'`
	    twosigup=`cat limits_tmp.txt | grep 'Expected 97.5%: r <' | awk '{print $5}'`
	    
    #Applying branching ratio
	    twosigdown=`echo "scale=7 ; $twosigdown / $branchingratio" | bc`
	    onesigdown=`echo "scale=7 ; $onesigdown / $branchingratio" | bc`
	    exp=`echo "scale=7 ; $exp / $branchingratio" | bc`
	    onesigup=`echo "scale=7 ; $onesigup / $branchingratio" | bc`
	    twosigup=`echo "scale=7 ; $twosigup / $branchingratio" | bc`
	    
	    
	    echo "${mediator} ${dmmass} ${twosigdown} ${onesigdown} ${exp} ${onesigup} ${twosigup}" >> limits_2hdm.txt
	    
	    cp higgsCombineTest.Asymptotic.mH120.root higgsCombineTest.Asymptotic.${k}.root
	fi
#    done
#done 
