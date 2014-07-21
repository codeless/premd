[+ AutoGen5 template +]
% TEX template used in conjuction with AutoGen for offers
% Created on: 2011-05-18

% Macros for headings:
\font\titlefont=cmbx10 scaled \magstep1
\font\medium=cmbx10 scaled \magstep1
\def\subject#1{\leftline{\titlefont #1}\medskip}


{\bf Von:}\par
Max Muster\par
Milchgasse 8\par
3333 Entenhausen
\bigskip
\bigskip


{\bf An:}\par
Kurt Kunde\par
Milchgasse 10\par
3333 Entenhausen\par
\rightline{\it Entenhausen, am [+ date +]}
\bigskip
\bigskip
\bigskip

\subject{Angebot [+ title +]}

Sehr geehrte(r) Name!

Wie besprochen kann ich wie folgt anbieten:

% Paragraphs:
[+ FOR paragraphs +][+ 
	IF tablerows "\n" +]\bigskip\settabs [+ columns
		+] \columns[+ 
		FOR tablerows +]\+[+
			FOR columns "&" +][+ 
				columns +][+ 
			ENDFOR columns +]\cr
		[+ ENDFOR tablerows +]\bigskip[+
	ELSE +][+
		text +]

		[+
	ENDIF +]
[+ ENDFOR paragraphs +]

+ 20% MwSt.

Ab wann kann Auftrag begonnen werden?

Mit freundlichen Grüßen,
Max Muster

\bye
