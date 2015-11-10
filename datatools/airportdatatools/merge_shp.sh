#!/usr/bin/env bash -x

#
#  Author: Cayetano Benavent, 2015.
#  https://github.com/GeographicaGS
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#

DATAFOLDER=/tmp/flightdata
OUTMERGE_FOLDER=$DATAFOLDER/merged
OUTSHP_MERGED=$OUTMERGE_FOLDER/merged.shp


if [ -d "$DATAFOLDER" ]; then

  cd $DATAFOLDER

  if [ -d "$OUTMERGE_FOLDER" ]; then
      printf '%s\n' "Removing older datafolder ($OUTMERGE_FOLDER)"
      rm -rf "$OUTMERGE_FOLDER"
  fi

  echo "Merging flight data..."

  cd $DATAFOLDER

  mkdir $OUTMERGE_FOLDER

  fio cat */*.shp | fio load --sequence --format Shapefile $OUTSHP_MERGED --src_crs 'GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]]'

  printf '%s\n' "Flight data successfully merged: ($OUTSHP_MERGED)"

else
    printf '%s\n' "Datafolder ($DATAFOLDER) does not exist. You must create flight data before run this script. Exiting..."

fi
