import { LightningElement, wire } from 'lwc';
import getEligibleJobs from '@salesforce/apex/JobController.getEligibleJobs';
import applyToJob from '@salesforce/apex/ApplicationController.applyToJob';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EligibleJobs extends LightningElement {

    jobs = [];
    error;
    showDetails = false;
    selectedJob;

    @wire(getEligibleJobs)
    wiredJobs({ data, error }) {
        if (data) {
            this.jobs = data;
            this.error = undefined;
        } else if (error) {
            this.jobs = [];
            this.error = error;
        }
    }
async handleApply(event) {

    console.log('PARENT RECEIVED APPLY EVENT');
    console.log(event.detail);

    const jobId = event.detail.jobId;
    const jobName = event.detail.jobName;

    try {

        await applyToJob({
            jobId: jobId
        });

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Application Submitted',
                message: `Your application for ${jobName} has been submitted successfully.`,
                variant: 'success'
            })
        );

    } catch (error) {

        let message = 'Unable to submit application.';

        if (error?.body?.message) {
            message = error.body.message;
        }

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Application Failed',
                message: message,
                variant: 'error'
            })
        );
    }
}
handleViewDetails(event) {

    this.selectedJob = event.detail;
    this.showDetails = true;

}

handleCloseDetails() {

    this.showDetails = false;
    this.selectedJob = undefined;

}
}