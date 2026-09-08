# Structured Use Cases for SysML v2

Structured Use Cases is an open-source project developing an alternative
use case library for SysML v2.

The project addresses two complementary objectives:

1.  Standardize structured use case specifications consisting of basic,
    alternate, and exception scenarios composed of ordered steps.
2.  Provide a simpler and more natural approach to use case diagrams
    while retaining compatibility with SysML v2.

The Structured Use Cases Library is also being developed as a proposed
alternative standard use case library for consideration by the Object
Management Group (OMG).

## Why Structured Use Cases?

The primary engineering value of use case modeling resides in the use
case specifications, not in the diagrams.

A use case specification describes system behavior through:

-   a basic scenario describing expected behavior,
-   alternate scenarios describing valid variations,
-   exception scenarios describing off-nominal or failure behavior, and
-   ordered steps describing the interactions that make up each
    scenario.

Systematically exploring alternate and exception scenarios helps
engineers discover requirements that are easily missed when analysis
focuses primarily on nominal behavior.

Structured scenarios are also deliberately human-facing engineering
artifacts. They provide a straightforward way for systems engineers to
work with subject matter experts while retaining enough semantic
structure for model-based analysis, interchange, automation, and
testing.

## Native SysML v2 Semantics

The Structured Use Cases Library extends native SysML v2 concepts rather
than creating a parallel modeling language.

-   A `StructuredUseCase` remains a native SysML v2 `UseCase`.
-   A `UseCaseScenario` remains a native SysML v2 `Action`.
-   A `UseCaseStep` remains a native SysML v2 `Action`.
-   Preconditions and postconditions remain native SysML v2
    `Constraints`.
-   Standard SysML v2 successions define behavioral ordering.
-   Semantic metadata identifies the structured-use-case roles of these
    native model elements.

This allows ordinary SysML v2 tools to recognize the underlying model
elements while tools that understand the Structured Use Cases Library
can provide specialized structured-use-case behavior.

## Basic, Alternate, and Exception Scenarios

Structured Use Cases explicitly distinguish three kinds of scenarios:

**Basic scenarios** describe the normal or expected path through a use
case.

**Alternate scenarios** describe legitimate variations from the basic
path.

**Exception scenarios** describe off-nominal behavior such as failures,
errors, and exceptional conditions.

This distinction is important because many significant requirements are
discovered by asking what can go wrong and determining how the system
should respond.

## Human-Readable Specifications

Structured use cases are intended to support engineering conversations
as well as machine processing.

Scenario and step identifiers such as `6A`, `6A.1`, `3E`, and `3E.2`
provide a simple vocabulary for reviews, discussions, documentation,
testing, and change management.

Behavioral ordering is represented independently using SysML v2
successions, allowing authoring tools to automatically renumber
human-readable identifiers without changing the underlying behavioral
semantics.

## Use Case-Driven Testing

Structured Use Cases also provide a foundation for use-case-driven
testing.

The Structured Testing Library follows the same extension philosophy as
the Structured Use Cases Library:

**SysML v2 `UseCase` → `StructuredUseCase`**\
**SysML v2 `VerificationCase` → `StructuredTestCase`**

In both cases, the proposed library specializes a standard SysML v2
concept rather than replacing it. This preserves native SysML v2
semantics while adding the structure needed for detailed scenario
modeling and behavioral verification.

The Structured Testing Library introduces:

-   `StructuredTestCase`
-   `TestScenario`
-   `TestStep`
-   `VerifyUseCase`
-   `VerifyScenario`

These concepts complement native SysML v2 requirement verification by
allowing tests to be associated directly with complete use cases and
individual use case scenarios.

This is especially important for alternate and exception scenarios.

**The biggest problem with testing is when the off-nominal scenarios are
not tested.**

Making these relationships explicit allows behavioral test coverage to
become traceable and queryable.

### Use Case Thread Expansion

Because scenarios, steps, branch points, rejoin behavior, and
postconditions are explicit model elements, tools can systematically
derive complete behavioral threads from a Structured Use Case.

Each thread represents a complete path through the use case, combining
the appropriate basic, alternate, and exception behavior. These threads
provide a model-derived basis for answering an important verification
question:

**Have we tested every behavioral thread represented by the use case
specification?**

Modern AI coding agents can also use these structured specifications and
expanded behavioral threads to generate assertion tests and end-to-end
behavioral tests.

## Queryable Engineering Information

Representing structured use case specifications as explicit model
semantics enables engineering questions that are difficult to answer
reliably when use cases exist only as narrative documents.

For example:

-   Which use cases have no alternate or exception scenarios?
-   Which steps have no alternate or exception analysis?
-   Which scenarios have no postcondition?
-   Which alternate or exception scenarios have no corresponding test?
-   Which use cases contain the largest concentrations of exception
    behavior?
-   Have all behavioral threads represented by a use case been tested?

The objective is not simply to replace textual use case documents with
formal notation.

The objective is to turn the behavioral knowledge contained in those
specifications into machine-processable engineering information that can
support requirements analysis, verification, traceability, automation,
and AI-assisted engineering.

## OMG Proposal

The current proposal recommends that OMG adopt the Structured Use Cases
Library as an alternative standard use case library for SysML v2.

The proposal requires no change to the SysML v2 grammar. It uses SysML
v2 specialization, semantic metadata, and standard behavioral semantics
to provide the additional structured-use-case concepts.

**Current proposal: Structured Use Cases OMG Proposal Draft v0.9**

The proposal document in this repository provides the complete
motivation, metamodel, SysML v2 library definitions, examples, testing
extensions, and model-query concepts.

## Open-Source Reference Implementation

A reference Structured Use Case Editor has been developed to demonstrate
and exercise the proposed library.

The editor provides a human-oriented environment for creating use case
diagrams and detailed structured specifications while generating SysML
v2 textual notation for downstream MBSE tools.

Hosted editor:

[Structured Use Case
Editor](https://parallelagile.com/structured-use-cases/)

Editor source:

[OpenMBEE Structured Use Case Editor
repository](https://github.com/Open-MBEE/structured-usecase-editor)

The editor is maintained as a separate OpenMBEE project so that this
repository can remain focused on the Structured Use Cases libraries,
proposal, examples, and standardization effort.

## Project Goals

The Structured Use Cases project is intended to:

-   improve requirements discovery through systematic exploration of
    off-nominal behavior,
-   standardize structured use case specifications,
-   simplify use case diagramming,
-   preserve native SysML v2 semantics,
-   improve model interchange,
-   enable use-case-driven behavioral testing,
-   make behavioral coverage queryable,
-   support model-based automation and AI-assisted engineering, and
-   provide an open environment for experimentation and community
    feedback.

## Participate

Structured Use Cases is an open-source OpenMBEE project.

We welcome participation from systems engineers, software engineers,
tool vendors, researchers, SysML practitioners, and OMG participants
interested in improving use case modeling in SysML v2.

Issues, examples, implementation experiments, and technical feedback are
welcome.

The goal is straightforward:

**Make use case modeling simpler for humans, more rigorous for machines,
and more useful for engineering.**
