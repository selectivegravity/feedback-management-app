@isTest
public class FeedbackControllerTest {

    @isTest
    static void testSaveFeedback() {
        // Create a test instance of the FeedbackController
        FeedbackController controller = new FeedbackController();
        
        // Set up test data for the Feedback record
        controller.feedback.Name__c = 'Test Feedback';
        controller.feedback.Email__c = 'test@example.com';
        controller.feedback.Phone__c = '123-456-7890';
        controller.feedback.Comment__c = 'This is a test comment.';
        controller.feedback.Type__c = 'Positive';
        
        // Call the save method
        Test.startTest();
        controller.save();
        Test.stopTest();
        
        // Verify that the record was inserted
        Feedback__c feedbackRecord = [SELECT Id, Name__c, Email__c, Phone__c, Comment__c, Type__c 
                                      FROM Feedback__c 
                                      WHERE Email__c = 'test@example.com' 
                                      LIMIT 1];
        
        System.assertNotEquals(null, feedbackRecord, 'The Feedback record should have been created.');
        System.assertEquals('Test Feedback', feedbackRecord.Name__c, 'The Feedback Name should match the input.');
        System.assertEquals('test@example.com', feedbackRecord.Email__c, 'The Email should match the input.');
        System.assertEquals('123-456-7890', feedbackRecord.Phone__c, 'The Phone should match the input.');
        System.assertEquals('This is a test comment.', feedbackRecord.Comment__c, 'The Comment should match the input.');
        System.assertEquals('Positive', feedbackRecord.Type__c, 'The Type should match the input.');
    }
    
    @isTest
    static void testSaveFeedbackWithException() {
        // Create a test instance of the FeedbackController
        FeedbackController controller = new FeedbackController();
        
        // Set up test data with missing required fields to trigger an exception
        controller.feedback.Email__c = 'test@example.com';
        // Missing Name__c (required field)
        
        // Call the save method
        Test.startTest();
        try {
            controller.save();
            System.assert(true, 'An exception should have been thrown.');
        } catch (DmlException e) {
            // Check that the exception is due to the missing required field
            System.assert(e.getMessage().contains('Required fields are missing'), 'Expected a DML exception.');
        }
        Test.stopTest();
    }
}