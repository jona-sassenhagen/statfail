# Copyright (c) 2016 Jona Sassenhagen and Phillip Alday
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/

paper=nuisance_failure

.PHONY: pdf docx draft draft_pdf draft_docx

pdf: $(paper).pdf

docx: $(paper).docx

draft: draft_pdf draft_docx
	
draft_pdf: $(paper).pdf
	cp $(paper).pdf $(paper)_`git show -s --format=%ci HEAD | awk '{print $$1}'`_`git rev-parse --short HEAD`.pdf

draft_docx: $(paper).docx
	cp $(paper).docx $(paper)_`git show -s --format=%ci HEAD | awk '{print $$1}'`_`git rev-parse --short HEAD`.docx

$(paper).docx: $(paper).html methods.md references.bib template.docx
	pandoc -o $@ $< --include-after-body=methods.md --bibliography=references.bib --reference-docx=template.docx

$(paper).html: $(paper).md methods.html references.bib
	pandoc -o $@ $< --include-after-body=methods.html --bibliography=references.bib

$(paper).pdf: $(paper).md methods.tex references.bib
	pandoc -o $@ $< --include-after-body=methods.tex --bibliography=references.bib
	
$(paper).tex: $(paper).md methods.tex references.bib
	pandoc -o $@ $< --include-after-body=methods.tex --bibliography=references.bib
	
clean:
	rm -f $(paper).{pdf,docx,tex,html}
	rm -f methods.{pdf,docx,tex,html}

%.tex: %.md
	pandoc -o $@ $<

%.docx: %.md
	pandoc -o $@ $<

%.html: %.md
	pandoc -o $@ $<
	
statfail_simul.pdf: simulation.py
	python simulation.py
