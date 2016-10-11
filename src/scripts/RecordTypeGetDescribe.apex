// Example: Account RecordType Info, can easily change SObjectType
Schema.DescribeSObjectResult describe = Account.SObjectType.getDescribe();
Map<String, Schema.RecordTypeInfo> acctRTInfo = describe.getRecordTypeInfosByName();

// Or more simply:
Map<String, Schema.RecordTypeInfo> accRTInfo = Account.SObjectType.getDescribe().getRecordTypeInfosByName();

// Access it
Id rtId = acctRTInfo.get('Record Type Name').getRecordTypeId();
