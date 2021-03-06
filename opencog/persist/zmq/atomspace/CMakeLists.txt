# The atom_types.h file is written to the build directory
INCLUDE_DIRECTORIES (
	${CMAKE_BINARY_DIR}
	${PROTOBUF_INCLUDE_DIR}
)

# Generate the .pb.h and .pb.cc files dynamically.
ADD_CUSTOM_COMMAND(
	OUTPUT ZMQMessages.pb.h ZMQMessages.pb.cc
	COMMAND ${PROTOBUF_PROTOC_EXECUTABLE}
	ARGS --cpp_out=. -I ${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_SOURCE_DIR}/ZMQMessages.proto
	DEPENDS ZMQMessages.proto
	COMMENT "Serializing with protobuf"
)

ADD_LIBRARY (zmqatoms
	ZMQMessages.pb.cc ZMQMessages.pb.h
	ProtocolBufferSerializer
	ZMQClient
	ZMQPersistSCM
)

TARGET_LINK_LIBRARIES(zmqatoms
	zmq
	atomspaceutils
	atombase
	truthvalue
	${COGUTIL_LIBRARY}
	${PROTOBUF_LIBRARY}
)


IF(HAVE_GUILE)
	TARGET_LINK_LIBRARIES(zmqatoms smob)
ENDIF(HAVE_GUILE)

INSTALL (TARGETS zmqatoms EXPORT AtomSpaceTargets
	DESTINATION "lib${LIB_DIR_SUFFIX}/opencog"
)

INSTALL (FILES
	${CMAKE_CURRENT_BINARY_DIR}/ZMQMessages.pb.h
	ProtocolBufferSerializer.h
	ZMQClient.h
	ZMQPersistSCM.h
	DESTINATION "include/opencog/persist/zmq/atomspace"
)
