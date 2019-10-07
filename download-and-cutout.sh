#!/bin/bash

# Download data from VIIRS, save a cut-out of The Netherlands in fits, and throw away the downloaded file

set -e

wget https://www.ngdc.noaa.gov/eog/viirs/download_dnb_composites_iframe.html
grep -A2 Tile2_75N060W download_dnb_composites_iframe.html | grep http | sed -e 's/.*"\(.*\)".*/\1/' > all-urls.txt

while IFS= read -r line; do
  thisdate=$(echo $line | sed -e 's/.*\/\(20....\)\/.*/\1/')
  thismonth=$(echo $thisdate | sed -e 's/.*\(.\)/\1/')
  if [ "$thismonth" -gt 3 -a "$thismonth" -lt 9 ]; then
    echo "Skipping $thisdate because of summer"
    continue
  else
    echo "Not skipping, thismonth=$thismonth"
  fi
  #echo $thisdate
  #echo "tester: $line"
  if [ ! -f $thisdate.tif ]; then
     echo "going to download $thisdate"
     wget -c $line
     tar xf SVDNB_npp_$thisdate*
     /Applications/QGIS3.8.app/Contents/MacOS/bin/gdal_translate -projwin 0.316193426136 55.8180234044 10.2594886424 47.5070064726 -of GTiff *rade9h* $thisdate.tif
     rm -rf SVDNB_npp_$thisdate*
  else
     echo "already downloaded $thisdate"
  fi
done < all-urls.txt
