package WithdrawCash_ATM_Example {

    private import StructuredUseCases::*;


    #structuredUseCase use case 'Withdraw Cash from ATM' {

        #precondition constraint 'ATM is available for withdrawal';


        // ============================================================
        // Basic Scenario
        // ============================================================

        #basic action 'B Successful Withdrawal' {

            attribute :>> scenarioId = "B";

            #step action '1 Customer inserts card' {
                attribute :>> stepId = "1";
            }

            #step action '2 Customer enters PIN' {
                attribute :>> stepId = "2";
            }

            #step action '3 ATM authenticates customer' {
                attribute :>> stepId = "3";
            }

            #step action '4 Customer selects withdrawal' {
                attribute :>> stepId = "4";
            }

            #step action '5 Customer enters amount' {
                attribute :>> stepId = "5";
            }

            #step action '6 ATM checks available funds' {
                attribute :>> stepId = "6";
            }

            #step action '7 ATM debits account' {
                attribute :>> stepId = "7";
            }

            #step action '8 ATM dispenses cash' {
                attribute :>> stepId = "8";
            }

            #step action '9 ATM returns card' {
                attribute :>> stepId = "9";
            }

            first start then '1 Customer inserts card';
            first '1 Customer inserts card'
                then '2 Customer enters PIN';
            first '2 Customer enters PIN'
                then '3 ATM authenticates customer';
            first '3 ATM authenticates customer'
                then '4 Customer selects withdrawal';
            first '4 Customer selects withdrawal'
                then '5 Customer enters amount';
            first '5 Customer enters amount'
                then '6 ATM checks available funds';
            first '6 ATM checks available funds'
                then '7 ATM debits account';
            first '7 ATM debits account'
                then '8 ATM dispenses cash';
            first '8 ATM dispenses cash'
                then '9 ATM returns card';
            first '9 ATM returns card' then done;

            #postcondition constraint
                'Cash dispensed and account debited';
        }


        // ============================================================
        // Exception Scenario 3E
        // ============================================================

        #exception action '3E Authentication Failure' {

            attribute :>> scenarioId = "3E";

            #step action '3E.1 ATM rejects PIN' {
                attribute :>> stepId = "3E.1";
            }

            #step action
                '3E.2 ATM notifies customer of authentication failure' {
                attribute :>> stepId = "3E.2";
            }

            #step action '3E.3 ATM returns card' {
                attribute :>> stepId = "3E.3";
            }

            succession 'Branch after Step 3'
                first start
                then '3E.1 ATM rejects PIN';

            first '3E.1 ATM rejects PIN'
                then
                '3E.2 ATM notifies customer of authentication failure';

            first
                '3E.2 ATM notifies customer of authentication failure'
                then '3E.3 ATM returns card';

            first '3E.3 ATM returns card' then done;

            #postcondition constraint
                'Authentication failed and card returned';
        }


        // ============================================================
        // Alternate Scenario 4A
        // ============================================================

        #alternate action '4A Cancel Withdrawal' {

            attribute :>> scenarioId = "4A";

            #step action '4A.1 Customer cancels transaction' {
                attribute :>> stepId = "4A.1";
            }

            #step action '4A.2 ATM returns card' {
                attribute :>> stepId = "4A.2";
            }

            #step action '4A.3 Rejoin after Step 9' {
                attribute :>> stepId = "4A.3";
            }

            succession 'Branch after Step 4'
                first start
                then '4A.1 Customer cancels transaction';

            first '4A.1 Customer cancels transaction'
                then '4A.2 ATM returns card';

            first '4A.2 ATM returns card'
                then '4A.3 Rejoin after Step 9';

            first '4A.3 Rejoin after Step 9' then done;

            #postcondition constraint
                'Transaction cancelled and card returned';
        }


        // ============================================================
        // Alternate Scenario 6A
        // ============================================================

        #alternate action '6A Enter Smaller Amount' {

            attribute :>> scenarioId = "6A";

            #step action
                '6A.1 Notify customer of insufficient funds' {
                attribute :>> stepId = "6A.1";
            }

            #step action '6A.2 Prompt for smaller amount' {
                attribute :>> stepId = "6A.2";
            }

            #step action '6A.3 Customer enters smaller amount' {
                attribute :>> stepId = "6A.3";
            }

            #step action '6A.4 Rejoin before Step 6' {
                attribute :>> stepId = "6A.4";
            }

            succession 'Branch after Step 6'
                first start
                then '6A.1 Notify customer of insufficient funds';

            first '6A.1 Notify customer of insufficient funds'
                then '6A.2 Prompt for smaller amount';

            first '6A.2 Prompt for smaller amount'
                then '6A.3 Customer enters smaller amount';

            first '6A.3 Customer enters smaller amount'
                then '6A.4 Rejoin before Step 6';

            first '6A.4 Rejoin before Step 6' then done;

            #postcondition constraint
                'Smaller withdrawal amount entered';
        }
    }
}
