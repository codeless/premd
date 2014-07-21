#! /bin/bash

# Converts text files to tex files and in that turn from tex to pdf
#
# Created on: 2011-05-07
# Updated on: 2011-05-18 (added template parameter)
#
# Text files which can get processed via this script should have been
# created under the following rules:
#
#	(*) A paragraph is a heading, a textblock or a table
#
#	(*) A paragraph is ended via twice linebreaks
#
#	(*) A heading is identified by one to three hyphens at the very
#	start of the line
#
#	(*) A table is identified by the usage of the pipe-character in
#	each line of a table
#
# This script makes use of SED, AUTOGEN and PDFTEX.

source library.sh

if [ $# -ge 1 ]
then
	# Find patterns/rules in text file and convert to AUTOGEN file
	`/usr/bin/awk -f txt2def.awk \
		$1 > /tmp/$1.def`

	# Which template to use?
	if [ $# -eq 1 ]
	then
		template=document
	else
		template=$2
	fi
	
	# Convert AUTOGEN definition file to TEX-file (special-chars!)
	/usr/bin/autogen \
		-T $template.tpl \
		/tmp/$1.def > /tmp/$1.tex

	# Handle special characters in TEX file:
	cat /tmp/$1.tex \
	| sed -e 's/Ä/\\"A/g' \
	| sed -e 's/Ü/\\"U/g' \
	| sed -e 's/Ö/\\"O/g' \
	| sed -e 's/ä/\\"a/g' \
	| sed -e 's/ü/\\"u/g' \
	| sed -e 's/ö/\\"o/g' \
	| sed -e 's/ß/{\\ss}/g' \
	| sed -e 's/ __/ \\underbar{/g' \
	| sed -e 's/{__/{\\underbar{/g' \
	| sed -e 's/^__/{\\underbar{/g' \
	| sed -e 's/__ /} /g' \
	| sed -e 's/__}/}}/g' \
	| sed -e 's/__\./}./g' \
	| sed -e 's/__$/}/g' \
	| sed -e 's/_/\\_/g' \
	| sed -e 's/->/$\\to$/g' \
	| sed -e 's/\(.\+\)%/\1\\%/g' \
	| sed -e 's/€/{EUR}/g' \
	> /tmp/$1.tex2
	rm /tmp/$1.tex
	mv /tmp/$1.tex2 /tmp/$1.tex

	# Convert TEX-file to PDF-file
	tex -output-directory /tmp/ /tmp/$1.tex
	evince /tmp/$1.dvi
else
	show_message "Bad parametercount" true
fi
