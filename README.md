# Extract VIIRS data, map in QGIS

Here are some extracts from the VIIRS satellite. The original data is at https://www.ngdc.noaa.gov/eog/viirs/ or https://eogdata.mines.edu/download_dnb_composites.html . 

The data products were generated by the Earth Observation Group, NOAA National Centers for Environmental Information (NCEI).

The script `download-and-cutout.sh` will download huge files with night images from NOAA, and then use gdal to extract The Netherlands into annotated TIFF files. Then QGIS can be used to make pretty maps.
