PROJECTNAME=paper
DIFF_REFERENCE=submissions/chi-2025/0-submission/source
TAPS_NAME=chi25-000

.PHONY: clean clean-all pdf html source taps diff

clean-exports:
	rm -rf source Source 
	rm -rf $(TAPS_NAME).zip $(PROJECTNAME).tar.gz
	rm -rf $(PROJECTNAME).{css,html} html/
	rm -rf $(PROJECTNAME).pdf pdf/

clean-temp:
	rm -f $(PROJECTNAME).{aux,bbl,blg,dep,log,out,synctex.gz,fls,fdb_latexmk,tar.gz} comment.cut
	rm -f $(PROJECTNAME).{4tc,4ct,dvi,idv,lg,tmp,xcp,xref}
	rm -f paper*x.png

clean-all:
	make clean-temp
	make clean-exports


pdf:
	pdflatex $(PROJECTNAME)
	bibtex $(PROJECTNAME)
	pdflatex $(PROJECTNAME)
	pdflatex $(PROJECTNAME)
	mkdir pdf && mv $(PROJECTNAME).pdf pdf/

html:
	htlatex $(PROJECTNAME)
	bibtex $(PROJECTNAME)
	htlatex $(PROJECTNAME)
	htlatex $(PROJECTNAME)
	mkdir html && mv $(PROJECTNAME).html $(PROJECTNAME).css html/
	

source:
	tar -czf $(PROJECTNAME).tar.gz `tex-scripts/texdeps.pl $(PROJECTNAME).tex`
	mkdir source && tar -xzf $(PROJECTNAME).tar.gz -C source

taps: 
	make clean-all 
	make html 

	make clean-temp
	make pdf

	make source
	mv source Source
	SOURCE_DIR=Source PROJECTNAME=$(PROJECTNAME) bash tex-scripts/tapsify-source.sh

	zip -r $(TAPS_NAME).zip Source pdf

diff: 
	cp -r source diff && rm diff/*.tex
	python tex-scripts/latexdiff-recursive.py $(DIFF_REFERENCE) . diff
	cd diff && latexmk -pdf $(PROJECTNAME).tex
	tar -czf $(PROJECTNAME)-diff.tar.gz diff

texcount:
	texcount $(PROJECTNAME).tex -inc

bibexport:
	bibexport $(PROJECTNAME)

checkcites:
	checkcites $(PROJECTNAME)
