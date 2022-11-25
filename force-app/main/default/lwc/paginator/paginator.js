import { LightningElement, api } from 'lwc';

export default class Paginator extends LightningElement {
    @api numberPage;
    @api quantityPages;
    isPreviousButtonDisabled = true;
    isNextButtonDisabled = false;

    connectedCallback(){
        if (this.quantityPages ==1 ){
            isPreviousButtonDisabled = true;
            isNextButtonDisabled = true;
        }
    }


    previousPage(){
        --this.numberPage;
        this.isNextButtonDisabled = false;
        if(this.numberPage == 1) this.isPreviousButtonDisabled=true;
        this.createEvent();
    }

    nextPage(){
        ++this.numberPage;
        this.isPreviousButtonDisabled = false;
        if(this.numberPage == this.quantityPages) this.isNextButtonDisabled=true;
        this.createEvent();
    }

    createEvent(){
        this.dispatchEvent(new CustomEvent("page", {
            detail: this.numberPage,
        }));
    }

}