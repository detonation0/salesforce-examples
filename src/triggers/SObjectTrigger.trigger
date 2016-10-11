// Example of a TriggerDispatcher being called from a trigger
trigger SObjectTrigger on SObject (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerDispatcher.Run(new SObjectTriggerHandler());
}
