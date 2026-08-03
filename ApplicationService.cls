public with sharing class ApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {
        Student__c student = [
            SELECT Id, Name, CGPA__c, Branch__c, Active_Backlogs__c, Graduation_Year__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];
        Job__c job = [
            SELECT Id, Name, Minimum_CGPA__c, Eligible_Branch__c,
                   Backlog_Limit__c, Closing_Date__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        List<Application__c> existingApplications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
        ];

        if (!existingApplications.isEmpty()) {
            return 'Duplicate Application! Student already applied.';
        }

        if (student.CGPA__c < job.Minimum_CGPA__c) {
            return 'Application Rejected: Minimum CGPA not satisfied.';
        }

        if (student.Branch__c != job.Eligible_Branch__c) {
            return 'Application Rejected: Branch not eligible.';
        }

        if (student.Active_Backlogs__c > job.Backlog_Limit__c) {
            return 'Application Rejected: Too many active backlogs.';
        }

        if (Date.today() > job.Closing_Date__c) {
            return 'Application Rejected: Application deadline is over.';
        }

        Application__c application = new Application__c();

        application.Student__c = studentId;
        application.Job__c = jobId;
        application.Application_Date__c = Date.today();
        application.Status__c = 'Applied';

        try {

            insert application;

            return 'Application Submitted Successfully';

        } catch (Exception e) {

            return e.getMessage();

        }
    }

    public static String updateApplicationStatus(Id applicationId, String status) {

        Application__c app = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        app.Status__c = status;

        update app;

        return 'Application Status Updated Successfully';
    }

}
