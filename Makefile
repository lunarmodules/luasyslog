LUA_PREFIX = /usr/local/
PREFIX	= /usr/local/
MODULE = luasyslog
VERSION = 1.0.0

INSTALL_PREFIX = $(PREFIX)/lib/lua/5.1/

CC	= gcc
TARGET	= lsyslog.so
OBJS	= lsyslog.o
LIBS	=
CFLAGS	= -I $(LUA_PREFIX)/include
LDFLAGS	= -shared

default: $(TARGET)


install_nolua: default
	install -d $(INSTALL_PREFIX)
	install $(TARGET) $(INSTALL_PREFIX)

install:
	install -d $(PREFIX)/share/lua/5.1/logging/
	install -m0644 syslog.lua $(PREFIX)/share/lua/5.1/logging/

clean:
	rm -rf $(OBJS) $(TARGET) $(MODULE)-$(VERSION)

package: clean
	mkdir $(MODULE)-$(VERSION)
	cp lsyslog.c syslog.lua COPYING Makefile $(MODULE)-$(VERSION)
	tar cvzf $(MODULE)-$(VERSION).tar.gz $(MODULE)-$(VERSION)
	rm -rf $(MODULE)-$(VERSION)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $(TARGET) $(OBJS)

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@
