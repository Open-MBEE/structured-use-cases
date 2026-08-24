package StructuredUseCases_ATM_Test {

    private import StructuredUseCases::*;


    // ============================================================
    // ACTOR
    // ============================================================

    part def ATMCustomer :> Actor {

        attribute :>> name = "ATM Customer";
        attribute :>> description =
            "Bank customer using the ATM to withdraw cash.";
    }


    // ============================================================
    // BASIC SCENARIO
    // ============================================================

    part def SuccessfulWithdrawal :> Scenario {

        attribute :>> name = "Successful Cash Withdrawal";
        attribute :>> description =
            "Customer withdraws cash using a valid card and sufficient funds.";

        attribute :>> postcondition =
            "Cash is dispensed, the account is debited, and the card is returned.";

        part insertCard : Step {
            attribute stepNumber = "1";
            attribute description =
                "Customer inserts a valid bank card.";
        }

        part enterPIN : Step {
            attribute stepNumber = "2";
            attribute description =
                "ATM prompts for the PIN and the customer enters it.";
        }

        part selectWithdrawal : Step {
            attribute stepNumber = "3";
            attribute description =
                "Customer selects Withdraw Cash.";
        }

        part enterAmount : Step {
            attribute stepNumber = "4";
            attribute description =
                "Customer enters the requested withdrawal amount.";
        }

        part authorizeWithdrawal : Step {
            attribute stepNumber = "5";
            attribute description =
                "ATM verifies that the account has sufficient available funds.";
        }

        part dispenseCash : Step {
            attribute stepNumber = "6";
            attribute description =
                "ATM dispenses the requested cash.";
        }

        part completeTransaction : Step {
            attribute stepNumber = "7";
            attribute description =
                "ATM debits the account and returns the customer's card.";
        }
    }


    // ============================================================
    // ALTERNATE SCENARIO
    // ============================================================

    part def RequestDifferentAmount :> Scenario {

        attribute :>> name = "Request Different Amount";
        attribute :>> description =
            "ATM cannot dispense the requested denomination and asks the customer for another amount.";

        attribute :>> postcondition =
            "Customer enters a different withdrawal amount and withdrawal processing continues.";

        part amountUnavailable : Step {
            attribute stepNumber = "4A";
            attribute description =
                "ATM determines that the requested amount cannot be dispensed with available denominations.";
        }

        part notifyCustomer : Step {
            attribute stepNumber = "4A.1";
            attribute description =
                "ATM informs the customer that the requested amount cannot be dispensed.";
        }

        part requestNewAmount : Step {
            attribute stepNumber = "4A.2";
            attribute description =
                "Customer enters a different withdrawal amount.";
        }
    }


    // ============================================================
    // EXCEPTION SCENARIO
    // ============================================================

    part def InsufficientFunds :> Scenario {

        attribute :>> name = "Insufficient Funds";
        attribute :>> description =
            "The customer's account does not contain sufficient available funds.";

        attribute :>> postcondition =
            "No cash is dispensed and the account balance is unchanged.";

        part detectInsufficientFunds : Step {
            attribute stepNumber = "5E";
            attribute description =
                "ATM determines that available funds are less than the requested amount.";
        }

        part displayMessage : Step {
            attribute stepNumber = "5E.1";
            attribute description =
                "ATM informs the customer that sufficient funds are not available.";
        }

        part cancelWithdrawal : Step {
            attribute stepNumber = "5E.2";
            attribute description =
                "ATM cancels the withdrawal and returns to transaction selection.";
        }
    }


    // ============================================================
    // USE CASE
    // ============================================================

    part def WithdrawCash :> UseCase {

        attribute :>> name = "Withdraw Cash";

        attribute :>> description =
            "ATM Customer withdraws cash from a bank account.";

        part successfulWithdrawal : SuccessfulWithdrawal;
        part requestDifferentAmount : RequestDifferentAmount;
        part insufficientFunds : InsufficientFunds;
    }


    // ============================================================
    // TEST INSTANCES
    // ============================================================

    part atmCustomer : ATMCustomer;
    part withdrawCash : WithdrawCash;


    // ============================================================
    // ENDPOINT-BASED ASSOCIATION
    // ============================================================

    part customerWithdrawCash : Association {
        ref part end1 = atmCustomer;
        ref part end2 = withdrawCash;
    }


    // ============================================================
    // PERMISSIVENESS CHECK
    // A second use case can also be connected directly to a use case.
    // ============================================================

    part def CheckBalance :> UseCase {
        attribute :>> name = "Check Balance";
        attribute :>> description =
            "ATM Customer views the current account balance.";
    }

    part checkBalance : CheckBalance;

    part withdrawCashToCheckBalance : Association {
        ref part end1 = withdrawCash;
        ref part end2 = checkBalance;
    }
}
