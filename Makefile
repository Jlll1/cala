BIN=cala
PREFIX=/usr/local/bin

install:
	chmod 755 ${BIN}
	mkdir -p ${DESTDIR}${PREFIX}
	cp ${BIN} ${DESTDIR}${PREFIX}/${BIN}

uninstall:
	rm -f ${DESTDIR}${PREFIX}/${BIN}

.PHONY: install uninstall
