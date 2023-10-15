gen:
	smithy4s generate service.smithy --output smithy_generated

dump:
	smithy4s dump-model

clean:
	rm -rf .bsp/ .metals/ smithy_generated/ app.App.json META-INF/

run: 
	scala-cli run .
