
LINK_LIBRARIES(
	atombase
	atomspaceutils
	atomspace
)

IF(HAVE_GUILE)
	ADD_CXXTEST(AtomTableUTest)
	TARGET_LINK_LIBRARIES(AtomTableUTest smob clearbox)
ENDIF(HAVE_GUILE)

ADD_CXXTEST(AtomUTest)
ADD_CXXTEST(NodeUTest)
ADD_CXXTEST(LinkUTest)
ADD_CXXTEST(TLBUTest)
ADD_CXXTEST(HashMixUTest)
ADD_CXXTEST(AtomSpaceUTest)
ADD_CXXTEST(AtomSpaceAsyncUTest)
ADD_CXXTEST(UseCountUTest)
ADD_CXXTEST(MultiSpaceUTest)
ADD_CXXTEST(COWSpaceUTest)
ADD_CXXTEST(RemoveUTest)

# The ValuationTable is no longer used or even built, so don't test it.
# ADD_CXXTEST(ValuationTableUTest)
