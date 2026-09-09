library package StructuredTesting {

    private import Actions::Action;
    private import Actions::actions;
    private import VerificationCases::*;
    private import Metaobjects::SemanticMetadata;
    private import StructuredUseCases::*;

    // Test Step
    action def TestStep :> UseCaseStep;

    abstract action testSteps :
        TestStep[0..*] nonunique
        :> actions;

    // Test Scenario
    action def TestScenario :> UseCaseScenario {
        action testStep : TestStep[0..*]
            :> subactions, testSteps;

        attribute verdict : VerdictKind[0..1];
    }

    abstract action testScenarios :
        TestScenario[0..*] nonunique
        :> actions;

    // Structured Test Case
    verification def StructuredTestCase {
        action testScenario : TestScenario[1..*]
            :> subactions, testScenarios;
    }


    /*
     * Behavioral verification relationships.
     *
     * SysML v2 provides dependency usages, but the textual language does not
     * provide a "dependency def" construct for defining a reusable typed
     * dependency. These are therefore modeled as typed connection definitions
     * with constrained ends so that the relationship semantics are explicit
     * and queryable.
     */

    connection def VerifyUseCase {
        end testCase : StructuredTestCase;
        end useCase : StructuredUseCase;
    }

    connection def VerifyScenario {
        end testScenario : TestScenario;
        end useCaseScenario : UseCaseScenario;
    }

    /*
     * Semantic metadata for the three user-facing structured
     * testing concepts.
     */
    metadata def <testStep>
        TestStepMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ActionUsage;
        :>> baseType =
            testSteps meta SysML::ActionUsage;
    }

    metadata def <testScenario>
        TestScenarioMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ActionUsage;
        :>> baseType =
            testScenarios meta SysML::ActionUsage;
    }

    metadata def <structuredTestCase>
        StructuredTestCaseMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::VerificationCaseUsage;
        :>> baseType =
            StructuredTestCase meta SysML::VerificationCaseUsage;
    }
}
