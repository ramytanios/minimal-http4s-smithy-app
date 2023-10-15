gen:
	smithy4s generate service.smithy --output smithy_generated

dump:
	smithy4s dump-model

clean:
	rm -rf .bsp/ .metals/ smithy_generated/ app.App.json META-INF/

runOnly: 
	scala-cli run .

package:
	scala-cli --power package \
		Service.scala \
		project.scala \
		smithy_generated/\
		-o srv \
		-f

run: 
	make clean
	make gen 
	make package 
	./srv
