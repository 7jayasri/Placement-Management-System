public with sharing class StudentSummaryController {

    @AuraEnabled(cacheable=true)
    public static Student__c getStudentSummary() {

        List<Student__c> students = [
            SELECT Id,
                   Name,
                   Branch__c,
                   CGPA__c,
                   Graduation_Year__c
            FROM Student__c
            WHERE Salesforce_User__c = :UserInfo.getUserId()
            LIMIT 1
        ];

        if (students.isEmpty()) {
            return null;
        }

        return students[0];
    }
}