import { LightningElement, wire } from 'lwc';
import getOffers from '@salesforce/apex/OfferSummaryController.getOffers';

export default class OfferSummary extends LightningElement {

    offers = [];
    error;

    @wire(getOffers)
    wiredOffers({ data, error }) {
        if (data) {
            this.offers = data;
            this.error = undefined;
        } else if (error) {
            this.offers = [];
            this.error = error;
        }
    }
}