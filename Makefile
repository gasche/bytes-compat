BYTE_FILES=bytes.cmi bytes.cma
NATIVE_FILES=bytes.cmx bytes.cmxa bytes.cmxs
OCAMLBUILD=ocamlbuild -classic-display -no-links

build: byte native

byte:
	$(OCAMLBUILD) $(BYTE_FILES)

native:
	$(OCAMLBUILD) $(NATIVE_FILES)

install-byte: byte
	cd _build/ && ocamlfind install bytes ../META $(BYTE_FILES)

install-native: native
	$(MAKE) install-byte
	cd _build/ && ocamlfind install bytes -add $(NATIVE_FILES)

install: install-native

uninstall:
	ocamlfind remove bytes

clean:
	ocamlbuild -clean
