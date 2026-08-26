library package StructuredUseCases {

    doc /*
     * Simple / Structured Use Case Specification Library
     * Working Draft v0.2
     *
     * Design principles
     * -----------------
     * This library extends native SysML v2 semantics rather than creating
     * a parallel vocabulary from generic structural elements.
     *
     *   - A StructuredUseCase is a native SysML UseCase.
     *   - A UseCaseScenario is a native SysML Action.
     *   - A UseCaseStep is a native SysML Action.
     *   - A precondition or postcondition is a native SysML Constraint.
     *
     * Semantic metadata adds structured-use-case meaning while preserving
     * the underlying SysML element type.
     *
     * Behavioral order is defined by standard SysML successions.
     * Human-readable scenarioId and stepId values support review,
     * navigation, discussion, documentation, and automatic renumbering
     * by use-case authoring tools.
     *
     * A single precondition applies to the complete use case.
     * Each scenario has its own postcondition because different behavioral
     * paths may terminate in different valid system states.
     *
     * Branch and rejoin behavior is expressed directly in the scenario
     * narrative as ordinary UseCaseSteps, rather than through separate
     * reference properties.
     */

    private import ScalarValues::String;
    private import Actions::Action;
    private import Actions::actions;
    private import Constraints::ConstraintCheck;
    private import Constraints::constraintChecks;
    private import UseCases::UseCase;
    private import UseCases::useCases;
    private import Metaobjects::SemanticMetadata;
    private import Parts::Part;
    private import Parts::parts;


    // ================================================================
    // Semantic foundation
    // ================================================================


    // ----------------------------------------------------------------
    // Use Case Step
    // ----------------------------------------------------------------
    //
    // A UseCaseStep is the smallest ordered unit in a structured
    // scenario narrative.
    //
    // A step may describe actor behavior, system behavior, or
    // scenario-control behavior such as:
    //
    //   "Branch after Step 6"
    //   "Rejoin before Step 6"
    //   "Rejoin after Step 9"
    //
    // It specializes Action so that the step remains a native SysML
    // behavioral element.
    //
    // stepId is human-readable presentation/navigation information.
    // It does NOT define behavioral order; successions do that.
    //
    action def UseCaseStep :> Action {

        attribute stepId : String[1];
    }

    abstract action useCaseSteps : UseCaseStep[0..*] nonunique
        :> actions;


    // ----------------------------------------------------------------
    // Scenario Postcondition
    // ----------------------------------------------------------------
    //
    // A scenario-specific expected outcome. Separate postconditions are
    // important because nominal, alternate, and exception paths can end
    // in different valid states.
    //
    constraint def UseCasePostcondition :> ConstraintCheck;

    abstract constraint useCasePostconditions :
        UseCasePostcondition[0..*] nonunique
        :> constraintChecks;


    // ----------------------------------------------------------------
    // Use Case Scenario
    // ----------------------------------------------------------------
    //
    // A UseCaseScenario is one behavioral path through a structured
    // use case.
    //
    // Basic, alternate, and exception scenarios intentionally share this
    // single semantic definition. Their distinction is classification,
    // not structure.
    //
    action def UseCaseScenario :> Action {

        // Human-readable scenario identifier, e.g. "B", "6A", "3E".
        attribute scenarioId : String[1];


        // A scenario contains zero or more UseCaseSteps as native SysML
        // subactions.
        action steps : UseCaseStep[0..*]
            :> subactions, useCaseSteps;


        // Each scenario owns its own postcondition.
        constraint postcondition : UseCasePostcondition[0..1]
            :> useCasePostconditions;
    }

    abstract action useCaseScenarios : UseCaseScenario[0..*] nonunique
        :> actions;


    // ----------------------------------------------------------------
    // Scenario classifications
    // ----------------------------------------------------------------
    //
    // These abstract usages provide distinct semantic categories for
    // metadata binding while retaining one common UseCaseScenario type.
    //
    abstract action basicScenarios :
        UseCaseScenario[0..*] nonunique
        :> useCaseScenarios;

    abstract action alternateScenarios :
        UseCaseScenario[0..*] nonunique
        :> useCaseScenarios;

    abstract action exceptionScenarios :
        UseCaseScenario[0..*] nonunique
        :> useCaseScenarios;


    // ----------------------------------------------------------------
    // Use Case Precondition
    // ----------------------------------------------------------------
    //
    // One precondition applies to the structured use case as a whole.
    //
    constraint def UseCasePrecondition :> ConstraintCheck;

    abstract constraint useCasePreconditions :
        UseCasePrecondition[0..*] nonunique
        :> constraintChecks;


    // ----------------------------------------------------------------
    // Structured Use Case
    // ----------------------------------------------------------------
    //
    // StructuredUseCase specializes the native SysML UseCase.
    //
    // Scenario multiplicities belong here:
    //
    //   basicScenario       0..1
    //   alternateScenario   0..*
    //   exceptionScenario   0..*
    //
    use case def StructuredUseCase :> UseCase {

        action basicScenario : UseCaseScenario[0..1]
            :> subactions, basicScenarios;

        action alternateScenario : UseCaseScenario[0..*]
            :> subactions, alternateScenarios;

        action exceptionScenario : UseCaseScenario[0..*]
            :> subactions, exceptionScenarios;


        // One use-case-level precondition.
        constraint precondition : UseCasePrecondition[0..1]
            :> useCasePreconditions;
    }

    abstract use case structuredUseCases :
        StructuredUseCase[0..*] nonunique
        :> useCases;




    // ================================================================
    // Diagram Actor
    // ================================================================
    //
    // A Structured Use Cases Actor is a reusable, external participant
    // that can be connected to any number of use cases on a use case
    // diagram.
    //
    // This is deliberately NOT the native SysML v2 use-case "actor"
    // parameter mechanism. The purpose is to restore the familiar
    // first-class diagram actor used in traditional use case modeling.
    //
    part def UseCaseActor :> Part;

    abstract part useCaseActors : UseCaseActor[0..*] nonunique
        :> parts;


    // ================================================================
    // Semantic metadata and user-defined keywords
    // ================================================================



    // ----------------------------------------------------------------
    // #useCaseActor
    // ----------------------------------------------------------------
    //
    // Identifies a reusable external use-case Actor.
    //
    // The Actor is deliberately represented as a reusable structural
    // participant rather than as a native SysML v2 actor parameter
    // owned by an individual use case.
    //
    metadata def <useCaseActor>
        UseCaseActorMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::PartDefinition;
        :> annotatedElement : SysML::PartUsage;
        :>> baseType =
            useCaseActors meta SysML::Usage;
    }


    metadata def <structuredUseCase>
        StructuredUseCaseMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::UseCaseUsage;
        :>> baseType =
            structuredUseCases meta SysML::UseCaseUsage;
    }


    metadata def <scenario>
        UseCaseScenarioMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::ActionUsage;
        :>> baseType =
            useCaseScenarios meta SysML::ActionUsage;
    }


    metadata def <basic>
        BasicScenarioMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::ActionUsage;
        :>> baseType =
            basicScenarios meta SysML::ActionUsage;
    }


    metadata def <alternate>
        AlternateScenarioMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::ActionUsage;
        :>> baseType =
            alternateScenarios meta SysML::ActionUsage;
    }


    metadata def <exception>
        ExceptionScenarioMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::ActionUsage;
        :>> baseType =
            exceptionScenarios meta SysML::ActionUsage;
    }


    metadata def <step>
        UseCaseStepMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::ActionUsage;
        :>> baseType =
            useCaseSteps meta SysML::ActionUsage;
    }


    metadata def <precondition>
        UseCasePreconditionMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::ConstraintUsage;
        :>> baseType =
            useCasePreconditions meta SysML::ConstraintUsage;
    }


    metadata def <postcondition>
        UseCasePostconditionMetadata :> SemanticMetadata {

        :> annotatedElement : SysML::ConstraintUsage;
        :>> baseType =
            useCasePostconditions meta SysML::ConstraintUsage;
    }
}
