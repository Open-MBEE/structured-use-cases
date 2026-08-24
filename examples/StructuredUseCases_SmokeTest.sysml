package StructuredUseCases_SmokeTest {

    private import StructuredUseCases::*;


    // TEST 1 — Core definitions resolve

    part testEndpoint : Endpoint;
    part testActor : Actor;
    part testStep : Step;
    part testScenario : Scenario;
    part testUseCase : UseCase;
    part testAssociation : Association;
    part testUseCaseDiagram : UseCaseDiagram;


    // TEST 2 — Multiple endpoint types can coexist

    part actorEndpoint : Actor;
    part useCaseEndpoint : UseCase;


    // TEST 3 — Association accepts Actor and UseCase endpoints

    part actorToUseCase : Association {
        ref part end1 = actorEndpoint;
        ref part end2 = useCaseEndpoint;
    }


    // TEST 4 — Association is intentionally permissive:
    // Actor-to-Actor is allowed because both are Endpoints

    part actorEndpoint2 : Actor;

    part actorToActor : Association {
        ref part end1 = actorEndpoint;
        ref part end2 = actorEndpoint2;
    }


    // TEST 5 — UseCase-to-UseCase is also allowed

    part useCaseEndpoint2 : UseCase;

    part useCaseToUseCase : Association {
        ref part end1 = useCaseEndpoint;
        ref part end2 = useCaseEndpoint2;
    }


    // TEST 6 — String step identifiers resolve

    part stringStep : Step {
        attribute stepNumber = "4A.1";
        attribute description =
            "Smoke-test step using a structured string identifier.";
    }


    // TEST 7 — More than one diagram instance can exist

    part secondUseCaseDiagram : UseCaseDiagram;
}
