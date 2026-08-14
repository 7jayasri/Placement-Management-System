public with sharing class ApplicationController {

    @AuraEnabled
    public static Id applyToJob(Id jobId) {

        if (jobId == null) {
            throw new AuraHandledException('Job is required.');
        }

        // Find the Student linked to the current Salesforce User
        List<Student__c> students = [
            SELECT Id, Name
            FROM Student__c
            WHERE Salesforce_User__c = :UserInfo.getUserId()
            LIMIT 1
        ];

        if (students.isEmpty()) {
            throw new AuraHandledException(
                'No Student record is linked to your Salesforce User.'
            );
        }

        Student__c student = students[0];

        // Prevent duplicate applications
        List<Application__c> existingApplications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :student.Id
            AND Job__c = :jobId
            LIMIT 1
        ];

        if (!existingApplications.isEmpty()) {
            throw new AuraHandledException(
                'You have already applied for this job.'
            );
        }

        // Create application
        Application__c application = new Application__c(
            Student__c = student.Id,
            Job__c = jobId,
            Status__c = 'APPLIED',
            Application_Date__c = Date.today()
        );

        insert application;

        return application.Id;
    }
}