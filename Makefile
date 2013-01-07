CC=		gcc
CXX=		g++
CFLAGS=		-g -Wall -O2 #-Wno-unused-but-set-variable
CXXFLAGS=	$(CFLAGS)
AR=			ar
DFLAGS=		-DHAVE_PTHREAD #-D_NO_SSE2 #-D_FILE_OFFSET_BITS=64
LOBJS=		bwa.o bamlite.o utils.o bwt.o bwtio.o bwtaln.o bwtgap.o bntseq.o stdaln.o \
			bwaseqio.o bwase.o kstring.o \
	bwase1.o bwase4.o bwaseio1.o bwapese1.o \
	bwape1.o bwape2.o bwape3.o bwape4.o bwapeio1.o

AOBJS=		QSufSort.o bwt_gen.o \
			is.o bwtmisc.o bwtindex.o ksw.o simple_dp.o \
			bwape.o cs2nt.o \
			bwtsw2_core.o bwtsw2_main.o bwtsw2_aux.o bwt_lite.o \
			bwtsw2_chain.o fastmap.o bwtsw2_pair.o
PROG=		bwa
INCLUDES=	
LIBS=		-lm -lz -lpthread
SUBDIRS=	.

.SUFFIXES:.c .o .cc

.c.o:
		$(CC) -c $(CFLAGS) $(DFLAGS) $(INCLUDES) $< -o $@
.cc.o:
		$(CXX) -c $(CXXFLAGS) $(DFLAGS) $(INCLUDES) $< -o $@

all:$(PROG)

main.o: main.c main.h
	d=`date` ;\
	$(CC) $(CFLAGS) $(DFLAGS) $(INCLUDES) -DBLDDATE="$$d" -c main.c -o main.o

bwa:libbwa.a $(AOBJS) main.o
		$(CC) $(CFLAGS) $(DFLAGS) $(AOBJS) main.o -o $@ -L. -lbwa $(LIBS)

libbwa.a:$(LOBJS)
		$(AR) -csru $@ $(LOBJS)

depend:
		makedepend $(DFLAGS) -Y *.c

clean:
		$(RM) gmon.out core.* *.o a.out $(PROG) *~ *.a

cleanall:
		$(MAKE) clean

# DO NOT DELETE

QSufSort.o: QSufSort.h
bamlite.o: bamlite.h
bntseq.o: bntseq.h kseq.h main.h utils.h
bwa.o: bntseq.h bwa.h bwt.h bwtaln.h bwtgap.h stdaln.h
bwape.o: bntseq.h bwase.h bwatpx.h bwt.h bwtaln.h khash.h ksort.h kstring.h
bwape.o: kvec.h stdaln.h utils.h
bwape1.o: bntseq.h bwatpx.h bwt.h bwtaln.h khash.h ksort.h kstring.h kvec.h
bwape1.o: stdaln.h
bwape2.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwape3.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwape4.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwapeio1.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwapese1.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwase.o: bntseq.h bwase.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwase.o: utils.h
bwase1.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwase4.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwaseio1.o: bntseq.h bwatpx.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwaseqio.o: bamlite.h bwt.h bwtaln.h kseq.h stdaln.h utils.h
bwatpx.o: bntseq.h bwt.h bwtaln.h kstring.h kvec.h stdaln.h
bwt.o: bwt.h kvec.h utils.h
bwt_gen.o: QSufSort.h
bwt_lite.o: bwt_lite.h
bwtaln.o: bwt.h bwtaln.h bwtgap.h stdaln.h utils.h
bwtgap.o: bwt.h bwtaln.h bwtgap.h stdaln.h
bwtindex.o: bntseq.h bwt.h main.h utils.h
bwtio.o: bwt.h utils.h
bwtmisc.o: bntseq.h bwt.h main.h utils.h
bwtsw2.o: bntseq.h bwt.h bwt_lite.h
bwtsw2_aux.o: bntseq.h bwt.h bwt_lite.h bwtsw2.h kseq.h ksort.h kstring.h
bwtsw2_aux.o: stdaln.h utils.h
bwtsw2_chain.o: bntseq.h bwt.h bwt_lite.h bwtsw2.h ksort.h
bwtsw2_core.o: bntseq.h bwt.h bwt_lite.h bwtsw2.h khash.h ksort.h kvec.h
bwtsw2_main.o: bntseq.h bwt.h bwt_lite.h bwtsw2.h utils.h
bwtsw2_pair.o: bntseq.h bwt.h bwt_lite.h bwtsw2.h ksort.h kstring.h ksw.h
cs2nt.o: bwt.h bwtaln.h stdaln.h
fastmap.o: bntseq.h bwt.h kseq.h kvec.h
kstring.o: kstring.h
ksw.o: ksw.h
main.o: main.h utils.h
simple_dp.o: kseq.h stdaln.h utils.h
stdaln.o: stdaln.h
utils.o: utils.h
