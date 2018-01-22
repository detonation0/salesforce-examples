/**
* @author detonation0
* @date 1/22/18
*
* Used Obfuscate Email fields for Objects passed in in the test environments.
* Can use the whitelist var in a custom metdata type to whitelist certain emails (i.e. dev team).
* Usage: EmailObfuscationService.obfuscateFields(newObjects) in Trigger before context.
*/
public class EmailObfuscationService {
    private static Boolean isSandbox {
        get {
            if (isSandbox == null) {
                isSandbox = [SELECT IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()].isSandbox;
            }

            return isSandbox;
        }
        set;
    }

    private static Set<String> whitelist {
        get {
            if (whitelist == null) {
                whitelist = new Set<String>();

                for (Email_Obfuscation_Whitelist__mdt item : [
                    SELECT Email__c
                    FROM Email_Obfuscation_Whitelist__mdt
                ]) {
                    whitelist.add(item.Email__c);
                }
            }

            return whitelist;
        }
        set;
    }

    private static Map<String, Schema.SObjectType> globalDescribe {
        get {
            if (globalDescribe == null) {
                globalDescribe = Schema.getGlobalDescribe();
            }

            return globalDescribe;
        }
        set;
    }

    private static Map<String, Set<String>> objectTypeToFieldsMap {
        get {
            if (objectTypeToFieldsMap == null) {
                objectTypeToFieldsMap = new Map<String, Set<String>>();
            }

            return objectTypeToFieldsMap;
        }
        set;
    }

    /**
     * Obfuscates the Email fields on the Object by using getDescribe(). NOTE: Run this first before any other
     * trigger code to avoid problems with processes that depend on Email address.
     */
    public static void obfuscateFields(List<SObject> newObjects) {
        if (isSandbox) {
            for (SObject theObject : newObjects) {
                String sobjectType = String.valueOf(theObject.getSObjectType());

                if (!objectTypeToFieldsMap.containsKey(sobjectType)) {
                    Set<String> fields = new Set<String>();
                    for (Schema.SObjectField field : globalDescribe.get(sobjectType).getDescribe().fields.getMap().values()) {
                        if (Schema.DisplayType.EMAIL == field.getDescribe().getType()) {
                            fields.add(field.getDescribe().getName());
                        }
                    }
                    objectTypeToFieldsMap.put(sobjectType, fields);
                }

                if (objectTypeToFieldsMap.containsKey(sobjectType)) {
                    for (String field : objectTypeToFieldsMap.get(sobjectType)) {
                        String emailFieldValue = String.valueOf(theObject.get(field));
                        if (!String.isBlank(emailFieldValue)) {
                            if (!emailFieldValue.endsWith('.test') && !whitelist.contains(emailFieldValue)) {
                                theObject.put(field, emailFieldValue + '.test');
                            }
                        }
                    }
                }
            }
        }
    }
}
