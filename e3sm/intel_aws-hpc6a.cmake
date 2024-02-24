string(APPEND CFLAGS " -march=core-avx2 -mtune=core-avx2 -no-fma")
string(APPEND CPPDEFS " -DLINUX -DNO_SHR_VMATH -DFORTRANUNDERSCORE")
if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_NANOTIME -DBIT64 -DHAVE_VPRINTF -DHAVE_BACKTRACE -DHAVE_SLASHPROC -DHAVE_COMM_F2C -DHAVE_TIMES -DHAVE_GETTIMEOFDAY")
endif()
string(APPEND FFLAGS " -fp-model consistent -fimf-use-svml")
if (NOT DEBUG)
  string(APPEND FFLAGS " -qno-opt-dynamic-align")
endif()
string(APPEND FFLAGS " -march=core-avx2 -mtune=core-avx2 -no-fma")
set(HDF5_PATH "/opt/ncar/software")
set(MPI_LIB_NAME "impi")
set(NETCDF_PATH "/opt/ncar/software")
set(PNETCDF_PATH "/opt/ncar/software")
string(APPEND SLIBS " -L/opt/ncar/software/lib -lnetcdf -lnetcdff -lpnetcdf -lblas -llapack -lpthread")
