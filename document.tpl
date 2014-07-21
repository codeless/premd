[+ AutoGen5 template +]
% TEX template used in conjuction with AutoGen for documents of all
% kinds
%
% Created on: 2011-05-07

% Hide slugs of overfull boxes:
\tolerance=100000
\overfullrule=0 pt

% Package which allows inclusion of EPS-files:
\input epsf

% EPlain-package for several useful macros (e.g. \today)
\input eplain

% Macros for headings:
\font\titlefont=cmbx10 scaled \magstep3
\font\large=cmbx10 scaled \magstep2
\font\medium=cmbx10 scaled \magstep1
\def\heading#1{\bigskip\bigskip\indent{\leftline{\large #1}}\medskip}
\def\subheading#1{\bigskip\indent\leftline{\medium #1}\medskip}
\def\subsubheading#1{\bigskip\indent\leftline{\bf #1}\medskip}
\def\titletext#1{\titlefont #1\medskip}
[+ IF headline != off +]
\headline{\leftline{\it{\jobname: [+ headline +], kompiliert am: \today
	{ }um \timestring}}}
[+ ENDIF +]
\footline{\rightline{- Seite \folio -}}

% Spacing at the top:
\centerline{}
\centerline{}
\centerline{}

% Document heading
\titletext{[+ title +]}
[+ IF subtitle +]
\centerline{\it{[+ subtitle +]}}
[+ ENDIF +]
\bigskip

\bigskip
[+ IF authors +]
\bf{Autor(en):} \rm{[+ authors +]}
[+ ENDIF +]

[+ IF abstract +]
\medskip
\it{Zusammenfassung: [+ abstract +]}
\rm
\bigskip
[+ ENDIF +]

% Contents
\heading{Inhalt}
[+ FOR paragraphs +][+ 
	IF heading +][+ heading +][+
	ENDIF +]
[+ ENDFOR paragraphs +]
\bigskip

% Paragraphs:
[+ FOR paragraphs +][+ 
	IF heading +]\[+ 
		level +]heading{[+ heading +]}[+
	ELIF subheading +]\[+ 
		level +]subheading{[+ subheading +]}[+
	ELIF subsubheading +]\[+ 
		level +]subsubheading{[+ subsubheading +]}[+
	ELIF graphic +]\smallskip
		\epsfxsize=160mm
		\epsfbox{[+ graphic +]}[+
	ELIF code +]
		\tt [+ code +]
		\smallskip
		\rm [+
	ELIF item +]\smallskip
		\item * {[+ item +]}\smallskip[+
	ELIF tablerows "\n" +]\bigskip\settabs [+ columns +] \columns[+ 
		FOR tablerows +]\smallskip\+[+
			FOR columns "&" +][+ 
				columns +][+ 
			ENDFOR columns +]\cr
			\smallskip\hrule
		[+ ENDFOR tablerows +]\bigskip\bigskip[+
	ELSE +]$^{[+ number +].}$ [+
		text +]
		\medskip

		[+
	ENDIF +]
[+ ENDFOR paragraphs +]

\bye
