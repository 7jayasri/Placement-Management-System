@isTest
public class ApplicationServiceTest {

    @isTest
    static void testSubmitApplication() {

        // Create Student
        Student__c student = new Student__c(
            Name = 'Rahul',
            Email__c = 'rahul@gmail.com',
            CGPA__c = 8.5,
            Branch__c = 'CSE',
            Active_Backlogs__c = 0,
            Graduation_Year__c = 2027
        );
        insert student;

        // Create Job
        Job__c job = new Job__c(
            Name = 'Software Engineer',
            Company__c = 'TCS',
            Minimum_CGPA__c = 7.5,
            Eligible_Branch__c = 'CSE',
            Backlog_Limit__c = 0,
            Closing_Date__c = Date.today().addDays(10)
        );
        insert job;

        Test.startTest();

        String result =
            ApplicationService.submitApplication(student.Id, job.Id);

        Test.stopTest();

        System.assertEquals(
            'Application Submitted Successfully',
            result
        );
    }

    @isTest
    static void testDuplicateApplication() {

        Student__c student = new Student__c(
            Name='Student1',
            Email__c='student1@gmail.com',
            CGPA__c=9,
            Branch__c='CSE',
            Active_Backlogs__c=0,
            Graduation_Year__c=2027
        );
        insert student;

        Job__c job = new Job__c(
            Name='Developer',
            Company__c='Infosys',
            Minimum_CGPA__c=7,
            Eligible_Branch__c='CSE',
            Backlog_Limit__c=0,
            Closing_Date__c=Date.today().addDays(5)
        );
        insert job;

        ApplicationService.submitApplication(student.Id, job.Id);

        String result =
            ApplicationService.submitApplication(student.Id, job.Id);

        System.assert(
            result.contains('Duplicate')
        );
    }
    @isTest
static void testLowCGPA() {

    Student__c student = new Student__c(
        Name='Low CGPA',
        Email__c='low@test.com',
        CGPA__c=6.0,
        Branch__c='CSE',
        Active_Backlogs__c=0,
        Graduation_Year__c=2027
    );
    insert student;

    Job__c job = new Job__c(
        Name='Developer',
        Company__c='Infosys',
        Minimum_CGPA__c=7.5,
        Eligible_Branch__c='CSE',
        Backlog_Limit__c=0,
        Closing_Date__c=Date.today().addDays(5)
    );
    insert job;

    String result =
        ApplicationService.submitApplication(student.Id, job.Id);

    System.assert(result.contains('CGPA'));
}
@isTest
static void testBranchValidation() {

    Student__c student = new Student__c(
        Name='Branch Test',
        Email__c='branch@test.com',
        CGPA__c=9,
        Branch__c='ECE',
        Active_Backlogs__c=0,
        Graduation_Year__c=2027
    );
    insert student;

    Job__c job = new Job__c(
        Name='Developer',
        Company__c='Infosys',
        Minimum_CGPA__c=7,
        Eligible_Branch__c='CSE',
        Backlog_Limit__c=0,
        Closing_Date__c=Date.today().addDays(5)
    );
    insert job;

    String result =
        ApplicationService.submitApplication(student.Id, job.Id);

    System.assert(result.contains('Branch'));
}
@isTest
static void testBacklogValidation() {

    Student__c student = new Student__c(
        Name='Backlog Test',
        Email__c='back@test.com',
        CGPA__c=9,
        Branch__c='CSE',
        Active_Backlogs__c=3,
        Graduation_Year__c=2027
    );
    insert student;

    Job__c job = new Job__c(
        Name='Developer',
        Company__c='Infosys',
        Minimum_CGPA__c=7,
        Eligible_Branch__c='CSE',
        Backlog_Limit__c=0,
        Closing_Date__c=Date.today().addDays(5)
    );
    insert job;

    String result =
        ApplicationService.submitApplication(student.Id, job.Id);

    System.assert(result.contains('backlogs'));
}
@isTest
static void testDeadlineExpired() {

    Student__c student = new Student__c(
        Name='Deadline',
        Email__c='dead@test.com',
        CGPA__c=9,
        Branch__c='CSE',
        Active_Backlogs__c=0,
        Graduation_Year__c=2027
    );
    insert student;

    Job__c job = new Job__c(
        Name='Developer',
        Company__c='Infosys',
        Minimum_CGPA__c=7,
        Eligible_Branch__c='CSE',
        Backlog_Limit__c=0,
        Closing_Date__c=Date.today().addDays(-1)
    );
    insert job;

    String result =
        ApplicationService.submitApplication(student.Id, job.Id);

    System.assert(result.contains('deadline'));
}
@isTest
static void testUpdateStatus() {

    Student__c student = new Student__c(
        Name='Status',
        Email__c='status@test.com',
        CGPA__c=9,
        Branch__c='CSE',
        Active_Backlogs__c=0,
        Graduation_Year__c=2027
    );
    insert student;

    Job__c job = new Job__c(
        Name='Developer',
        Company__c='Infosys',
        Minimum_CGPA__c=7,
        Eligible_Branch__c='CSE',
        Backlog_Limit__c=0,
        Closing_Date__c=Date.today().addDays(5)
    );
    insert job;

    Application__c app = new Application__c(
        Student__c=student.Id,
        Job__c=job.Id,
        Application_Date__c=Date.today(),
        Status__c='Applied'
    );
    insert app;

    String result =
        ApplicationService.updateApplicationStatus(app.Id,'Selected');

    System.assertEquals(
        'Application Status Updated Successfully',
        result
    );
}
@isTest
static void testTriggerValidation() {

    Application__c app = new Application__c();

    Test.startTest();

    Boolean exceptionThrown = false;

    try{
        insert app;
    }
    catch(DmlException e){
        exceptionThrown = true;
    }

    Test.stopTest();

    System.assertEquals(true, exceptionThrown);
}
@isTest
static void testStatusUpdateTrigger() {

    Student__c student = new Student__c(
        Name='Test Student',
        Email__c='test@test.com',
        CGPA__c=8.5,
        Branch__c='CSE',
        Active_Backlogs__c=0,
        Graduation_Year__c=2027
    );
    insert student;

    Job__c job = new Job__c(
        Name='Developer',
        Company__c='Infosys',
        Minimum_CGPA__c=7.5,
        Eligible_Branch__c='CSE',
        Backlog_Limit__c=0,
        Closing_Date__c=Date.today().addDays(10)
    );
    insert job;

    Application__c app = new Application__c(
        Student__c=student.Id,
        Job__c=job.Id,
        Status__c='Applied',
        Application_Date__c=Date.today()
    );
    insert app;

    Test.startTest();

    app.Status__c='Selected';
    update app;

    Test.stopTest();

    Application__c updatedApp =
        [SELECT Status__c FROM Application__c WHERE Id=:app.Id];

    System.assertEquals('Selected',updatedApp.Status__c);
}

}
