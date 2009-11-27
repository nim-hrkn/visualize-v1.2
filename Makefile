FC=gfortran 
FFLAGS=  -ffixed-line-length-132 -O3   -fopenmp -fbounds-check
LDFLAGS=
LIBS=-lfftw3 -lguide -lpthread

#FC=ifort
#FFLAGS= -132 -O3 -openmp
#LDFLAGS=
#LIBS=-lfftw3 -lguide -lpthread


#PROGS= calc_wfn calc_wannier
PROGS= prtwf7

OBJS=m_DATA4GW.o m_QG.o m_LMTO.o m_FFT3D.o lin3.o mymath.o myYlm.o wfn2dx.o m_MLWF.o
OBJS2=m_DATA4GW.o m_QG.o m_LMTO.o m_FFT3D.o lin3.o mymath.o myYlm.o wfnrho2.o wfn2dx_2.o m_MLWF.o cross.o cubeformat.o xsfformat2.o  keyvalue.o  expand_mesh.o  wfn2dx_abc.o wfnrho_abc.o write_mesh2d.o 

all : ${PROGS}

calc_wfn : ${OBJS} calc_wfn.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS} calc_wfn.o -o $@ ${LIBS}

calc_wannier : ${OBJS} calc_wannier.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS} calc_wannier.o -o $@ ${LIBS}

calc_wfn2 : ${OBJS2} calc_wfn2.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS2} calc_wfn2.o	-o $@ ${LIBS}

calc_wannier2 : ${OBJS2} calc_wannier2.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS2} calc_wannier2.o	-o $@ ${LIBS}
calc_wannier3 : ${OBJS2} calc_wannier3.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS2} calc_wannier3.o	-o $@ ${LIBS}
calc_wannier4 : ${OBJS2} calc_wannier4.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS2} calc_wannier4.o	-o $@ ${LIBS}
calc_wannier5 : ${OBJS2} calc_wannier5.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS2} calc_wannier5.o	-o $@ ${LIBS}
calc_wannier6 : ${OBJS2} calc_wannier6.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS2} calc_wannier6.o	-o $@ ${LIBS}
prtwf7 : ${OBJS2} prtwf7.o
	${FC}  ${OPTS} ${FFLAGS} ${LDFLAGS} ${OBJS2} prtwf7.o	-o $@ ${LIBS}


calc_wannier3.o: cubeformat.o xsfformat2.o 
calc_wannier4.o: cubeformat.o xsfformat2.o 
calc_wannier5.o: cubeformat.o xsfformat2.o  keyvalue.o 
calc_wannier6.o: cubeformat.o xsfformat2.o  keyvalue.o 

cubeformat.o m_cubeformat.mod : cubeformat.F
expand_mesh.o m_expand_mesh.mod: expand_mesh.F
keyvalue.o keyvalue.mod: keyvalue.F
m_DATA4GW.o m_DATA4GW.mod: m_DATA4GW.F
m_FFT3D.o m_FFT3D.mod: m_FFT3D.F
m_LMTO.o m_LMTO.mod: m_LMTO.F
m_MLWF.o m_MLWF.mod: m_MLWF.F
m_QG.o m_QG.mod: m_QG.F
wfnrho_abc.o m_wfrho_abc.mod: wfnrho_abc.F
xsfformat2.o m_xsfformat.mod: xsfformat2.F

m_LMTO.o:       m_DATA4GW.mod m_QG.mod m_LMTO.F
	${FC} ${OPTS} ${FFLAGS}  -c m_LMTO.F

m_MLWF.o:       m_DATA4GW.mod m_QG.mod m_MLWF.F
	${FC} ${OPTS} ${FFLAGS}  -c m_MLWF.F

prtwf7.o:       keyvalue.mod m_FFT3D.mod m_LMTO.mod \
 m_MLWF.mod m_cubeformat.mod m_expand_mesh.mod \
 m_wfrho_abc.mod m_xsfformat.mod prtwf7.F
	${FC} ${OPTS} ${FFLAGS}  -c prtwf7.F

wfnrho2.o:       m_FFT3D.mod    m_LMTO.mod wfnrho2.F
	${FC} ${OPTS} ${FFLAGS}  -c wfnrho2.F

wfnrho_abc.o:       m_FFT3D.mod       m_LMTO.mod wfnrho_abc.F
	${FC} ${OPTS} ${FFLAGS}  -c wfnrho_abc.F 


clean :
	rm -f *.o  ${PROGS} *.mod

.SUFFIXES: .F
.F.o   :
	${FC} ${OPTS} ${FFLAGS} $< -c
