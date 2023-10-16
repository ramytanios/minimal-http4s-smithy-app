clean:
	git clean -Xdf

gen:
	make clean
	smithy4s generate service.smithy \
		--output src_generated \
		--resource-output resource_generated

dump:
	smithy4s dump-model

compile: 
	make gen
	scala-cli --power compile *.scala

compile-watch:
	make gen 
	scala-cli --power compile --watch *.scala

package:
	scala-cli --power package \
		*.scala \
		src_generated/ \
		-o srv \
		-f

run: 
	make clean
	make gen 
	make package 
	./srv
