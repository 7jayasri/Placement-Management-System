public with sharing class OfferSummaryController {

    @AuraEnabled(cacheable=true)
    public static List<Application__c> getOffers() {

        List<Student__c> students = [
            SELECT Id
            FROM Student__c
            WHERE Salesforce_User__c = :UserInfo.getUserId()
            LIMIT 1
        ];

        if (students.isEmpty()) {
            return new List<Application__c>();
        }

        return [
            SELECT Id,
                   Application_Date__c,
                   Status__c,
                   Job__c,
                   Job__r.Name,
                   Job__r.Company__c,
                   Job__r.Package__c,
                   Job__r.Location__c
            FROM Application__c
            WHERE Student__c = :students[0].Id
            AND Status__c = 'SELECTED'
            ORDER BY Application_Date__c DESC
        ];
    }
}
