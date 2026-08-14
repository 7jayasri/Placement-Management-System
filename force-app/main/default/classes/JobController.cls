public with sharing class JobController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs() {

        Id currentUserId = UserInfo.getUserId();

        List<Student__c> students = [
            SELECT Id, Name, Branch__c, CGPA__c
            FROM Student__c
            WHERE Salesforce_User__c = :currentUserId
            LIMIT 1
        ];

        if (students.isEmpty()) {
            throw new AuraHandledException(
                'No Student record is linked to the current Salesforce User.'
            );
        }

        Student__c student = students[0];

        List<Job__c> jobs = [
            SELECT Id,
                   Name,
                   Company__c,
                   Package__c,
                   Location__c,
                   Closing_Date__c,
                   Eligible_Branch__c,
                   Minimum_CGPA__c
            FROM Job__c
            ORDER BY Closing_Date__c ASC
        ];

        List<Job__c> eligibleJobs = new List<Job__c>();

        for (Job__c job : jobs) {

            Boolean cgpaEligible =
                student.CGPA__c >= job.Minimum_CGPA__c;

            Boolean branchEligible =
                student.Branch__c == job.Eligible_Branch__c;

            if (cgpaEligible && branchEligible) {
                eligibleJobs.add(job);
            }
        }

        return eligibleJobs;
    }
}