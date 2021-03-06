
# This file reads files that are generated by the OPENCOG_ADD_ATOM_TYPES
# macro so they can be imported using:
#
# from type_constructors import *
#
# This imports all the python wrappers for atom creation.
#

from opencog.atomspace import (createFloatValue, createLinkValue,
                                createStringValue, createTruthValue)
from opencog.atomspace import AtomSpace, types

atomspace = None
def set_type_ctor_atomspace(new_atomspace):
    global atomspace
    atomspace = new_atomspace

def get_type_ctor_atomspace():
    global atomspace
    return atomspace

include "opencog/atoms/atom_types/core_types.pyx"

def FloatValue(arg):
    return createFloatValue(arg)

def LinkValue(arg):
    return createLinkValue(arg)

def StringValue(arg):
    return createStringValue(arg)

def TruthValue(strength=1.0, confidence=1.0):
    return createTruthValue(strength, confidence)
