.PHONY: pdf, once, bib, move, clean

MAINTEX = Document
CHAPTER = Chapters/
TITLEPAGES = Titlepages/
BUILDPATH = _build/
BUILDNAME = HeurOptAusarbeitung_M.Bumiller-S.Hodapp_2013

pdf:
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

clean:
	rm -f $(CHAPTER)*.aux
	rm -f $(TITLEPAGES)*.aux
	rm -f $(MAINTEX).aux $(MAINTEX).toc $(MAINTEX).log $(MAINTEX).out
	rm -f $(MAINTEX).lof $(MAINTEX).bbl $(MAINTEX).blg
