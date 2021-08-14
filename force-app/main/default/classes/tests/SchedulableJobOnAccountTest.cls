@isTest
public class SchedulableJobOnAccountTest {
    @isTest
    public static void testExecute() {
        Test.startTest();
        Id jobId = System.schedule('Test Job', '0 0 * * * ?', new SchedulableJobOnAccount());
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }
}