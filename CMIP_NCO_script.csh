#!/bin/bash

# This code reads the CMIP6 data files, regrids and saves recursively 
# Software requirement: NCO
# Developed by: Nishant Uchale, IDP Climate Studies, IIT Bombay
# Developed on: 13 September 2023
# Revision history: 

# Go to the data directory (change this according to your data directory
cd /scratch/vishald/jrf2_monsoonlab/nishant/CMIP_data/

# Extracting only links from CMIP wget scripts and storing in .txt file so that file names can be extracted fromm here
grep -o -h -s "https://esgf-data2.llnl.gov/thredds/fileServer/user_pub_work/CMIP6/CMIP/[^']*" *.sh > outputlink.txt

# Extracting only links from CMIP wget scripts and storing in my_array1
my_array1=()
while IFS= read -r line; do
    my_array1+=( "$line" )
done < <( grep -o -h -s "https://esgf-data2.llnl.gov/thredds/fileServer/user_pub_work/CMIP6/CMIP/[^']*" *.sh )


# Extracting file names from links in .txt file and storing in my_array2
my_array2=()
while IFS= read -r line; do
    my_array2+=( "$line" )
done < <( grep -o "tas_day_[^']*" outputlink.txt )


# Read all the links from my_array1, download the sliced files using NCO, rename as in my_array2
for index in ${!my_array1[*]}; do 
  ncks -d lat,0.,45. -d lon,60.,100. ${my_array1[$index]} ${my_array2[$index]}
  #echo "This is the link ${my_array1[$index]} and this is the file ${my_array2[$index]}"
done


# End of code
