BINS = atch bri dtch hnel jrp pbcopy pbd pbpaste wake watch xx
CWARNS = -Wall -Wextra -Wpedantic

all: $(BINS)

.c:
	$(CC) $(CWARNS) $(CFLAGS) -o $@ $<

atch: dtch
	ln -f dtch atch

dtch: dtch.c
	$(CC) $(CWARNS) $(CFLAGS) -lutil -o dtch dtch.c

hnel: hnel.c
	$(CC) $(CWARNS) $(CFLAGS) -lutil -o hnel hnel.c

jrp: jrp.c
	$(CC) $(CWARNS) $(CFLAGS) -ledit -o jrp jrp.c

pbcopy: pbd
	ln -f pbd pbcopy

pbpaste: pbd
	ln -f pbd pbpaste

clean:
	rm -f $(BINS)

link: $(BINS)
	ln -s -f $(BINS:%=$(PWD)/%) ~/.bin

unlink:
	rm -f $(BINS:%=~/.bin/%)

.PHONY: all clean link unlink