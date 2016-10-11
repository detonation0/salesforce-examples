// Change Lead to whatever SObject you're using.
public class SObjectTriggerHandler implements ITriggerHandler {
    // You can set this static boolean from apex in this namespace if you want to bypass this trigger
    public static Boolean disable = false;

    public Boolean isDisabled() {
        Boolean isDisabled = false;

        if (disable) {
            // We have to check to make sure that some apex hasn't disabled this trigger in this context yet
            isDisabled = true;
        } else if (!Test.isRunningTest()) {
            // Get custom metadata setting for this trigger, unless we're running a test
            try {
                TriggerSwitch__mdt triggerSwitch = [
                    select isDisabled__c
                    from TriggerSwitch__mdt
                    where DeveloperName = 'NameOfTriggerMdt'
                ];

                isDisabled = triggerSwitch.isDisabled__c;
            } catch (QueryException e) {
                // We may not have deployed the TriggerSwitch, so just default to false.
                isDisabled = false;
            }
        }

        return isDisabled;
    }

    public void beforeInsert(List<SObject> newItems) {
        List<Lead> newSObjects = (List<Lead>) newItems;

        // Call service classes and pass newItems here.
	}

    public void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        Map<Id, Lead> newSObjects = (Map<Id, Lead>) newItems;
        Map<Id, Lead> oldSObjects = (Map<Id, Lead>) oldItems;
    }

    public void beforeDelete(Map<Id, SObject> oldItems) {
        Map<Id, Lead> oldSObjects = (Map<Id, Lead>) oldItems;
    }

    public void afterInsert(Map<Id, SObject> newItems) {
        Map<Id, Lead> newSObjects = (Map<Id, Lead>) newItems;
    }

    public void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        Map<Id, Lead> newSObjects = (Map<Id, Lead>) newItems;
        Map<Id, Lead> oldSObjects = (Map<Id, Lead>) oldItems;
    }

    public void afterDelete(Map<Id, SObject> oldItems) {
        Map<Id, Lead> oldSObjects = (Map<Id, Lead>) oldItems;
    }

    public void afterUndelete(Map<Id, SObject> oldItems) {
        Map<Id, Lead> oldSObjects = (Map<Id, Lead>) oldItems;
    }
}
