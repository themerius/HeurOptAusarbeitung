.PHONY: pdf, gen once, bib, move, clean

MAINTEX = Document
CHAPTER = Chapters/
TITLEPAGES = Titlepages/
BUILDPATH = _build/
BUILDNAME = HeurOptAusarbeitung_M.Bumiller-S.Hodapp_2013

pdf:
	$(MAKE) gen
	$(MAKE) once
	$(MAKE) bib
	$(MAKE) once
	$(MAKE) once
	$(MAKE) move
	$(MAKE) clean

once:
	xelatex $(MAINTEX).tex 1> /dev/null

bib:
	bibtex $(MAINTEX).aux 1> /dev/null

move:
	mkdir -p $(BUILDPATH)
	mv $(MAINTEX).pdf $(BUILDPATH)$(BUILDNAME).pdf
	open $(BUILDPATH)$(BUILDNAME).pdf

gen:
	python Code/stats.py tex > Chapters/Gen.StatsTable.tex
	python Code/stats.plot_tspVorlage.py

clean:
	rm -f $(CHAPTER)*.aux
	rm -f $(TITLEPAGES)*.aux
	rm -f $(MAINTEX).aux $(MAINTEX).toc $(MAINTEX).log $(MAINTEX).out
	rm -f $(MAINTEX).lof $(MAINTEX).bbl $(MAINTEX).blg
