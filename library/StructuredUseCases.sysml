library package StructuredUseCases {

    private import ScalarValues::*;
    private import SysML::*;


    // ------------------------------------------------------------
    // Diagram endpoints
    // ------------------------------------------------------------

    part def Endpoint;


    part def Actor :> Endpoint {
        attribute name : String;
        attribute description : String [0..1];
    }


    // ------------------------------------------------------------
    // Structured use case specification
    // ------------------------------------------------------------

    part def Step {
        attribute stepNumber : String;
        attribute description : String;
    }


    part def Scenario {
        attribute name : String;
        attribute description : String [0..1];
        attribute postcondition : String [0..1];

        part step : Step [0..*];
    }


    part def UseCase :> Endpoint {
        attribute name : String;
        attribute description : String [0..1];

        part basicScenario : Scenario [0..1];
        part alternateScenario : Scenario [0..*];
        part exceptionScenario : Scenario [0..*];
    }


    // ------------------------------------------------------------
    // Diagram associations
    // ------------------------------------------------------------

    part def Association {
        ref part end1 : Endpoint;
        ref part end2 : Endpoint;
    }


    // ------------------------------------------------------------
    // Use case diagram
    // ------------------------------------------------------------

    part def UseCaseDiagram {
        attribute name : String;

        part diagramActor : Actor [0..*];
        part useCase : UseCase [0..*];
        part association : Association [0..*];
    }


    part useCaseModel : UseCaseDiagram;
}
