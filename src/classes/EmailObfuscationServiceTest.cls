/**
* @author detonation0
* @date 1/2/18
*
* Unit Tests for EmailObfuscationServiceTest
*/
@isTest
private class EmailObfuscationServiceTest {
    @isTest
    static void testObfuscation() {
        // Arrange
        List<Contact> testContacts = new List<Contact>();

        for (Integer i = 0; i < 500; i++) {
            testContacts.add(new Contact(
                FirstName = 'Test' + i,
                LastName = 'Contact' + i,
                Email = 'test' + i + '@nomail.com'
            ));
        }

        // Act
        Test.startTest();
        EmailObfuscationService.obfuscateFields(testContacts);
        Test.stopTest();

        // Assert
        if ([SELECT IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()].isSandbox) {
            for (Contact c : testContacts) {
                System.assert(c.Email.endsWith('.test'));
            }
        } else {
            for (Contact c : testContacts) {
                System.assert(!c.Email.endsWith('.test'));
            }
        }
    }
}
