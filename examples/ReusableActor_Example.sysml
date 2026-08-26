package ReusableActor_Example {

    private import StructuredUseCases::*;


    // One reusable external actor.
    #useCaseActor part customer;


    // Three Structured Use Cases.
    #structuredUseCase use case 'Withdraw Cash';
    #structuredUseCase use case 'Check Balance';
    #structuredUseCase use case 'Deposit Funds';


    // The same actor participates in all three use cases.
    connection 'Customer - Withdraw Cash'
        connect customer to 'Withdraw Cash';

    connection 'Customer - Check Balance'
        connect customer to 'Check Balance';

    connection 'Customer - Deposit Funds'
        connect customer to 'Deposit Funds';
}
