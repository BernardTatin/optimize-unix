# ======================================================================
# pdf.mk
# ======================================================================

ODIR = odir
PDFLATEX = pdflatex -file-line-error -halt-on-error -synctex=1 -output-directory=$(ODIR)
BIBTEX = biber
PS2EPS = ps2pdf14
MAKEINDEX = makeindex -L


FIGURES ?= diamondrule
EFIGURES = $(addsuffix .eps, $(FIGURES))
PFIGURES = $(addsuffix .pdf, $(FIGURES))

ARTICLE_NAME ?= $(shell basename $$(pwd))
PDF_NAME = $(ARTICLE_NAME).pdf
ARTICLE_TEX = $(ARTICLE_NAME).tex

deps = $(shell find . -name "*.tex") $(shell find . -name "*.cls") $(shell find . -name "*.bib")

bad_extensions = aux bbl bcf blg fdb_latexmk fls gz \
					idx ilg ind log out pdf run.xml toc \
					lof lol

all: $(ODIR) $(PDF_NAME)

$(ODIR):
	mkdir -p $@

$(PFIGURES): %.pdf:%.eps
	$(PS2EPS) $<

$(PDF_NAME): $(deps) $(PFIGURES)
	$(PDFLATEX) $(ARTICLE_TEX)
	$(MAKEINDEX) $(ODIR)/$(ARTICLE_NAME).idx
	$(PDFLATEX) $(ARTICLE_TEX)
	$(PDFLATEX) $(ARTICLE_TEX)
	$(PDFLATEX) $(ARTICLE_TEX)
	mv $(ODIR)/$@ .

clean:
	for extension in $(bad_extensions); do \
		rm -f $$(find $(ODIR) -name "*.$$extension"); \
	done;
	rm -f $(PDF_NAME)

.PHONY: all clean
