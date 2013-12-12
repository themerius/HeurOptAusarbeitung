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

\begin{itemize}
  \item X
\end{itemize}

\begin{enumerate}
  \item X
\end{enumerate}

http://en.wikibooks.org/wiki/LaTeX/Tables

\begin{tabular}{ l | c || r }
  \hline                        
  1 & 2 & 3 \\
  4 & 5 & 6 \\
  7 & 8 & 9 \\
  \hline  
\end{tabular}

\begin{figure}[h!]
  \centering
  \includegraphics[width=1.0\textwidth]{Figures/Fig.png}
  \caption{Lorem ipsum.}\label{lorem}
\end{figure}

\ref{lorem}

\begin{verbatim}
print "this is a little code snippet"
\end{verbatim}

\verb|inline verbatim|

http://en.wikibooks.org/wiki/LaTeX/Source_Code_Listings

\begin{lstlisting}
Put your code here.
\end{lstlisting}
