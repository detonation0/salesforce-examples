// Read up on the implements options for your use case.
global class BatchExample implements Database.batchable<sObject>, Database.stateful, Schedulable {
    global void execute(SchedulableContext sc) {
        // Schedulable context only
        Database.executeBatch(this);
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Build query locator string here
        String queryString 'query string here';

        return Database.getQueryLocator(queryString);
    }

     global void execute(Database.BatchableContext BC, List<sObject> scope) {
        // Execute code on scope, cast as whatever List you want.
    }

    global void finish(Database.BatchableContext BC) {
        // Finish, whatever you want really, sometimes an email notification.
    }
}
