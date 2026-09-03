# Structured Use Cases for SysML v2

**A simpler, structured approach to use case modeling in SysML v2.**

Structured Use Cases is an open-source SysML v2 library proposal for describing system behavior using structured use case specifications composed of scenarios and ordered steps.

The goal is to make use cases easier to write, easier to understand, and more useful for requirements discovery, behavioral test generation, model-based analysis, automation, and AI-assisted engineering.

## Companion Project

This repository focuses on the Structured Use Cases SysML v2 library proposal and supporting examples.

The companion **Structured Use Case Editor** provides an open-source reference implementation for creating structured use case diagrams and specifications, saving Use Case Model JSON files, and exporting SysML v2 textual notation.

Editor repository:

https://github.com/Open-MBEE/structured-usecase-editor

Hosted editor:

https://parallelagile.com/structured-use-cases/

## Current Release - v0.8

Version 0.8 updates the proposal with example query results from a small account management structured use case model imported to Cameo using SysML v2.

The v0.8 proposal demonstrates that structured use cases can provide benefits beyond documentation. When detailed use case behavior is represented as explicit SysML v2 model semantics, it becomes queryable engineering information that can support model-quality checks, requirements discovery, traceability, behavioral testing, automated transformations, and AI-assisted engineering workflows.

Current proposal:

- `docs/Structured_Use_Cases_OMG_Proposal_Draft_v0.8.pdf`

The PDF is the recommended review copy.

This repository includes:

- the current Structured Use Cases proposal in `docs/`,
- the Structured Use Cases SysML v2 library in `library/`,
- a detailed ATM structured use case example,
- a reusable actor example,
- named use-case-to-use-case connection examples,
- supporting images and documentation.

## Why Structured Use Cases?

The primary engineering value of use case modeling resides in the use case specification, not in the use case diagram.

Use case diagrams are useful because they give engineers, stakeholders, and subject matter experts a simple way to see system functionality organized around actors and goals. However, the diagram is only the entry point. The detailed behavioral specification is where engineers discover missing requirements, identify off-nominal behavior, define expected outcomes, and create a basis for verification.

A structured use case specification describes system behavior as a set of scenarios:

- **Basic scenarios** describe the nominal behavior.
- **Alternate scenarios** describe valid variations from the nominal behavior.
- **Exception scenarios** describe failures, errors, and other off-nominal behavior.

Explicitly modeling alternate and exception behavior helps expose requirements that may be missed when analysis focuses only on the happy path.

These structured scenarios also provide a natural foundation for behavioral testing because each scenario describes a path through the system and can define its own expected outcome.

## The Structured Use Case Model

The Structured Use Cases library represents structured use case behavior using native SysML v2 concepts rather than creating a separate behavioral language.

![Structured Use Cases SysML v2 Model](images/StructuredUseCases.jpg)

At the center of the model is a simple behavioral structure:

**Use Case -> Scenario -> Step**

A structured use case is a SysML v2 use case. Scenarios and steps use SysML v2 action semantics. Preconditions and postconditions use SysML v2 constraint semantics. Semantic metadata identifies the structured-use-case roles of model elements, including structured use cases, basic scenarios, alternate scenarios, exception scenarios, steps, preconditions, postconditions, and use case actors.

Each structured use case can contain:

- one **Basic Scenario**,
- zero or more **Alternate Scenarios**,
- zero or more **Exception Scenarios**.

Each scenario contains ordered steps describing behavior. Standard SysML v2 successions define behavioral ordering, so ordering is represented through model semantics rather than through custom properties or prose alone.

Scenarios can also define their own postconditions. This matters because different behavioral paths may terminate in different valid system states.

Human-readable scenario and step identifiers are retained for review and communication. Identifiers such as `4A` or `4A.2` are useful during engineering discussions, while the underlying model keeps the semantic identity and ordering information needed by tools.

## Why Alternate and Exception Scenarios Matter

