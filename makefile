TEX_FILES = $(wildcard tex/*.tex)
PNG_FILES = $(patsubst tex%.tex,out%.png,$(TEX_FILES))

TEXTOPDF="C:\Program Files\MiKTeX\miktex\bin\x64\texify.exe"
PDFCROP="C:\Program Files\MiKTeX\miktex\bin\x64\pdfcrop.exe"
RUNGS="C:\Program Files\MiKTeX\miktex\bin\x64\rungs.exe"

DEPLOY_DIR="C:\Users\Mattan\Box\Obsidian Vault\Organic Chemistry\Media"

.PHONY: all deploy clean

all: out $(PNG_FILES)

out:
	mkdir out

out/%.png: tex/%.tex
	cd out && $(TEXTOPDF) --pdf -s --clean $(patsubst %, ../%, $^)
	$(PDFCROP) $(patsubst tex/%.tex,out/%.pdf,$^) $(patsubst tex/%.tex,out/%_cropped.pdf,$^)
	$(RUNGS) -q -dBATCH -dNOPAUSE -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -sDEVICE=png256 -r600x600 -sOutputFile=$@ $(patsubst tex/%.tex,out/%_cropped.pdf,$^)

deploy : 
	cd out && copy "*.png" $(DEPLOY_DIR)

clean :
	cd out && DEL /f *.pdf *.png

	
	