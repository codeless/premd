# Reads in textfiles and converts them to AutoGen definitions
#
# Created on: 2011-05-07
# Last update on: 2011-12-23
# Reason of last update: added the codeblock-paragraphs
#
# The rules as described in the txt2tex shell script apply.

function add_definition(name, value) {
	value = format_string(value)
	print name "=<<- STR_END"
	print value
	print "STR_END;"
}
function add_text_definition(name, value) {
	print "paragraphs={"
	add_definition(name, value)
	print "};"
}
function add_paragraph(text, number) {
	print "paragraphs={"
	print "number=" number ";"
	add_definition("text", text)
	print "};"
}
function format_string(text) {
	gsub(/\#/, "\\#", text)
	return text
}

BEGIN {
	RS		= "\n\n"
	header1		= "^- .*"
	header2 	= "^-- .*"
	header3 	= "^--- .*"
	graphic		= "^>> .*"
	item		= "^\* .*"
	codeblock	= "^  .*"
	textblock	= "^[A-Z].*"
	configuration	= "^[.].*"
	table		= "\t"
	sectioncounter	= 1
	paragraphcounter= 1

	print "// AutoGen Definitions for a TEXT-file"
	print "//"
	print "// Created on: " strftime("%Y-%m-%d", systime())
	print "// Automatically created by an AWK script"
	print
	print "autogen definitions document;"
	print
}

$0 ~ /^#/ {	# Comments
	next
}

$0 ~ /.*/ {
	# Remove linebreaks at the start and the end of the record:
	gsub(/^\n+/, "", $0)
	gsub(/\n+$/, "", $0)
}

$0 ~ configuration {
	sepi	= index($0, "=")
	name	= substr($0, 2, sepi-2)
	value	= substr($0, sepi+1, length($0))
	if (length(value) > 0) {
		add_definition(name, value)
	}
	next
}
$0 ~ table {
	# Open table and paragraphs:
	print "paragraphs={"

	# Remove double-tabs:
	gsub(/\t+/, "\t", $0)
	
	# Explode into rows
	number_rows = split($0, rows, "\n")

	# Loop trough rows
	for (i=1; i<=number_rows; i++) {
		print "tablerows={"

		# Split current row into columns
		number_columns = split(rows[i], columns, "\t")

		# Loop trough columns
		for (j=1; j<=number_columns; j++) {
			# The first tablerow is made with bold font,
			# since it's the headers:
			if (i==1) {
				print "columns=<<- STR_END\n\\bf{" \
					format_string(columns[j]) \
					"}\nSTR_END;"
			} else {
				print "columns=<<- STR_END\n"	\
					format_string(columns[j])\
					"\nSTR_END;"
			}
		}

		print "};"
	}

	# Save the number of columns
	print "columns=" number_columns ";"

	# Close table and paragraphs
	print "};"

#paragraphs{table={
#		rows={
#			columns={
#		};
#	};
#};
	next
}
$0 ~ graphic {
	add_text_definition("graphic", $2)
	next
}
$0 ~ item {
	$1 = substr($0,3,length($0))
	add_text_definition("item", $1)
	next
}
$0 ~ codeblock {
	puts $0
	$1 = substr($0,3,length($0))
	gsub(/\n/, "\\break \\indent", $1)
	add_text_definition("code", $1)
	next
}
$0 ~ textblock {
	#add_text_definition("text", $0)
	add_paragraph($0, paragraphcounter)
	paragraphcounter = paragraphcounter + 1
	next
}
$0 ~ header1 {
	$1 = substr($0,3,length($0))
	add_text_definition("heading", sectioncounter ". " $1)
	sectioncounter = sectioncounter + 1
}
$0 ~ header2 {
	$1 = substr($0,4,length($0))
	add_text_definition("subheading", $1)
}
$0 ~ header3 {
	$1 = substr($0,5,length($0))
	add_text_definition("subsubheading", $1)
}
