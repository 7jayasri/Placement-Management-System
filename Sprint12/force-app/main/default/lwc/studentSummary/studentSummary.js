import { LightningElement, wire } from 'lwc';
import getStudentSummary from '@salesforce/apex/StudentSummaryController.getStudentSummary';

export default class StudentSummary extends LightningElement {

    student;
    error;

    @wire(getStudentSummary)
    wiredStudent({ data, error }) {
        if (data) {
            this.student = data;
            this.error = undefined;
        } else if (error) {
            this.student = undefined;
            this.error = error;
        }
    }
}