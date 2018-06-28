/*
 * opencog/atomspace/ProtocolBufferSerializer.h
 *
 * Copyright (C) 2008-2015 OpenCog Foundation
 * All Rights Reserved
 *
 * Written by Erwin Joosten, Hendy Irawan <ceefour666@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License v3 as
 * published by the Free Software Foundation and including the exceptions
 * at http://opencog.org/wiki/Licenses
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program; if not, write to:
 * Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

//TODO move this file to the persist directory

#ifndef _OPENCOG_PROTOCOLBUFFER_SERIALIZER_H
#define _OPENCOG_PROTOCOLBUFFER_SERIALIZER_H

#include <memory>
#include <string>

#include <opencog/atoms/base/Atom.h>
#include <opencog/truthvalue/AttentionValue.h>
#include <opencog/atoms/base/Handle.h>
#include <opencog/atoms/base/Link.h>
#include <opencog/atoms/base/Node.h>
#include <opencog/truthvalue/DistributionalValue.h>
#include <opencog/atoms/base/types.h>
#include "opencog/persist/zmq/atomspace/ZMQMessages.pb.h"

using namespace std;

namespace opencog {
/** \addtogroup grp_atomspace
 *  @{
 */

class ProtocolBufferSerializer {
    static void deserializeAtom(const ZMQAtomMessage& atomMessage, Atom& atom);
//    static void serializeAtom(Atom& atom, ZMQAtomMessage* atomMessage);

//    static void deserializeAttentionValue(
//            const ZMQAttentionValueHolderMessage &attentionValueHolderMessage,
//            AttentionValue& av);
//    static void serializeAttentionValue(
//            AttentionValue& av, ZMQAttentionValueHolderMessage* attentionValueHolderMessage);
//    static void deserializeAttentionValueHolder(
//            const ZMQAttentionValueHolderMessage& attentionValueHolderMessage,
//            AttentionValueHolder& attentionValueHolder);
//    static void serializeAttentionValueHolder(
//            AttentionValueHolder& attentionValueHolder,
//            ZMQAttentionValueHolderMessage *attentionValueHolderMessage);

    static NodePtr deserializeNode(const ZMQAtomMessage& atomMessage);
    static LinkPtr deserializeLink(const ZMQAtomMessage& atomMessage);
//    static void serializeLink(Link& link, ZMQAtomMessage *atomMessage);
//    static void deserializeNode(const ZMQAtomMessage& atomMessage, Node& node);
//    static void serializeNode(Node& node, ZMQAtomMessage *atomMessage);

    static DistributionalValuePtr deserialize(
            const ZMQSingleTruthValueMessage& singleTruthValueMessage);

public:
    ProtocolBufferSerializer();
    ~ProtocolBufferSerializer();

    static AtomPtr deserialize(const ZMQAtomMessage& atomMessage);
//    static void serialize(Atom &atom, ZMQAtomMessage* atomMessage);

    static DistributionalValuePtr deserialize(const ZMQTruthValueMessage& truthValueMessage);
    static void serialize(DistributionalValue &tv, ZMQTruthValueMessage* truthValueMessage);
};

/** @}*/
} // namespace opencog

#endif // _OPENCOG_PROTOCOLBUFFER_SERIALIZER_H
