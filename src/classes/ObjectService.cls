public class ObjectService {
    private static Integer s_num = 1;

    /**
     * Returns the picklist values for the given object and field
     * @param field The SObjectField in question, should be a picklist field
     * @return List<Schema.PicklistEntry>
     */
    public static List<Schema.PicklistEntry> getPicklistValues(Schema.SObjectField field) {
        Schema.DescribeFieldResult fieldResult = field.getDescribe();
        return fieldResult.getPicklistValues();
    }

    /**
     * Generates a fake Id for the given object type
     * Comes from this SE post: http://salesforce.stackexchange.com/questions/21137/creating-unit-tests-without-interacting-with-the-database-creating-fake-ids
     * DO NOT INSERT RECORDS WITH FAKE IDS INTO DB. It will error.
     * @param sot A Schema.SObjectType
     * @return String A fake Id for the given SObjectType
     */
    public static Id getFakeId(Schema.SObjectType sot) {
        String result = String.valueOf(s_num++);
        return Id.valueOf(sot.getDescribe().getKeyPrefix() + '0'.repeat(12-result.length()) + result);
    }

    public static Set<Id> getAssociatedObjectIds(List<SObject> objects, DescribeSObjectResult schemaDescribe) {
        Set<Id> associatedIds = new Set<Id>();
        String objectPrefix = schemaDescribe.getKeyPrefix();

        for (SObject obj : objects) {
            String whatId = String.valueof(obj.get('WhatId'));

            if (String.isNotBlank(whatId) && whatId.startsWith(objectPrefix)) {
                associatedIds.add(Id.valueOf(whatId));
            }
        }

        return associatedIds;
    }
}
