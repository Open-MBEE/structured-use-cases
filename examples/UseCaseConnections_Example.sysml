package UseCaseConnections_Example {

    private import StructuredUseCases::*;


    #structuredUseCase use case 'Withdraw Cash';
    #structuredUseCase use case 'Validate PIN';
    #structuredUseCase use case 'Print Receipt';
    #structuredUseCase use case 'Check Balance';
    #structuredUseCase use case 'Select Account';


    // Simple named use-case-to-use-case connections.
    connection 'include'
        connect 'Withdraw Cash' to 'Validate PIN';

    connection 'extend'
        connect 'Print Receipt' to 'Withdraw Cash';

    connection 'invoke'
        connect 'Withdraw Cash' to 'Select Account';

    connection 'precede'
        connect 'Check Balance' to 'Withdraw Cash';
}
