% !TeX root = optimize-unix.tex
% !TEX program = pdflatex
% 'bt' LaTeX class

% ------------ identification --------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bt}[2017/05/12 Bernard TATIN]


% ------------ required packages ------------
\RequirePackage[condensed]{gillius2}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[french]{babel}

\RequirePackage{xcolor}

\RequirePackage[a4paper,textwidth=19cm,textheight=24cm]{geometry}
\RequirePackage{fancyhdr}


% ------------ journal options --------------
% article, book, a4, letter
\newif\ifbtjournal		\btjournalfalse
\newif\ifbtbook         \btbooktrue

\newif\ifbtaFour           \btaFourtrue
\newif\ifbtletter       \btletterfalse

% more parameters - for next version
%% \newif\ifbtsansserif    \btsansseriffalse
%% \newif\ifbtserif        \btseriffalse
%% \newif\ifwithpartalpha	\withpartalphafalse

\newcommand{\bttcolumnmode}{}
\newlength\bttpointsize

\DeclareOption{journal}{%
   \btjournaltrue %
   \bttpointsize=9pt
}

\DeclareOption{book}{%
   \btbooktrue %
   \bttpointsize=12pt
}

\DeclareOption{9pt}{%
   \bttpointsize=9pt
}
\DeclareOption{10pt}{%
   \bttpointsize=10pt
}
\DeclareOption{11pt}{%
   \bttpointsize=11pt
}
\DeclareOption{12pt}{%
   \bttpointsize=12pt
}

% \DeclareOption{openbib}{%
   % \AtEndOfPackage{%
   % \renewcommand\@openbib@code{%
      % \advance\leftmargin\bibindent
      % \itemindent -\bibindent
      % \listparindent \itemindent
      % \parsep \z@
   % }
   % \renewcommand\newblock{\par}}%
% }


% ------------ base classe -----------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\ifdim\bttpointsize>11pt
   \PassOptionsToClass{12pt}{article}
\else
	\ifdim\bttpointsize>10pt
   		\PassOptionsToClass{11pt}{article}
	\else
		\ifdim\bttpointsize>9pt
	   		\PassOptionsToClass{10pt}{article}
		\else
	   		\PassOptionsToClass{9pt}{article}
		\fi
	\fi
\fi

\LoadClass{article}
%% these packages must be AFTER the class is loaded !!
%% needed by the list of listings
\RequirePackage{listings}
\RequirePackage{caption}