The normal path through a system is usually the easiest behavior to identify.

Many missing requirements are found by asking:

**What else can happen?**

Alternate scenarios describe legitimate variations in behavior. Exception scenarios describe failures and other off-nominal conditions. Making those scenarios explicit helps engineers identify behavior that might otherwise remain unspecified until implementation, integration, or testing.

This is one of the primary motivations behind Structured Use Cases: use cases should help discover requirements, not merely document requirements that have already been found.

Once off-nominal behavior is explicitly modeled, it can also support requirements extraction. For example, an authentication failure exception scenario can lead directly to a candidate requirement for handling authentication failure, while the scenario remains the authoritative behavioral specification of what that handling requires.

## Example: ATM Cash Withdrawal

The repository includes a detailed ATM example in:

`examples/WithdrawCash_ATM_Example.sysml`

![Withdraw Cash ATM structured use case example](images/WithdrawCash_ATM_Example.jpg)

The **Withdraw Cash from ATM** use case demonstrates:

- a basic successful-withdrawal scenario,
- alternate behavior such as cancelling a withdrawal or entering a smaller amount,
- exception behavior such as authentication failure,
- ordered steps using SysML v2 successions,
- branch points represented by named successions,
- narrative rejoin steps,
- a use-case-level precondition,
- scenario-specific postconditions.

The example illustrates an important principle: a use case step does not need to be limited to a system action. Steps may describe observable actor behavior, system behavior, or interaction between the actor and the system.

## From Use Cases to Tests

Structured use cases provide more than documentation.

Because behavior is explicitly organized into scenarios, steps, branches, rejoins, and outcomes, the model can be traversed to derive complete behavioral threads.

The resulting engineering chain is:

**Use Cases -> Scenarios -> Steps -> Behavioral Threads -> Tests**

Alternate and exception scenarios are especially valuable because they expose off-nominal behavior that often produces defects when it has not been specified or tested.

Scenario-specific postconditions also provide natural assertions for behavioral testing. After executing a behavioral thread, the resulting system state can be checked against the expected postcondition.

The proposal describes a conceptual **Use Case Thread Expander** that systematically traverses modeled use case behavior to identify the complete end-to-end threads that should be considered during testing.

## Queryable Engineering Information

Once detailed use case behavior is represented as explicit model semantics rather than embedded only in prose, it becomes queryable engineering information.

Version 0.8 includes example query results produced from a small account management structured use case model imported to Cameo using SysML v2.

The example queries show how structured use case semantics can be used to:

1. identify exception hotspots,
2. evaluate off-nominal analysis coverage,
3. identify candidate requirements from alternate and exception behavior.

The proposal also describes additional query opportunities, including:

1. finding use cases with no alternate or exception scenarios,
2. finding scenarios without postconditions,
3. expanding a use case into its complete set of behavioral threads,
4. tracing requirements through use case behavior to verification.

These examples only scratch the surface. The broader opportunity is that the same structured behavioral semantics can support validation rules, model-quality checks, automated transformations, AI agents, test generators, and other engineering tools without changing the underlying use case specification.

## More Permissive Use Case Diagrams

Structured Use Cases focuses engineering attention on the detailed specification without unnecessarily restricting familiar use case diagrams.

The library provides a reusable `UseCaseActor` identified through semantic metadata rather than requiring every actor relationship to be forced through a specialized actor-parameter mechanism.

The repository includes:

`examples/ReusableActor_Example.sysml`

![Reusable actor connected to multiple structured use cases](images/ReusableActor_Example.jpg)

This example demonstrates one reusable actor connected to multiple structured use cases.

The repository also includes:

`examples/UseCaseConnections_Example.sysml`

![Named connections between structured use cases](images/UseCaseConnections_Example.jpg)

This example demonstrates simple named connections between structured use cases, including:

- `include`,
- `extend`,
- `invoke`,
- `precede`.

