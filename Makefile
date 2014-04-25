# following http://lincolnmullen.com/blog/make-and-pandoc/

PAGES := $(patsubst %.md,html/%.html,$(wildcard *.md))

all : $(PAGES)

html/%.html : %.md
	pandoc \
	--smart \
	--include-before=$(patsubst %.md,%.pdc,$<) \
	--include-after=footer.pdc \
	--template=template.pdc \
	--variable=filename:$< \
	--css=./bootstrap.css --css=./main.css \
	$< -o $@

html/index.html : index.pdc
	pandoc \
	--smart \
	--template=template.pdc \
	--css=./bootstrap.css --css=./main.css \
	index.pdc -o html/index.html

clean :
	rm $(PAGES)

rebuild : clean all html/index.html
