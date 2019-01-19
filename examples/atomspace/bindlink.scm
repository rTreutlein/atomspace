;
; bindlink.scm
;
; A common task in knowledge representation systems is searching and
; querying for data, and then re-shaping the query results into a new
; form. In Atomese, querying and graph-rewriting is done with the
; BindLink atom. The BindLink uses "pattern matching" to find subgraphs
; in the atomspace that match the query, and then creates a new graph
; with those results in them.
;
; Because BindLink performs graph re-writing, it resembles logical
; implication `P->Q`, that is an if-then statement, `IF P THEN Q`.
; However, since it can match a pattern, it is more more like
; an implication with a variable in it, so: `P(x)->Q(x)`.  Since it
; searches all of the atomspace, it is effectively adding a "for all x"
; to the implication, so that it states `ForAll x, P(x)->Q(x)` (with
; "x" beig a bound variable).  In this way, the BindLink can represent
; a very basic form of implication or logical inference.
;
; Unlike most query languages (SQL, etc.) atomese queries are stored
; in the Atomspace itself, as graphs. Thus BindLink is just another
; link type. It is stored in the Atomspace, along with everything else.
;
; This example places some typical "semantic triple" natural-language
; style data in the Atomspace, and then defines a query, build from
; BindLink, to perform some "basic inference" on that data.
;
; The example data says that one can "make pottery" and that things
; are "made from clay". The resulting inference is that "pottery is
; made from clay":
;
; (SetLink
;     (Evaluation (Predicate "make_from")
;         (ListLink (Concept "pottery") (Concept "clay"))))
;
; The SetLink wraps the collection of results; ther is only one result,
; in this case.


(use-modules (opencog) (opencog query) (opencog exec))

; Place some data in the atomspace to work with. Its some very basic
; natural-language dependency grammar parse data.
;
; A dependency "_obj(make, pottery)" from a dependency parse of the
; sentence "Susan makes pottery": so that "make" is the verb (a
; transtive verb), and "pottery" is the object of that verb.
;
(Evaluation
	(Predicate "_obj")
	(ListLink
		(Concept "make")
		(Concept "pottery")))

; A prepositional dependency "from(make, clay)".  Here "from" is the
; preposition, one of a closed set of possible prepositions, stating
; that this can be made from clay. This might occur in the parse of
; "George makes scupltures from clay".
;
(Evaluation
	(Predicate "from")
	(ListLink
		(Concept "make")
		(Concept "clay")))

; Create a "semantic triple" by combining a verb, an object and a
; preposition. This searches the atomsace for a verb-object pair,
; and a verb-preposition pair, and if it finds them, creates a triple.
;
; It encodes the IF
;
(define make-semantic-triple
	(BindLink
		(VariableList   ; Variable declaration (optional)
			(Variable "$var0")
			(Variable "$var1")
			(Variable "$verb")
		)

		; The premise of the implication is wrapped by an AndLink.
		; This means that each of the clauses must be satisfied in
		; the atomspace. In SQL terms, this is an "inner join".
		(AndLink
			; Look for _obj($verb, $var0)
			(Evaluation
				(Predicate "_obj")
				(ListLink
					(Variable "$verb") ; This will match: (Concept "make")
					(Variable "$var0") ; This will match: (Concept "pottery")
				)
			)
			; Look for from($verb, $var1)
			(EvaluationLink
				(Predicate "from")
				(ListLink
					(Variable "$verb") ; This will match: (Concept "make")
					(Variable "$var1") ; This will match: (Concept "clay")
				)
			)
		)
		; Combine the two above into one.
		(EvaluationLink
			(PredicateNode "make_from")
			(ListLink
				(VariableNode "$var0")
				(VariableNode "$var1")
			)
		)
	)
)

; Run the pattern matcher. This matches both required clauses,
; and creates a set of all matching results.
(cog-execute! make-semantic-triple)

; The following should have been printed:
;
; (SetLink
;     (Evaluation (Predicate "make_from")
;         (ListLink (Concept "pottery") (Concept "clay"))))
;
