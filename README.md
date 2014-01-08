Academic XeLaTeX Template
=========================

You should have installed XeLaTeX, it's bundeled with the MacTeX distribution.
You should have installed Adobe's OpenSource Fonts:

  * Source Sans Pro: http://sourceforge.net/projects/sourcesans.adobe/files/
  * Source Code Pro: http://sourceforge.net/projects/sourcecodepro.adobe/files/

You can also use other fonts, but this must be configured!

Make the PDF
------------

Simply type:

    make pdf

Per default the pdf is located at _build/BUILDNAME.
In the Makefile you can define the output filename BUILDNAME.

Structure
---------

Document.tex is the root document.
In Config.header.tex are the usepackages and other TeX preamble parameters defined.
In Config.methods.tex are the user defined makros.
In Biblotgraphy.bib is the bibtex list of your references for this work.

In Titlepages are the Templates for the titlepages.
In Chapters is the content of the document.
In this manner you can create Figures or Code folders.

Cheat Sheet
-----------

Formatting fonts:

    \emph{Kursiv}
    {\tt Typewriter}

Quotes:

    Inline (German): „inline Zitat“

    \begin{quote}
      Zitierter Text.
    \end{quote}

    http://merkel.zoneo.net/Latex/natbib.php
    http://www.ctan.org/tex-archive/biblio/bibtex/contrib/german/din1505

    \citep[siehe][S.~15]{default}
    \citep{default}
    \citet{default}

Formatting Lists:

    \begin{itemize}
      \item X
    \end{itemize}

    \begin{enumerate}
      \item X
    \end{enumerate}

Formatting Tables: http://en.wikibooks.org/wiki/LaTeX/Tables

    \begin{tabular}{ l | c || r }
      \hline                        
      1 & 2 & 3 \\
      4 & 5 & 6 \\
      7 & 8 & 9 \\
      \hline  
    \end{tabular}

Table with captions: http://www.weinelt.de/latex/table.html

    \begin{table}[tbp]
      % tabular
      \caption{Lorem ipsum.}
    \end{table}


Formatting Figures:

    \begin{figure}[h!]
      \centering
      \includegraphics[width=1.0\textwidth]{Figures/Fig.png}
      \caption{Lorem ipsum.}\label{lorem}
    \end{figure}

    \ref{lorem}

Formatting Code:

    \begin{verbatim}
    print "this is a little code snippet"
    \end{verbatim}

    \verb|inline verbatim|

http://en.wikibooks.org/wiki/LaTeX/Source_Code_Listings

    \begin{lstlisting}
    Put your code here.
    \end{lstlisting}