The intent is not to prescribe a closed set of formal relationship names. It is to demonstrate that structured use cases can participate in lightweight, familiar use case diagrams while their detailed behavioral specifications provide the primary engineering value.

## What's in This Repository?

The repository contains:

- the Structured Use Cases SysML v2 library,
- the current v0.8 proposal,
- a detailed ATM structured use case example,
- a reusable-actor example,
- a use-case-connections example,
- supporting images and documentation,
- material supporting requirements discovery, behavioral testing, model queries, automation, and AI-assisted engineering.

## Getting Started

1. Clone or download this repository.
2. Review `library/StructuredUseCases_Library.sysml`.
3. Open `examples/WithdrawCash_ATM_Example.sysml` to see a detailed structured use case.
4. Review `examples/ReusableActor_Example.sysml` to see one actor connected to multiple use cases.
5. Review `examples/UseCaseConnections_Example.sysml` to see named connections between use cases.
6. Read the current v0.8 proposal in `docs/` for the motivation, library design, testing approach, query examples, and conclusions.
7. Create your own structured use case with a basic scenario, then ask what alternate and exception behavior should also be modeled.

## Repository Structure

```text
structured-use-cases/
├── README.md
├── LICENSE
├── library/
│   └── StructuredUseCases_Library.sysml
├── examples/
│   ├── WithdrawCash_ATM_Example.sysml
│   ├── ReusableActor_Example.sysml
│   └── UseCaseConnections_Example.sysml
├── images/
└── docs/
    ├── Structured_Use_Cases_OMG_Proposal_Draft_v0.8.pdf
    └── supporting documentation
```

## Design Philosophy

Structured Use Cases is guided by several principles:

- **Keep use case modeling simple.**
- **Build on native SysML v2 semantics rather than creating a parallel modeling language.**
- **Put behavioral detail in the specification.**
- **Use diagrams primarily for organization, communication, and navigation.**
- **Explicitly model alternate and exception behavior.**
- **Use scenarios to discover missing requirements.**
- **Make specifications directly useful for behavioral testing.**
- **Make modeled behavior available for queries, automation, and analysis.**
- **Support AI-assisted engineering workflows.**
- **Improve the value-to-pain ratio of use case modeling.**

The intent is not to reinvent structured use cases. Structured scenarios have been used successfully in industry for decades.

The goal is to provide a simple semantic representation suitable for the SysML v2 ecosystem while preserving the practical engineering value of detailed use case specifications.

## Project Status

Structured Use Cases is under active development and evaluation.

Version 0.8 reflects continued testing and refinement of the library architecture, including native SysML v2 use case and action semantics, semantic metadata, reusable actors, behavioral ordering with successions, scenario-specific postconditions, permissive use case connections, Cameo import testing, and example semantic queries.

The project provides a practical environment for:

- library validation,
- tool interoperability testing,
- development of examples,
- requirements-discovery experiments,
- behavioral test-generation experiments,
- model queries and automation,
- AI-assisted engineering experiments,
- community feedback.

The approach is being developed as a proposal for the SysML v2 ecosystem.

## Contributing

Feedback and experimentation are welcome.

Useful contributions include:

- testing the library with different SysML v2 tools,
- reporting interoperability issues,
- contributing structured use case examples,
- suggesting improvements to the library,
- experimenting with requirements discovery,
- experimenting with behavioral test generation,
- developing useful queries over structured use case models,
- providing feedback on the Structured Use Cases proposal.

Please use GitHub Issues to report problems, suggest improvements, or share results.

## License

See the `LICENSE` file for licensing information.

## About Structured Use Cases

Structured Use Cases is an open-source effort to make use case modeling simpler, more rigorous, and more useful throughout the systems and software engineering lifecycle.

Its central idea is deliberately simple:

**Describe what normally happens. Describe what else can happen. Describe what can go wrong. Then test all of it.**
