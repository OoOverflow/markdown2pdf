# Makefile
# convert the markdown file to a pdf file
# need install markdown pandoc libreoffice5.1

 

MD = markdown

MDFLAGS = -T

H2D = pandoc

D2P = libreoffice5.1

D2PFLAGS = --convert-to pdf

H2DFLAGS = -f html -t docx

SOURCES := $(wildcard *.md)

OBJECTS := $(patsubst %.md, %.html, $(wildcard *.md))

OBJECTS_DOCX := $(patsubst %.md, %.docx, $(wildcard *.md))

OBJECTS_PDF := $(patsubst %.md, %.pdf, $(wildcard *.md))

 

all: build

 

build: html docx pdf

pdf:$(OBJECTS_PDF) 

docx: $(OBJECTS_DOCX)

 

html: $(OBJECTS)

$(OBJECTS_PDF): %.pdf: %.docx 
	$(D2P) $(D2PFLAGS) $<

$(OBJECTS_DOCX): %.docx: %.html
	$(H2D) $(H2DFLAGS) -o $@ $<

$(OBJECTS): %.html: %.md
	cp $< $<.tmp
	'sed' -i '1i\<meta http-equiv="content-type" content="text/html; charset=UTF-8">' *.md.tmp
	$(MD) $(MDFLAGS) -o $@ $<
	rm -f $<.tmp

clean:
	rm -f $(OBJECTS)
	rm -f $(OBJECTS_DOCX)
