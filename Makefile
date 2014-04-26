# following http://lincolnmullen.com/blog/make-and-pandoc/

PAGES := $(patsubst %.md,html/%.html,$(wildcard 0*.md))

all : $(PAGES)

html/%.html : %.md
	pandoc \
	--smart \
	--include-before=$(patsubst %.md,%.pdc,$<) \
	--include-after=footer.html \
	--template=template.html \
	--variable=filename:$< \
	--variable=not-index:true \
	--css=./bootstrap.css --css=./main.css \
	$< -o $@

html/index.html : index.md
	pandoc \
	--smart \
	--variable=filename:index.md \
	--template=template.html \
	--css=./bootstrap.css --css=./main.css \
	index.pdc -o html/index.html

clean :
	rm $(PAGES)
	rm html/index.html

rebuild : clean all html/index.html
