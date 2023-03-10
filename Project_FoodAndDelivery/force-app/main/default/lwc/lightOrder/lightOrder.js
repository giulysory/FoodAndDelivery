import { LightningElement, track } from 'lwc';
import ORDER_OBJECT from '@salesforce/schema/Order';
import newOrder from '@salesforce/apex/CreateOrder.newOrder';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LightOrder extends LightningElement {
    
    @track AccountId;
    @track ShipToContactId;
    @track Status;
    @track EffectiveDate;

    handleAccountId(event){
        this.AccountId=event.target.value;
    }

    handleShipTo(event){
        this.ShipToContactId=event.target.value;
    }

    handleStatus(event){
        this.Status=event.target.value;
    }

    handleDate(event){
        this.EffectiveDate=event.target.value;
    }

    handleClick(){
        newOrder({acct : this.AccountId, ship : this.ShipToContactId, state : this.Status, day : this.EffectiveDate})
        .then(result => {
            this.message = result;
            this.error = undefined;
            if(this.message !== undefined) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Order created succesfully!',
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
                    title: 'Failed to insert order!',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
            console.log("error", JSON.stringify(this.error));
        });
    };
}