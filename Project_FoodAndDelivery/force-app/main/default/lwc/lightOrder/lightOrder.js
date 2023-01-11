import { LightningElement, track } from 'lwc';
import ORDER_OBJECT from '@salesforce/schema/Order';
import ACCOUNTID_FIELD from '@salesforce/schema/Order.AccountId';
import DATE_FIELD from '@salesforce/schema/Order.EffectiveDate';
import STATUS_FIELD from '@salesforce/schema/Order.Status';
import SHIPTO_FIELD from '@salesforce/schema/Order.ShipToContactId';
import newOrder from '@salesforce/apex/CreateOrder.newOrder';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LightOrder extends LightningElement {

    /*@track accid = ACCOUNTID_FIELD;
    @track status = STATUS_FIELD;
    @track shipto = SHIPTO_FIELD;


    status;
    options = [
        {value: "Confirmed", label: "Confirmed"},
        {value: "Delivered", label: "Delivered"},
        {value: "In preparation", label: "In preparation",}
    ]

    rec = {
        Accid : this.accid,
        Date : this.date,   
        Status : this.status,
        Shipto : this.shipto,
    }

    handleAccountChange(event){
        this.rec.Accid = event.target.value;
        console.log(this.rec.Accid);
    }
    
    handleStatusChange(event) {
        this.rec.Status = event.target.value;
        console.log(this.rec.Status);
    }

    handleShiptoChange(event) {
        this.rec.Shipto = event.target.value;
        console.log(this.rec.Shipto);
    @track date = DATE_FIELD;

    rec = {
        Date : this.date,  
    }
    handleDateChange(event) {
        this.rec.Date = event.target.value;
        console.log(this.rec.Date);
    }
    */

    handleClick(){
        newOrder({input : 'Draft'})
        .then(result => {
            this.message = result;
            this.error = undefined;
            if(this.message !== undefined) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Order created Succesfully',
                        variant: 'success',
                    }),
                );
            }
            
            console.log(JSON.stringify(result));
            console.log("result", this.message);
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Failed to Insert order',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
            console.log("error", JSON.stringify(this.error));
        });
    };
}