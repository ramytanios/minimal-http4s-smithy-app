smithy-gen:
	smithy4s generate app.smithy --output smithy_generated

clean:
	rm -rf .bsp/ .metals/ smithy_generated/ app.App.json META-INF/
