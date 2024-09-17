public class FeedbackController {
    public Feedback__c feedback { get; set; }

    public FeedbackController() {
        feedback = new Feedback__c();
    }

    // Method to save the feedback record
    public PageReference save() {
        try {
            insert feedback;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Feedback record created successfully.'));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage()));
        }
        return null; // Stay on the same page after save
    }
}