include ./Makefile.cfg

DIR_ENTRY	=	main

SUBDIRS = $(DIR_MAIN)/$(DIR_ENTRY) 

all: $(SUBDIRS)
	for subdir in $(SUBDIRS); do (cd $${subdir}; $(MAKE) $@); done 

run:
ifeq ($(PARALLEL), 1)
	qsub run.sh -q opt.q
else
	./$(EXE_NAME)
endif

clean:
	for subdir in $(SUBDIRS); do (cd $${subdir}; $(MAKE) $@); done
	$(RM) *~ 
	$(RM) traj.*

cleanall: clean
	for subdir in $(SUBDIRS); do (cd $${subdir}; $(MAKE) $@); done
	$(RM) $(EXE_NAME)
	$(RM) dat/*.dat
	$(RM) LOG
	$(RM) ana/dat/*~
	$(RM) ana/plot/*~
	$(RM) ana/plot/*.pyc
	$(RM) ana/proc/app
	$(RM) doc/*~

commit: cleanall
	$(RM) ana/dat/*.dat
	$(RM) ana/dat/*~
	$(RM) ana/rank.info
	git add .
	git commit -a -m "Enhancement of the analysis module."
	git push origin master