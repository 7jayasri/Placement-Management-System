import { LightningElement, api } from 'lwc';

export default class JobCard extends LightningElement {
    @api job;

    handleViewDetails() {
        this.dispatchEvent(
            new CustomEvent('viewdetails', {
                detail: this.job
            })
        );
    }

    handleApply() {
        console.log('APPLY CLICKED');

        this.dispatchEvent(
            new CustomEvent('apply', {
                detail: this.job
            })
        );
    }
}