% ------------ abstract configuration ------
\newcommand{\bttabstxt}{}
\let\origabstract\abstract
\let\endorigabstract\endabstract
\renewcommand{\abstract}[1]{\renewcommand{\bttabstxt}{#1}}

\newlength{\abstxtspace}
\setlength{\abstxtspace}{0.20in}

\newlength{\titlespace}
\setlength{\titlespace}{0.25in}

\newlength{\teaserspace}
\setlength{\teaserspace}{0.0in}


\newcommand{\authorfootertext}{}
\newcommand{\authorfooter}[1]{\renewcommand{\authorfootertext}{{\em#1}}}

\renewcommand{\figurename}{Fig.}

\setlength{\topmargin}{-1.56875cm}
\setlength{\headheight}{0.156875cm}
\setlength{\headsep}{0.6275cm}
\setlength{\footskip}{0.6275cm}
\flushbottom
\setlength{\columnsep}{0.4267cm}
\setlength{\marginparwidth}{65em}

\setlength{\evensidemargin}{-1.725625cm} %1in-0.3125
\setlength{\oddsidemargin}{-1.4558cm} %1in-0.4375

\renewcommand{\ps@plain}%
   {%
      \renewcommand{\@oddhead}{\hfil\textit{\THETITLE}\hfil}%
      \renewcommand{\@oddfoot}{\hfil\textrm{\thepage}\hfil}%
      \renewcommand{\@evenhead}{\@oddhead}%
      \renewcommand{\@evenfoot}{\@oddfoot}%
   }

\pagestyle{plain}

\newcommand{\bttsetninepoint}{%
   \renewcommand\normalsize{%
       \@setfontsize\normalsize\@ixpt\@xpt
       \abovedisplayskip 9\p@ \@plus2\p@ \@minus4\p@
       \abovedisplayshortskip \z@ \@plus3\p@
       \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
       \belowdisplayskip \abovedisplayskip
       \let\@listi\@listI}
   \renewcommand\small{%
       \@setfontsize\small\@viipt\@ixpt
       \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
       \abovedisplayshortskip \z@ \@plus2\p@
       \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
       \def\@listi{\leftmargin\leftmargini
                   \topsep 4\p@ \@plus2\p@ \@minus2\p@
                   \parsep 2\p@ \@plus\p@ \@minus\p@
                   \itemsep \parsep}%
       \belowdisplayskip \abovedisplayskip}
   \renewcommand\footnotesize{%
       \@setfontsize\footnotesize\@viiipt{9.5}%
       \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
       \abovedisplayshortskip \z@ \@plus\p@
       \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
       \def\@listi{\leftmargin\leftmargini
                   \topsep 3\p@ \@plus\p@ \@minus\p@
                   \parsep 2\p@ \@plus\p@ \@minus\p@
                   \itemsep \parsep}%
       \belowdisplayskip \abovedisplayskip}
   \renewcommand\scriptsize{\@setfontsize\scriptsize\@viiipt{9.5}}
   \renewcommand\tiny{\@setfontsize\tiny\@vpt\@vipt}
   \renewcommand\large{\@setfontsize\large\@xpt\@xiipt}
   \renewcommand\Large{\@setfontsize\Large\@xiipt{14}}
   \renewcommand\LARGE{\@setfontsize\LARGE\@xivpt{18}}
   \renewcommand\huge{\@setfontsize\huge\@xviipt{22}}
   \renewcommand\Huge{\@setfontsize\Huge\@xxpt{32}}
   \selectfont
}
\ifdim\bttpointsize<10pt
   \bttsetninepoint
\fi

\newcommand{\bttsectionfont}{}
\newcommand{\sectionfont}[1]{\renewcommand{\bttsectionfont}{#1}}

\newcommand{\setSectionStyle}[1]{\reset@font #1 \sffamily\bfseries\scshape\bttsectionfont{}}
% \newcommand{\LOGO}[1] {\small\textrm{\textbf{\textsc{#1}}\index{#1}}\normalsize}
% {\reset@font\normalsize\sffamily\bfseries\bttsectionfont}
%% \renewcommand\part{\@startsection{part}{0}{\z@}%
               %% {-2.2ex \@plus -1ex \@minus -.2ex}%
               %% {0.8ex \@plus .2ex}%
		   %% {\clearpage\setSectionStyle{\Large}}}
\renewcommand\section{\@startsection{section}{1}{\z@}%
               {-2ex \@plus -1ex \@minus -.2ex}%
               {0.8ex \@minus .1ex}%
		   {\reset@font\setSectionStyle{\large}}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
               {-1.8ex\@plus -1ex \@minus -.2ex}%
               {-0.8ex \@plus -.4ex}%
			{\reset@font\setSectionStyle{\normalsize}}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
               {-1.8ex\@plus -1ex \@minus -.2ex}%
               {-0.8ex \@plus -.4ex}%
			{\reset@font\setSectionStyle{\normalsize}}}

\renewcommand\paragraph{\@startsection{paragraph}{4}{1em}%
               {1ex \@plus 1ex \@minus.2ex}%
               {-1em}%
               {\reset@font\normalsize\sffamily\hsize 5.5in\bttsectionfont}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
               {3.25ex \@plus1ex \@minus .2ex}%
               {-1em}%
               {\reset@font\normalsize\sffamily\bfseries\bttsectionfont}}





\newcommand{\bttindexterms}{}
\newcommand{\CCScatlist}[1]{\renewcommand{\bttindexterms}{#1}}

\newcommand{\CCScat}[4]{%
    #1 [#2]%
    \ifx#3\bttempty \else : #3\fi%
    \ifx#4\bttempty \else ---#4\fi%
}

\let\bttorigmaketitle\maketitle
\let\bttorigand\and

\renewcommand{\footnoterule}{%
   \kern-3pt
   \leftline{\hskip1in\vbox{\hrule width 0.45\columnwidth}\hfil}
}

% ------------ title --------------
% save current title to use it in page header
\def\title#1{\gdef\@title{#1}\gdef\THETITLE{#1}}

\newcommand{\linediamond}{%
	\centering
	\includegraphics{diamondrule.eps}
	\par%
}

\definecolor{titlepagecolor}{cmyk}{1,.80,0,.60}
\definecolor{namecolor}{cmyk}{1,.40,0,.01}

\renewcommand{\@maketitle}{%
	\pagecolor{titlepagecolor}
	\color{white}
	\begin{center}%
		\sffamily
		{%
		   \Huge\bfseries%
	      	   \bttsectionfont%
			   \vspace{8cm}
	      	   \textcolor{namecolor}\@title
	      	   \par
		}%
		\large\bttsectionfont
		\vspace{14pt}%
		%% \begin{tabular}[t]{c}%
			{%
				\textcolor{namecolor}\@author \\
				\textit{\textcolor{namecolor}\@date}
			}\par%
		%% \end{tabular}\par%
		\linediamond
		{%
			\small
			\ifx\bttabstxt\bttempty \else%
				\leftskip = 1.5cm \rightskip = \leftskip%
				\begingroup%
					\textcolor{namecolor}
					{\bfseries Résumé} --- \bttabstxt
				   \par
				\endgroup
				% \par%
				\begin{quote}
					\tableofcontents
					\lstlistoflistings
					% \listoffigures
					%\listoftables
				\end{quote}
				\linediamond
			\fi%
		}
		%% \linediamond
	\end{center}%
	\clearpage
	\pagecolor{white}
}



%% pour les annexes
\renewcommand\appendix{\par
   \setcounter{section}{0}%
   \setcounter{subsection}{0}%
   \gdef\thesection{\@Alph\c@section}
}

\setlength{\columnsep}{0.4267cm}
\setlength{\marginparwidth}{45em}
\setlength{\evensidemargin}{-1.7257cm} %1in-0.3125
\setlength{\oddsidemargin}{-1.46cm} %1in-0.4375

\renewcommand{\familydefault}{\sfdefault}
