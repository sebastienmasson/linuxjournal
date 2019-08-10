#!/bin/sh
#
# AUTHOR
# Sebastien Masson
#
# DESCRIPTION
# Manage and build your own Linux Journal archives website
# This script automatically builds an index file for linux archives
#
# HOW TO?
# - Copy this script into your webserver www/<website>/ root folder (typically: /var/www/<website>/)
# - Copy all archives into $archivesdirectory
# - Run it
#
# LICENSE
# GPL v.3

#########################
# Configure script here #
#########################
targetindexdir="./html"
archivesdir="./html/archives"
defaultredirection="http://linuxjournal.masson.engineer:27480"

########################
# HTML page generation #
########################
mkdir -p "$targetindexdir/"
mkdir -p "$archivesdir/"

rm -f "$archivesdir/index.html"

#
# Website index.html
#
targetindexhtml="$targetindexdir/index.html"

echo "<html>" > $targetindexhtml
echo "<head>" >> $targetindexhtml
echo "<title>Linux Journal Archives</title>" >> $targetindexhtml
echo "<meta name=\"description\" content=\"One of many Linux Journal archives back up for future generations\">" >> $targetindexhtml
echo "<meta name=\"author\" content=\"Sebastien MASSON\">" >> $targetindexhtml
echo "<meta name=\"keywords\" content=\"Linux, Journal, News, Archives, GNU, Magazine, Back up\">" >> $targetindexhtml
echo "<meta name=\"license\" content=\"GNU General Public License v.3\">" >> $targetindexhtml
echo "<base target=\"_blank\">" >> $targetindexhtml
echo "</head>" >> $targetindexhtml
echo "<body>" >> $targetindexhtml

echo "<h1>Linux Journal Archives</h1>" >> $targetindexhtml
echo "So long Linux Journal.  We have loved reading you...and we will keep loving it :-)" >> $targetindexhtml
echo "<p>&nbsp;</p>" >> $targetindexhtml

year_prev=0000
for f in $archivesdir/*
do
	year="$(echo $f | cut -d'/' -f4- | cut -d'-' -f3)"
	if [ "$year_prev" != "$year" ]
	then
		echo "<hr>" >> $targetindexhtml
		echo "<h2>$year</h2>" >> $targetindexhtml
		year_prev=$year
	fi
	echo "<p>" >> $targetindexhtml
	echo "<a href=\"$(echo $f | cut -d'/' -f3-)\">$(echo $f | cut -d'/' -f4-)</a>" >> $targetindexhtml
	echo "</p>" >> $targetindexhtml
done

echo "<p>&nbsp;</p>" >> $targetindexhtml
echo "<hr>" >> $targetindexhtml
echo "<a href=\"https://www.gnu.org/licenses/gpl-3.0.en.html\"><img src=\"https://www.gnu.org/graphics/lgplv3-with-text-154x68.png\"></a>" >> $targetindexhtml

echo "</body>" >> $targetindexhtml
echo "</html>" >> $targetindexhtml


#
# Arvhices directory index.html
#
archivesindexhtml="$archivesdir/index.html"

echo "<html>" > $archivesindexhtml
echo "<head>" >> $archivesindexhtml
echo "<meta name=\"author\" content=\"Sebastien MASSON\">" >> $archivesindexhtml
echo "<meta name=\"license\" content=\"GNU General Public License v.3\">" >> $archivesindexhtml
echo "<meta http-equiv=\"Refresh\" content=\"0; url=$defaultredirection\">" >> $archivesindexhtml
echo "</head>" >> $archivesindexhtml
echo "<body>" >> $archivesindexhtml
echo "</body>" >> $archivesindexhtml
echo "</html>" >> $archivesindexhtml
