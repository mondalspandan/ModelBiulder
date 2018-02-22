#!/bin/sh
export SCRAM_ARCH=slc6_amd64_gcc491
currentpath=$PWD
cd /afs/cern.ch/work/k/khurana/monoHSignalProduction/genproductions/bin/MadGraph5_aMCatNLO/testgridpack/CMSSW_7_4_7/src

eval `scram runtime -sh`

cd /afs/cern.ch/work/k/khurana/monoHSignalProduction/genproductions/bin/MadGraph5_aMCatNLO/testgridpack/CMSSW_7_4_5/src/MonoHCombination/FullScan


/afs/cern.ch/work/k/khurana/monoHSignalProduction/genproductions/bin/MadGraph5_aMCatNLO/testgridpack/CMSSW_7_4_5/src/MonoHCombination/FullScan/scan_2hdm.sh 

#cp higgsCombineTest.Asymptotic.mH120.root /eos/cms/store/user/khurana/monohgridpacks/2hdm/limits/higgsCombineTest.Asymptotic_2500_300.root 