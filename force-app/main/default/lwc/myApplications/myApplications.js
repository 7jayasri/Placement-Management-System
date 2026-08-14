import { LightningElement, wire } from 'lwc';
import getMyApplications from '@salesforce/apex/MyApplicationsController.getMyApplications';

export default class MyApplications extends LightningElement {

    applications = [];
    error;

    @wire(getMyApplications)
    wiredApplications({ data, error }) {
        if (data) {
            this.applications = data;
            this.error = undefined;
        } else if (error) {
            this.applications = [];
            this.error = error;
        }
    }
}